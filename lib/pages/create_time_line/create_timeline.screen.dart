import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/api/place/dto/location.dart';
import 'package:template/api/place/provider.dart';
import 'package:template/api/plan/dto/timeline.dart';
import 'package:template/common/constants/colors.dart';
import 'package:template/common/enums/loading_status.enum.dart';
import 'package:template/common/utils/share_preferences.dart';
import 'package:template/common/widgets/custom_date_picker.dart';
import 'package:template/common/widgets/custom_textfield.dart';
import 'package:template/common/widgets/error_dialog_utils.dart';
import 'package:template/pages/create_time_line/bloc/create_time_line.bloc.dart';
import 'package:template/pages/create_time_line/bloc/create_time_line.event.dart';
import 'package:template/pages/create_time_line/bloc/create_time_line.state.dart';
import 'package:template/pages/create_time_line/models/create_timeline_arguments.dart';

class CreateTimelineScreen extends StatefulWidget {
  final String? tripCode;
  final Timeline? timelineToEdit; // For edit mode

  const CreateTimelineScreen({
    Key? key,
    this.tripCode,
    this.timelineToEdit,
  }) : super(key: key);

  // Factory constructor for route arguments
  factory CreateTimelineScreen.fromArguments(CreateTimelineArguments? args) {
    return CreateTimelineScreen(
      tripCode: args?.tripCode,
      timelineToEdit: args?.timelineToEdit,
    );
  }

  @override
  State<CreateTimelineScreen> createState() => _CreateTimelineScreenState();
}

class _CreateTimelineScreenState extends State<CreateTimelineScreen> {
  final TextEditingController _destinationController = TextEditingController();
  final TextEditingController _budgetPerPersonController =
      TextEditingController();

  // DateTime? _startDate;
  // DateTime? _endDate;
  // TimeOfDay? _startTime;
  // TimeOfDay? _endTime;

  DateTime? _startTime;
  DateTime? _endTime;

  String _destinationError = '';
  String _budgetPerPersonError = '';
  String _startTimeError = '';
  String _endTimeError = '';

  // Search suggestions state
  List<Location> _locationSuggestions = [];
  bool _isSearching = false;
  bool _showSuggestions = false;
  Timer? _searchTimer;
  final FocusNode _destinationFocusNode = FocusNode();
  final GlobalKey _destinationFieldKey = GlobalKey();
  final LayerLink _layerLink = LayerLink();

  bool get isEditMode => widget.timelineToEdit != null;

  @override
  void initState() {
    super.initState();
    _initializeFormData();
    _destinationFocusNode.addListener(_onFocusChanged);
  }

  void _onFocusChanged() {
    if (!_destinationFocusNode.hasFocus) {
      // Add small delay to allow user to tap on suggestions
      Future.delayed(const Duration(milliseconds: 150), () {
        if (mounted && !_destinationFocusNode.hasFocus) {
          setState(() {
            _showSuggestions = false;
          });
        }
      });
    }
  }

  void _initializeFormData() {
    if (isEditMode && widget.timelineToEdit != null) {
      final timeline = widget.timelineToEdit!;

      // Initialize form fields with existing timeline data
      _destinationController.text = timeline.locationCode!;

      // Initialize date and time
      _startTime = DateTime(
          timeline.startTime.year,
          timeline.startTime.month,
          timeline.startTime.day,
          timeline.startTime.hour,
          timeline.startTime.minute);
      _endTime = DateTime(timeline.endTime.year, timeline.endTime.month,
          timeline.endTime.day, timeline.endTime.hour, timeline.endTime.minute);
      // _startTime = TimeOfDay(
      //     hour: timeline.startTime.hour, minute: timeline.startTime.minute);
      // _endTime = TimeOfDay(
      //     hour: timeline.endTime.hour, minute: timeline.endTime.minute);

      print(
          '[EDIT_MODE] Initialized form with timeline data: ${timeline.locationCode}');
    }
  }

  void _onDestinationChanged(String value) {
    // Cancel previous timer
    _searchTimer?.cancel();

    if (value.trim().isEmpty) {
      setState(() {
        _showSuggestions = false;
        _locationSuggestions = [];
        _isSearching = false;
      });
      return;
    }

    // Clear previous error
    if (_destinationError.isNotEmpty) {
      setState(() => _destinationError = '');
    }

    // Set loading state
    setState(() {
      _isSearching = true;
      _showSuggestions = true;
    });

    // Debounce search for 500ms
    _searchTimer = Timer(const Duration(milliseconds: 500), () {
      _searchLocations(value.trim());
    });
  }

  void _searchLocations(String keyword) async {
    try {
      final suggestions = await _getLocationSuggestions(keyword);
      if (mounted) {
        setState(() {
          _locationSuggestions = suggestions;
          _isSearching = false;
        });
      }
    } catch (error) {
      print('Error fetching location suggestions: $error');
      if (mounted) {
        setState(() {
          _locationSuggestions = [];
          _isSearching = false;
        });
      }
    }
  }

  void _selectLocation(Location location) {
    setState(() {
      _destinationController.text = location.locationName;
      _showSuggestions = false;
      _locationSuggestions = [];
    });
    _destinationFocusNode.unfocus();
  }

  Future<List<Location>> _getLocationSuggestions(String keyword) async {
    final String? accessToken =
        await SharedPreferencesManager.getString(SPKeys.ACCESS_TOKEN);
    if (accessToken == null) {
      throw Exception('Access token not found');
    }
    PlaceApiProvider placeApiProvider =
        PlaceApiProvider(accessToken: accessToken);
    final response = await placeApiProvider.getLocations(
      keyword: keyword,
    );

    return response;
  }

  @override
  void dispose() {
    _destinationController.dispose();
    _budgetPerPersonController.dispose();
    _destinationFocusNode.removeListener(_onFocusChanged);
    _destinationFocusNode.dispose();
    _searchTimer?.cancel();
    super.dispose();
  }

  bool _validateForm() {
    setState(() {
      _destinationError = _destinationController.text.trim().isEmpty
          ? 'Vui lòng nhập điểm đến'
          : '';

      // _budgetPerPersonError = _budgetPerPersonController.text.trim().isEmpty
      //     ? 'Vui lòng nhập ngân sách/người'
      //     : '';

      _startTimeError = _startTime == null ? 'Vui lòng chọn ngày bắt đầu' : '';

      _endTimeError = _endTime == null ? 'Vui lòng chọn ngày kết thúc' : '';

      // Validate end date is after start date
      if (_startTime != null &&
          _endTime != null &&
          _endTime!.isBefore(_startTime!)) {
        _endTimeError = 'Ngày kết thúc phải sau ngày bắt đầu';
      }
    });

    return _destinationError.isEmpty &&
        _budgetPerPersonError.isEmpty &&
        _startTimeError.isEmpty &&
        _endTimeError.isEmpty;
  }

  void _handleSave(CreateTimelineBloc bloc) {
    if (!_validateForm()) return;

    final tripCode = widget.tripCode;
    if (tripCode == null) {
      ErrorDialogUtils.showErrorToast(
        context: context,
        message: 'Không tìm thấy mã chuyến đi',
      );
      return;
    }

    // Combine date and time
    final startDateTime = DateTime(
      _startTime!.year,
      _startTime!.month,
      _startTime!.day,
      _startTime?.hour ?? 0,
      _startTime?.minute ?? 0,
    );

    final endDateTime = DateTime(
      _endTime!.year,
      _endTime!.month,
      _endTime!.day,
      _endTime?.hour ?? 23,
      _endTime?.minute ?? 59,
    );

    // Create or update timeline using BLoC
    if (isEditMode && widget.timelineToEdit != null) {
      // Update existing timeline
      bloc.add(UpdateTimelineSubmitEvent(
        timelineId: widget.timelineToEdit!.id,
        tripCode: tripCode,
        locationCode: _destinationController.text.trim(),
        activityCode:
            widget.timelineToEdit!.activityCode, // Keep existing activity code
        startTime: startDateTime,
        endTime: endDateTime,
      ));
    } else {
      // Create new timeline
      bloc.add(CreateTimelineSubmitEvent(
        tripCode: tripCode,
        locationCode: _destinationController.text.trim(),
        activityCode: 'GENERAL', // Default activity code
        startTime: startDateTime,
        endTime: endDateTime,
      ));
    }
  }

  Widget _buildDestinationField() {
    return CompositedTransformTarget(
      link: _layerLink,
      child: Container(
        key: _destinationFieldKey,
        child: FormTextField(
          label: 'Điểm đến',
          controller: _destinationController,
          focusNode: _destinationFocusNode,
          errorMessage: _destinationError.isEmpty ? '' : _destinationError,
          onChanged: _onDestinationChanged,
          suffixIcon: _isSearching
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                )
              : null,
        ),
      ),
    );
  }

  Widget _buildSuggestionsOverlay() {
    // Get the exact width of the destination field
    double fieldWidth = MediaQuery.of(context).size.width - 32; // fallback

    if (_destinationFieldKey.currentContext != null) {
      final RenderBox renderBox =
          _destinationFieldKey.currentContext!.findRenderObject() as RenderBox;
      fieldWidth = renderBox.size.width;
    }

    return CompositedTransformFollower(
      link: _layerLink,
      targetAnchor: Alignment.bottomLeft,
      followerAnchor: Alignment.topLeft,
      offset: const Offset(0, 4), // Small gap between field and suggestions
      child: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: fieldWidth,
          constraints: const BoxConstraints(maxHeight: 200),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: _buildSuggestionsContent(),
          ),
        ),
      ),
    );
  }

  Widget _buildSuggestionsContent() {
    if (_isSearching) {
      return const SizedBox(
        height: 100,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_locationSuggestions.isEmpty) {
      return const SizedBox(
        height: 60,
        child: Center(
          child: Text(
            'Không tìm thấy địa điểm',
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: _locationSuggestions.length,
      itemBuilder: (context, index) {
        final location = _locationSuggestions[index];
        return ListTile(
          dense: true,
          leading: const Icon(Icons.location_on, color: Colors.grey),
          title: Text(
            location.locationName,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
          ),
          subtitle: location.address != null
              ? Text(
                  location.address!,
                  style: const TextStyle(fontSize: 10, color: Colors.grey),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                )
              : null,
          onTap: () => _selectLocation(location),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateTimelineBloc(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            isEditMode ? 'Sửa lịch trình' : 'Tạo lịch trình',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [
            BlocConsumer<CreateTimelineBloc, CreateTimelineState>(
              listener: (context, state) {
                if (state.createTimelineStatus == LoadingStatus.loaded) {
                  // Show success toast notification
                  ErrorDialogUtils.showSuccessToast(
                    context: context,
                    message: isEditMode
                        ? 'Cập nhật lịch trình thành công!'
                        : 'Tạo lịch trình thành công!',
                  );
                  Navigator.pop(context, true); // Return success result
                } else if (state.createTimelineStatus == LoadingStatus.error) {
                  // Show user-friendly error feedback using the common utility
                  final bloc = context.read<CreateTimelineBloc>();
                  ErrorDialogUtils.showErrorFeedback(
                    context: context,
                    errorMessage: state.createTimelineErrMsg,
                    title: isEditMode
                        ? 'Lỗi cập nhật lịch trình'
                        : 'Lỗi tạo lịch trình',
                    isEditMode: isEditMode,
                    onRetry: () => _handleSave(bloc),
                    showToast: true,
                    barrierDismissible: false,
                  );
                }
              },
              builder: (context, state) {
                final bloc = context.read<CreateTimelineBloc>();
                return TextButton(
                  onPressed: state.createTimelineStatus == LoadingStatus.loading
                      ? null
                      : () => _handleSave(bloc),
                  child: state.createTimelineStatus == LoadingStatus.loading
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text(
                          'Lưu',
                          style: TextStyle(
                            color: CustomColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                );
              },
            ),
          ],
        ),
        body: GestureDetector(
          onTap: () {
            // Hide suggestions and unfocus when tapping outside
            FocusScope.of(context).unfocus();
          },
          child: Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDestinationField(),
                    // const SizedBox(height: 16),
                    // FormTextField(
                    //   label: 'Ngân sách/người (VND)',
                    //   controller: _budgetPerPersonController,
                    //   keyboardType: TextInputType.number,
                    //   errorMessage: _budgetPerPersonError.isEmpty
                    //       ? ''
                    //       : _budgetPerPersonError,
                    //   onChanged: (value) {
                    //     if (_budgetPerPersonError.isNotEmpty) {
                    //       setState(() => _budgetPerPersonError = '');
                    //     }
                    //   },
                    // ),

                    CustomDatePicker(
                      label: 'Bắt đầu',
                      placeholder: 'Chọn ngày bắt đầu',
                      initialDate: _startTime,
                      onDateChanged: (date) {
                        setState(() {
                          _startTime = date;
                          if (_startTimeError.isNotEmpty) _startTimeError = '';
                        });
                      },
                      errorMessage:
                          _startTimeError.isEmpty ? '' : _startTimeError,
                      isError: _startTimeError.isNotEmpty,
                    ),
                    CustomDatePicker(
                      label: 'Kết thúc',
                      placeholder: 'Chọn ngày kết thúc',
                      initialDate: _endTime,
                      onDateChanged: (date) {
                        setState(() {
                          _endTime = date;
                          if (_endTimeError.isNotEmpty) _endTimeError = '';
                        });
                      },
                      errorMessage: _endTimeError.isEmpty ? '' : _endTimeError,
                      isError: _endTimeError.isNotEmpty,
                    ),
                  ],
                ),
              ),
              if (_showSuggestions)
                Positioned.fill(
                  child: _buildSuggestionsOverlay(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

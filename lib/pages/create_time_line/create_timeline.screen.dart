import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/api/plan/dto/Timeline.dart';
import 'package:template/common/constants/colors.dart';
import 'package:template/common/enums/loading_status.enum.dart';
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
  final TextEditingController _totalBudgetController = TextEditingController();

  DateTime? _startDate;
  DateTime? _endDate;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;

  String _destinationError = '';
  String _budgetPerPersonError = '';
  String _totalBudgetError = '';
  String _startDateError = '';
  String _endDateError = '';

  bool get isEditMode => widget.timelineToEdit != null;

  @override
  void initState() {
    super.initState();
    _initializeFormData();
  }

  void _initializeFormData() {
    if (isEditMode && widget.timelineToEdit != null) {
      final timeline = widget.timelineToEdit!;

      // Initialize form fields with existing timeline data
      _destinationController.text =
          _getLocationDisplayName(timeline.locationCode);

      // Initialize date and time
      _startDate = DateTime(timeline.startTime.year, timeline.startTime.month,
          timeline.startTime.day);
      _endDate = DateTime(
          timeline.endTime.year, timeline.endTime.month, timeline.endTime.day);
      _startTime = TimeOfDay(
          hour: timeline.startTime.hour, minute: timeline.startTime.minute);
      _endTime = TimeOfDay(
          hour: timeline.endTime.hour, minute: timeline.endTime.minute);

      print(
          '[EDIT_MODE] Initialized form with timeline data: ${timeline.locationCode}');
    }
  }

  String _getLocationDisplayName(String locationCode) {
    // Convert location codes to display names (reusing logic from timeline_list_widget)
    switch (locationCode) {
      case 'HN001':
      case 'NOI_BAI':
        return 'Nội Bài, Hà Nội';
      case 'DA_NANG':
        return 'Đà Nẵng';
      case 'HOI_AN':
        return 'Hội An';
      case 'DA_NANG_BEACH':
        return 'Bãi biển Đà Nẵng';
      case 'BA_NA_HILLS':
        return 'Bà Nà Hills';
      case 'CITY_CENTER':
        return 'Trung tâm thành phố';
      case 'OLD_QUARTER':
        return 'Phố cổ Hội An';
      case 'JAPANESE_BRIDGE':
        return 'Chùa Cầu';
      case 'NIGHT_MARKET':
        return 'Chợ đêm';
      case 'SEAFOOD_RESTAURANT':
        return 'Nhà hàng hải sản';
      case 'CABLE_CAR':
        return 'Cáp treo';
      case 'GOLDEN_BRIDGE':
        return 'Cầu Vàng';
      case 'FRENCH_VILLAGE':
        return 'Làng Pháp';
      case 'FANTASY_PARK':
        return 'Công viên Fantasy';
      default:
        return locationCode;
    }
  }

  @override
  void dispose() {
    _destinationController.dispose();
    _budgetPerPersonController.dispose();
    _totalBudgetController.dispose();
    super.dispose();
  }

  bool _validateForm() {
    setState(() {
      _destinationError = _destinationController.text.trim().isEmpty
          ? 'Vui lòng nhập điểm đến'
          : '';

      _budgetPerPersonError = _budgetPerPersonController.text.trim().isEmpty
          ? 'Vui lòng nhập ngân sách/người'
          : '';

      _totalBudgetError = _totalBudgetController.text.trim().isEmpty
          ? 'Vui lòng nhập tổng ngân sách'
          : '';

      _startDateError = _startDate == null ? 'Vui lòng chọn ngày bắt đầu' : '';

      _endDateError = _endDate == null ? 'Vui lòng chọn ngày kết thúc' : '';

      // Validate end date is after start date
      if (_startDate != null &&
          _endDate != null &&
          _endDate!.isBefore(_startDate!)) {
        _endDateError = 'Ngày kết thúc phải sau ngày bắt đầu';
      }
    });

    return _destinationError.isEmpty &&
        _budgetPerPersonError.isEmpty &&
        _totalBudgetError.isEmpty &&
        _startDateError.isEmpty &&
        _endDateError.isEmpty;
  }

  void _handleSave(CreateTimelineBloc bloc) {
    if (!_validateForm()) return;

    final tripCode = widget.tripCode;
    if (tripCode == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Không tìm thấy mã chuyến đi')),
      );
      return;
    }

    // Combine date and time
    final startDateTime = DateTime(
      _startDate!.year,
      _startDate!.month,
      _startDate!.day,
      _startTime?.hour ?? 0,
      _startTime?.minute ?? 0,
    );

    final endDateTime = DateTime(
      _endDate!.year,
      _endDate!.month,
      _endDate!.day,
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
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(isEditMode
                            ? 'Cập nhật lịch trình thành công!'
                            : 'Tạo lịch trình thành công!')),
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
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormTextField(
                label: 'Điểm đến',
                controller: _destinationController,
                errorMessage:
                    _destinationError.isEmpty ? '' : _destinationError,
                onChanged: (value) {
                  if (_destinationError.isNotEmpty) {
                    setState(() => _destinationError = '');
                  }
                },
              ),
              const SizedBox(height: 16),
              FormTextField(
                label: 'Ngân sách/người (VND)',
                controller: _budgetPerPersonController,
                keyboardType: TextInputType.number,
                errorMessage:
                    _budgetPerPersonError.isEmpty ? '' : _budgetPerPersonError,
                onChanged: (value) {
                  if (_budgetPerPersonError.isNotEmpty) {
                    setState(() => _budgetPerPersonError = '');
                  }
                },
              ),
              const SizedBox(height: 16),
              FormTextField(
                label: 'Tổng ngân sách (VND)',
                controller: _totalBudgetController,
                keyboardType: TextInputType.number,
                errorMessage:
                    _totalBudgetError.isEmpty ? '' : _totalBudgetError,
                onChanged: (value) {
                  if (_totalBudgetError.isNotEmpty) {
                    setState(() => _totalBudgetError = '');
                  }
                },
              ),
              const SizedBox(height: 16),
              CustomDatePicker(
                label: 'Bắt đầu',
                placeholder: 'Chọn ngày bắt đầu',
                initialDate: _startDate,
                onDateChanged: (date) {
                  setState(() {
                    _startDate = date;
                    if (_startDateError.isNotEmpty) _startDateError = '';
                  });
                },
                errorMessage: _startDateError.isEmpty ? '' : _startDateError,
                isError: _startDateError.isNotEmpty,
              ),
              CustomDatePicker(
                label: 'Kết thúc',
                placeholder: 'Chọn ngày kết thúc',
                initialDate: _endDate,
                onDateChanged: (date) {
                  setState(() {
                    _endDate = date;
                    if (_endDateError.isNotEmpty) _endDateError = '';
                  });
                },
                errorMessage: _endDateError.isEmpty ? '' : _endDateError,
                isError: _endDateError.isNotEmpty,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

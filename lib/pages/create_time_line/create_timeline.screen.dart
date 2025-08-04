import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/common/constants/colors.dart';
import 'package:template/common/utils/share_preferences.dart';
import 'package:template/common/widgets/custom_textfield.dart';
import 'package:template/common/widgets/custom_date_picker.dart';
import 'package:template/api/plan/provider.dart';
import 'package:template/api/plan/dto/ReqCreateTimeline.dart';
import 'package:template/api/plan/dto/SubTimelineRequest.dart';
import 'package:template/pages/trip_detail/bloc/trip_detail.bloc.dart';
import 'package:intl/intl.dart';

class CreateTimelineScreen extends StatefulWidget {
  final String? tripCode;

  const CreateTimelineScreen({Key? key, this.tripCode}) : super(key: key);

  @override
  State<CreateTimelineScreen> createState() => _CreateTimelineScreenState();
}

class _CreateTimelineScreenState extends State<CreateTimelineScreen> {
  final TextEditingController _destinationController = TextEditingController();
  final TextEditingController _budgetPerPersonController = TextEditingController();
  final TextEditingController _totalBudgetController = TextEditingController();

  DateTime? _startDate;
  DateTime? _endDate;

  String _destinationError = '';
  String _budgetPerPersonError = '';
  String _totalBudgetError = '';
  String _startDateError = '';
  String _endDateError = '';

  bool _isLoading = false;

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
          ? 'Vui lòng nhập điểm đến' : '';

      _budgetPerPersonError = _budgetPerPersonController.text.trim().isEmpty
          ? 'Vui lòng nhập ngân sách/người' : '';

      _totalBudgetError = _totalBudgetController.text.trim().isEmpty
          ? 'Vui lòng nhập tổng ngân sách' : '';

      _startDateError = _startDate == null
          ? 'Vui lòng chọn ngày bắt đầu' : '';

      _endDateError = _endDate == null
          ? 'Vui lòng chọn ngày kết thúc' : '';

      // Validate end date is after start date
      if (_startDate != null && _endDate != null && _endDate!.isBefore(_startDate!)) {
        _endDateError = 'Ngày kết thúc phải sau ngày bắt đầu';
      }
    });

    return _destinationError.isEmpty &&
           _budgetPerPersonError.isEmpty &&
           _totalBudgetError.isEmpty &&
           _startDateError.isEmpty &&
           _endDateError.isEmpty;
  }

  Future<void> _onCreateTimeline() async {
    if (!_validateForm()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // Get access token
      final String? accessToken = await SharedPreferencesManager.getString(SPKeys.ACCESS_TOKEN);
      if (accessToken == null) {
        throw Exception('Access token not found');
      }

      // Use tripCode from constructor
      if (widget.tripCode == null || widget.tripCode!.isEmpty) {
        throw Exception('Trip code not found');
      }

      print('Creating timeline for trip: ${widget.tripCode}');

      // Format dates to string for API
      final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');

      // Create request with sample data (you can make this more dynamic)
      final request = ReqCreateTimeline(
        tripCode: widget.tripCode!,
        locationCode: _destinationController.text.trim(),
        activityCode: 'CUSTOM_ACTIVITY', // You can make this selectable
        startTime: _startDate!,
        endTime: _endDate!,
        subTimelines: [
          // Sample sub-timeline, you can make this dynamic
          SubTimelineRequest(
            locationCode: _destinationController.text.trim(),
            activityCode: 'SUB_ACTIVITY',
            startTime: formatter.format(_startDate!),
            endTime: formatter.format(_startDate!.add(const Duration(hours: 2))),
          ),
        ],
      );

      // Call API
      final response = await PlanApiProvider(accessToken: accessToken)
          .createTimeline(reqCreateTimeline: request);

      if (response.success) {
        // Show success message with timeline details
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Tạo lịch trình thành công! ID: ${response.id ?? 'N/A'}'),
              backgroundColor: CustomColors.primary,
            ),
          );

          print('Timeline created successfully:');
          print('- ID: ${response.id}');
          print('- Location: ${response.locationCode}');
          print('- Activity: ${response.activityCode}');
          print('- Start: ${response.startTime}');
          print('- End: ${response.endTime}');
          print('- Sub-timelines: ${response.subTimeLine?.length ?? 0}');

          // Navigate back with success result
          Navigator.of(context).pop(true);
        }
      } else {
        throw Exception(response.message ?? 'Create timeline failed');
      }
    } catch (err) {
      print('Error creating timeline: $err');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Lỗi tạo lịch trình: $err'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Thêm timeline',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
        actions: [
          TextButton(
            onPressed: _isLoading ? null : _onCreateTimeline,
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              backgroundColor: _isLoading ? Colors.grey : CustomColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            child: _isLoading
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : const Text(
                    'Lưu',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Destination field
            FormTextField(
              label: 'Điểm đến',
              placeholder: 'Nhập điểm đến của bạn',
              controller: _destinationController,
              errorMessage: _destinationError,
              onChanged: (value) {
                if (_destinationError.isNotEmpty) {
                  setState(() {
                    _destinationError = '';
                  });
                }
              },
            ),

            const SizedBox(height: 6),

            // Budget per person field
            FormTextField(
              label: 'Ngân sách/người (VND)',
              placeholder: 'Nhập ngân sách cho mỗi người',
              controller: _budgetPerPersonController,
              keyboardType: TextInputType.number,
              errorMessage: _budgetPerPersonError,
              onChanged: (value) {
                if (_budgetPerPersonError.isNotEmpty) {
                  setState(() {
                    _budgetPerPersonError = '';
                  });
                }
              },
            ),

            const SizedBox(height: 6),

            // Total budget field
            FormTextField(
              label: 'Tổng ngân sách (VND)',
              placeholder: 'Nhập tổng ngân sách',
              controller: _totalBudgetController,
              keyboardType: TextInputType.number,
              errorMessage: _totalBudgetError,
              onChanged: (value) {
                if (_totalBudgetError.isNotEmpty) {
                  setState(() {
                    _totalBudgetError = '';
                  });
                }
              },
            ),

            const SizedBox(height: 6),

            // Start date field
            CustomDatePicker(
              label: 'Bắt đầu',
              placeholder: 'Chọn ngày bắt đầu',
              initialDate: _startDate,
              isError: _startDateError.isNotEmpty,
              errorMessage: _startDateError,
              dateFormat: 'dd/MM/yyyy HH:mm',
              onDateChanged: (date) {
                setState(() {
                  _startDate = date;
                  if (_startDateError.isNotEmpty) {
                    _startDateError = '';
                  }
                  // Re-validate end date if it exists
                  if (_endDate != null && _endDate!.isBefore(_startDate!)) {
                    _endDateError = 'Ngày kết thúc phải sau ngày bắt đầu';
                  } else if (_endDateError == 'Ngày kết thúc phải sau ngày bắt đầu') {
                    _endDateError = '';
                  }
                });
              },
            ),

            const SizedBox(height: 6),

            // End date field
            CustomDatePicker(
              label: 'Kết thúc',
              placeholder: 'Chọn ngày kết thúc',
              initialDate: _endDate,
              isError: _endDateError.isNotEmpty,
              errorMessage: _endDateError,
              dateFormat: 'dd/MM/yyyy HH:mm',
              onDateChanged: (date) {
                setState(() {
                  _endDate = date;
                  if (_endDateError.isNotEmpty) {
                    _endDateError = '';
                  }
                  // Validate end date is after start date
                  if (_startDate != null && _endDate!.isBefore(_startDate!)) {
                    _endDateError = 'Ngày kết thúc phải sau ngày bắt đầu';
                  }
                });
              },
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

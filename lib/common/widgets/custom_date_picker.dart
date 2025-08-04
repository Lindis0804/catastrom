import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:template/common/constants/colors.dart';
import 'package:template/common/widgets/custom_datetime_picker.dart';

class CustomDatePicker extends StatefulWidget {
  final String? label;
  final String placeholder;
  final DateTime? initialDate;
  final ValueChanged<DateTime>? onDateChanged;
  final bool enabled;
  final bool isError;
  final String errorMessage;
  final String dateFormat;

  const CustomDatePicker({
    super.key,
    this.label,
    required this.placeholder,
    this.initialDate, // Mặc định là null thay vì DateTime.now()
    this.onDateChanged,
    this.enabled = true,
    this.isError = false,
    this.errorMessage = '',
    this.dateFormat = 'dd/MM/yyyy HH:mm',
  });

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  DateTime? _selectedDate;
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  String get _displayText {
    if (_selectedDate != null) {
      return DateFormat(widget.dateFormat).format(_selectedDate!);
    }
    return '';
  }

  Color get _currentState {
    if (!widget.enabled) return Colors.grey[300] ?? Colors.grey.shade300;
    if (widget.isError) return CustomColors.error;
    if (_isFocused) return CustomColors.primary;
    return CustomColors.border;
  }

  Color get _backgroundColor {
    if (!widget.enabled) return Colors.grey[100] ?? Colors.grey.shade100;
    if (widget.isError) return CustomColors.error.withValues(alpha: 0.05);
    return Colors.white;
  }

  Color get _textColor {
    if (!widget.enabled) return Colors.grey[600] ?? Colors.grey.shade600;
    return Colors.black87;
  }

  Color get _labelColor {
    if (!widget.enabled) return Colors.grey[600] ?? Colors.grey.shade600;
    if (widget.isError) return CustomColors.error;
    if (_isFocused) return CustomColors.primary;
    return CustomColors.textLabel;
  }

  double get _borderWidth {
    if (_isFocused) return 2.0;
    if (widget.isError) return 1.5;
    return 1.0;
  }

  List<BoxShadow>? get _boxShadow {
    if (_isFocused) {
      return [
        BoxShadow(
          color: CustomColors.primary.withValues(alpha: 0.1),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ];
    }
    return null;
  }

  void _showDatePicker() {
    if (!widget.enabled) return;

    CustomDateTimePicker.showDateTimePicker(
      context,
      (date, list) {
        setState(() {
          _selectedDate = date;
        });
        widget.onDateChanged?.call(date);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.label != null) ...[
            _buildLabel(),
            const SizedBox(height: 8),
          ],
          _buildDateField(),
          if (widget.isError && widget.errorMessage.isNotEmpty) ...[
            const SizedBox(height: 8),
            _buildErrorMessage(),
          ],
        ],
      ),
    );
  }

  Widget _buildLabel() {
    return Text(
      widget.label!,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: _labelColor,
      ),
    );
  }

  Widget _buildDateField() {
    return Container(
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: _currentState,
          width: _borderWidth,
        ),
        boxShadow: _boxShadow,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: widget.enabled ? _showDatePicker : null,
          onFocusChange: (focused) {
            setState(() {
              _isFocused = focused;
            });
          },
          focusNode: _focusNode,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _displayText.isEmpty ? widget.placeholder : _displayText,
                    style: TextStyle(
                      fontSize: 14,
                      color: _displayText.isEmpty
                          ? (widget.enabled ? Colors.grey[500] : Colors.grey[400])
                          : _textColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Icon(
                  Icons.calendar_today,
                  size: 16,
                  color: widget.enabled ? Colors.grey[600] : Colors.grey[400],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildErrorMessage() {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        widget.errorMessage,
        style: const TextStyle(
          color: CustomColors.error,
          fontSize: 10,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}

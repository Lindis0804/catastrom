import 'package:flutter/material.dart';
import 'package:template/common/constants/colors.dart';

class CustomTextArea extends StatefulWidget {
  final String? label;
  final String placeholder;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final bool isError;
  final bool enabled;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final ValueChanged<bool>? onFocusChanged;
  final int minLines;
  final int maxLines;
  final String errorMessage;

  const CustomTextArea({
    super.key,
    this.label,
    required this.placeholder,
    this.suffixIcon,
    this.controller,
    this.isError = false,
    this.enabled = true,
    this.onChanged,
    this.onTap,
    this.onFocusChanged,
    this.minLines = 3,
    this.maxLines = 8,
    this.errorMessage = '',
  });

  @override
  State<CustomTextArea> createState() => _CustomTextAreaState();
}

class _CustomTextAreaState extends State<CustomTextArea> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
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
    widget.onFocusChanged?.call(_isFocused);
  }

  @override
  Widget build(BuildContext context) {
    final bool hasError = widget.errorMessage.isNotEmpty || widget.isError;
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.label != null) ...[
            Text(
              widget.label!,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: _getLabelColor(hasError),
              ),
            ),
            const SizedBox(height: 8),
          ],
          Container(
            decoration: BoxDecoration(
              color: _getBackgroundColor(hasError),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: _getBorderColor(hasError),
                width: _getBorderWidth(hasError),
              ),
              boxShadow: _getBoxShadow(hasError),
            ),
            child: TextField(
              focusNode: _focusNode,
              controller: widget.controller,
              enabled: widget.enabled,
              onChanged: widget.onChanged,
              onTap: widget.onTap,
              minLines: widget.minLines,
              maxLines: widget.maxLines,
              cursorColor: CustomColors.primary,
              style: TextStyle(
                fontSize: 14,
                color: _getTextColor(hasError),
                fontWeight: FontWeight.w400,
              ),
              decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                hintText: widget.placeholder,
                hintStyle: TextStyle(
                  color: _getHintTextColor(hasError),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                suffixIcon: widget.suffixIcon,
              ),
            ),
          ),
          if (hasError) ...[
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Text(
                widget.errorMessage,
                style: const TextStyle(
                  color: CustomColors.error,
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Color _getBackgroundColor(bool hasError) {
    if (!widget.enabled) return Colors.grey[100] ?? Colors.grey.shade100;
    if (hasError) return CustomColors.error.withOpacity(0.05);
    if (_isFocused) return Colors.white;
    return Colors.white;
  }

  Color _getBorderColor(bool hasError) {
    if (!widget.enabled) return Colors.grey[300] ?? Colors.grey.shade300;
    if (hasError) return CustomColors.error;
    if (_isFocused) return CustomColors.primary;
    return CustomColors.border;
  }

  double _getBorderWidth(bool hasError) {
    if (_isFocused) return 2.0;
    if (hasError) return 1.5;
    return 1.0;
  }

  List<BoxShadow>? _getBoxShadow(bool hasError) {
    if (_isFocused) {
      return [
        BoxShadow(
          color: CustomColors.primary.withOpacity(0.1),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ];
    }
    return null;
  }

  Color _getTextColor(bool hasError) {
    if (!widget.enabled) return Colors.grey[600] ?? Colors.grey.shade600;
    return Colors.black87;
  }

  Color _getHintTextColor(bool hasError) {
    if (!widget.enabled) return Colors.grey[400] ?? Colors.grey.shade400;
    return Colors.grey[500] ?? Colors.grey.shade500;
  }

  Color _getLabelColor(bool hasError) {
    if (!widget.enabled) return Colors.grey[600] ?? Colors.grey.shade600;
    if (hasError) return CustomColors.error;
    if (_isFocused) return CustomColors.primary;
    return CustomColors.textLabel;
  }
}


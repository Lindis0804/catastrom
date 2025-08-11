import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:template/common/constants/colors.dart';
import 'package:template/common/widgets/number_input_formatter.dart';

// Enum định nghĩa các trạng thái của TextField
enum TextFieldState {
  defaultState,
  focused,
  disabled,
  error,
}

class NormalTextfield extends StatefulWidget {
  final String? label;
  final String placeholder;
  final Widget? suffixIcon; // Thay đổi từ IconButton? thành Widget?
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool isObscureText;
  final bool isError;
  final bool enabled;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final ValueChanged<bool>? onFocusChanged;
  final TextInputType keyboardType;

  const NormalTextfield({
    super.key,
    this.label,
    required this.placeholder,
    this.suffixIcon,
    this.controller,
    this.focusNode,
    this.isObscureText = false,
    this.isError = false,
    this.enabled = true,
    this.onChanged,
    this.onTap,
    this.onFocusChanged,
    this.keyboardType = TextInputType.text,
  });

  @override
  State<NormalTextfield> createState() => _NormalTextfieldState();
}

class _NormalTextfieldState extends State<NormalTextfield> {
  late FocusNode _focusNode;
  bool _isFocused = false;
  bool _ownsFocusNode = false;

  @override
  void initState() {
    super.initState();
    if (widget.focusNode != null) {
      _focusNode = widget.focusNode!;
      _ownsFocusNode = false;
    } else {
      _focusNode = FocusNode();
      _ownsFocusNode = true;
    }
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    if (_ownsFocusNode) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
    widget.onFocusChanged?.call(_isFocused);
  }

  TextFieldState get _currentState {
    if (!widget.enabled) return TextFieldState.disabled;
    if (widget.isError) return TextFieldState.error;
    if (_isFocused) return TextFieldState.focused;
    return TextFieldState.defaultState;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          _buildLabel(),
          const SizedBox(height: 8),
        ],
        _buildTextField(),
      ],
    );
  }

  Widget _buildLabel() {
    return Text(
      widget.label!,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: _getLabelColor(),
      ),
    );
  }

  Widget _buildTextField() {
    return GestureDetector(
      onTap: () {
        // Focus the text field when tapped
        if (!_focusNode.hasFocus) {
          _focusNode.requestFocus();
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: _getBackgroundColor(),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: _getBorderColor(),
            width: _getBorderWidth(),
          ),
          boxShadow: _getBoxShadow(),
        ),
        child: TextField(
          focusNode: _focusNode,
          keyboardType: widget.keyboardType,
          controller: widget.controller,
          obscureText: widget.isObscureText,
          enabled: widget.enabled,
          onChanged: _handleTextChanged,
          onTap: widget.onTap,
          inputFormatters: _getInputFormatters(),
          cursorColor: CustomColors.primary,
          style: TextStyle(
            fontSize: 14,
            color: _getTextColor(),
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
              color: _getHintTextColor(),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            suffixIcon: widget.suffixIcon,
          ),
        ),
      ),
    );
  }

  void _handleTextChanged(String value) {
    widget.onChanged?.call(value);
  }

  List<TextInputFormatter> _getInputFormatters() {
    if (widget.keyboardType == TextInputType.number) {
      return [NumberInputFormatter()];
    }
    return [];
  }

  // Màu nền theo trạng thái
  Color _getBackgroundColor() {
    switch (_currentState) {
      case TextFieldState.disabled:
        return Colors.grey[100] ?? Colors.grey.shade100;
      case TextFieldState.error:
        return CustomColors.error.withValues(alpha: 0.05);
      case TextFieldState.focused:
        return Colors.white;
      case TextFieldState.defaultState:
        return Colors.white;
    }
  }

  // Màu viền theo trạng thái
  Color _getBorderColor() {
    switch (_currentState) {
      case TextFieldState.disabled:
        return Colors.grey[300] ?? Colors.grey.shade300;
      case TextFieldState.error:
        return CustomColors.error;
      case TextFieldState.focused:
        return CustomColors.primary;
      case TextFieldState.defaultState:
        return CustomColors.border;
    }
  }

  // Độ dày viền theo trạng thái
  double _getBorderWidth() {
    switch (_currentState) {
      case TextFieldState.focused:
        return 2.0;
      case TextFieldState.error:
        return 1.5;
      default:
        return 1.0;
    }
  }

  // Box shadow cho trạng thái focused
  List<BoxShadow>? _getBoxShadow() {
    if (_currentState == TextFieldState.focused) {
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

  // Màu text theo trạng thái
  Color _getTextColor() {
    switch (_currentState) {
      case TextFieldState.disabled:
        return Colors.grey[600] ?? Colors.grey.shade600;
      case TextFieldState.error:
        return Colors.black87;
      default:
        return Colors.black87;
    }
  }

  // Màu hint text theo trạng thái
  Color _getHintTextColor() {
    switch (_currentState) {
      case TextFieldState.disabled:
        return Colors.grey[400] ?? Colors.grey.shade400;
      default:
        return Colors.grey[500] ?? Colors.grey.shade500;
    }
  }

  // Màu label theo trạng thái
  Color _getLabelColor() {
    switch (_currentState) {
      case TextFieldState.disabled:
        return Colors.grey[600] ?? Colors.grey.shade600;
      case TextFieldState.error:
        return CustomColors.error;
      case TextFieldState.focused:
        return CustomColors.primary;
      default:
        return CustomColors.textLabel;
    }
  }
}

class FormTextField extends StatelessWidget {
  final String? label;
  final String? placeholder;
  final Widget? suffixIcon; // Thay đổi từ IconButton? thành Widget?
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool isObscureText;
  final bool enabled;
  final String errorMessage;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final ValueChanged<bool>? onFocusChanged;
  final TextInputType keyboardType;

  const FormTextField({
    super.key,
    this.label,
    this.placeholder,
    this.suffixIcon,
    this.controller,
    this.focusNode,
    this.isObscureText = false,
    this.enabled = true,
    this.errorMessage = '',
    this.onChanged,
    this.onTap,
    this.onFocusChanged,
    this.keyboardType = TextInputType.text,
  });

  bool get _hasError => errorMessage.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NormalTextfield(
            label: label,
            placeholder: placeholder ?? (label ?? ''),
            suffixIcon: suffixIcon,
            controller: controller,
            focusNode: focusNode,
            isError: _hasError,
            enabled: enabled,
            isObscureText: isObscureText,
            onChanged: onChanged,
            onTap: onTap,
            onFocusChanged: onFocusChanged,
            keyboardType: keyboardType,
          ),
          if (_hasError) ...[
            const SizedBox(height: 8),
            _buildErrorMessage(),
          ],
        ],
      ),
    );
  }

  Widget _buildErrorMessage() {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        errorMessage,
        style: const TextStyle(
          color: CustomColors.error,
          fontSize: 10,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}

class LabeledTextField extends StatelessWidget {
  final String label;
  final String? placeholder;
  final Widget? suffixIcon; // Thay đổi từ IconButton? thành Widget?
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool isObscureText;
  final bool enabled;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final ValueChanged<bool>? onFocusChanged;
  final TextInputType keyboardType;

  const LabeledTextField({
    super.key,
    required this.label,
    this.placeholder,
    this.suffixIcon,
    this.controller,
    this.focusNode,
    this.isObscureText = false,
    this.enabled = true,
    this.onChanged,
    this.onTap,
    this.onFocusChanged,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return FormTextField(
      label: label,
      placeholder: placeholder,
      suffixIcon: suffixIcon,
      controller: controller,
      focusNode: focusNode,
      isObscureText: isObscureText,
      enabled: enabled,
      onChanged: onChanged,
      onTap: onTap,
      onFocusChanged: onFocusChanged,
      keyboardType: keyboardType,
    );
  }
}

extension TextFieldExtension on FormTextField {
  FormTextField withLabel(String label) {
    return FormTextField(
      label: label,
      placeholder: placeholder,
      suffixIcon: suffixIcon,
      controller: controller,
      focusNode: focusNode,
      isObscureText: isObscureText,
      enabled: enabled,
      errorMessage: errorMessage,
      onChanged: onChanged,
      onTap: onTap,
      onFocusChanged: onFocusChanged,
      keyboardType: keyboardType,
    );
  }
}

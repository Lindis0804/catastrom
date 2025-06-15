import 'package:flutter/material.dart';
import 'package:template/common/constants/colors.dart';

class NormalTextfield extends StatelessWidget {
  final String text;
  final IconButton? suffixIcon;
  final TextEditingController? controller;
  final bool? isObscureText;
  final Color borderColor;
  final bool isError;
  final ValueChanged<String>? onChanged;
  final TextInputType keyboardType;
  const NormalTextfield(
      {super.key,
      required this.text,
      this.suffixIcon,
      this.controller,
      this.isObscureText,
      this.borderColor = Colors.green,
      this.isError = false,
      this.onChanged,
      required this.keyboardType});
  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyboardType,
      controller: controller,
      obscureText: isObscureText ?? false,
      onChanged: onChanged,
      decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: isError ? CustomColors.error : CustomColors.primary)),
          labelStyle: TextStyle(
              color: isError ? CustomColors.error : CustomColors.primary),
          label: Text(
            text,
            // style: const TextStyle(fontSize: 12),
          ),
          suffixIcon: suffixIcon),
    );
  }
}

class FormTextField extends StatelessWidget {
  final String text;
  final IconButton? suffixIcon;
  final TextEditingController? controller;
  final bool isObscureText;
  final String errorMessage;
  final ValueChanged<String>? onChanged;
  final TextInputType? keyboardType;
  const FormTextField(
      {super.key,
      required this.text,
      this.suffixIcon,
      this.controller,
      this.isObscureText = false,
      this.errorMessage = '',
      this.onChanged,
      this.keyboardType = TextInputType.text});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          NormalTextfield(
            keyboardType: keyboardType!,
            onChanged: onChanged,
            text: text,
            suffixIcon: suffixIcon,
            controller: controller,
            isError: errorMessage.isNotEmpty,
            isObscureText: isObscureText,
          ),
          Visibility(
            visible: errorMessage.isNotEmpty,
            child: Text(
              errorMessage,
              style: const TextStyle(color: CustomColors.error, fontSize: 10),
            ),
          )
        ],
      ),
    );
  }
}

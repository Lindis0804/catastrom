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
  const NormalTextfield(
      {super.key,
      required this.text,
      this.suffixIcon,
      this.controller,
      this.isObscureText,
      this.borderColor = Colors.green,
      this.isError = false,
      this.onChanged});
  @override
  Widget build(BuildContext context) {
    return TextField(
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
              borderSide:
                  BorderSide(color: isError ? Colours.error : Colours.primary)),
          labelStyle:
              TextStyle(color: isError ? Colours.error : Colours.primary),
          label: Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.bold),
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
  const FormTextField(
      {super.key,
      required this.text,
      this.suffixIcon,
      this.controller,
      this.isObscureText = false,
      this.errorMessage = '',
      this.onChanged});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          NormalTextfield(
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
              style: const TextStyle(color: Colours.error, fontSize: 10),
            ),
          )
        ],
      ),
    );
  }
}

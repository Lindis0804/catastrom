import 'package:flutter/material.dart';

class NormalTextfield extends StatelessWidget {
  final String text;
  final IconButton? suffixIcon;
  TextEditingController? controller;
  final bool? isObscureText;
  NormalTextfield(
      {required this.text,
      this.suffixIcon,
      this.controller,
      this.isObscureText});
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isObscureText ?? true,
      decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          label: Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          suffixIcon: suffixIcon),
    );
  }
}

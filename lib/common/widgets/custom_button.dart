import 'package:flutter/material.dart';
import 'package:template/common/constants/colors.dart';

class BigCustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final Color backgroundColor, borderColor, textColor;
  const BigCustomButton(
      {super.key,
      required this.onPressed,
      required this.text,
      this.backgroundColor = CustomColors.primary,
      this.borderColor = CustomColors.primary,
      this.textColor = Colors.white});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.symmetric(vertical: 16, horizontal: 30),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
            side: BorderSide(
              color: borderColor,
              width: 1,
            ),
          ),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(color: textColor, fontSize: 15),
      ),
    );
  }
}

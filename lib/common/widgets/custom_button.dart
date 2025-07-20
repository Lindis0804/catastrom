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
    return SizedBox(
      height: 42,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
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
      ),
    );
  }
}

class CustomOutlinedButton extends BigCustomButton {
  const CustomOutlinedButton({
    super.key,
    required VoidCallback? onPressed,
    required String text,
    Color backgroundColor = Colors.white,
    Color borderColor = CustomColors.primary,
    Color textColor = CustomColors.primary,
  }) : super(
          onPressed: onPressed,
          text: text,
          backgroundColor: backgroundColor,
          borderColor: borderColor,
          textColor: textColor,
        );
}

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:template/common/constants/colors.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      height: screenSize.height,
      width: screenSize.width,
      color: CustomColors.gray.withOpacity(0.5),
      child: const Center(
        child: SpinKitFadingCircle(color: CustomColors.gray),
      ),
    );
  }
}

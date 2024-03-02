import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:template/common/constants/colors.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colours.gray.withOpacity(0.5),
      child: const Center(
        child: SpinKitPouringHourGlassRefined(color: Colours.primary),
      ),
    );
  }
}

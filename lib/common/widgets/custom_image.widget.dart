import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  final ImageProvider image;
  final double width;

  const CustomImage({
    super.key,
    required this.image,
    this.width = 150.0,
  });
  @override
  Widget build(BuildContext context) {
    return Image(
      image: image,
      width: width,
      fit: BoxFit.fitWidth,
    );
  }

  static Widget asset(
      {required String imagePath,
      double width = 150,
      double height = 150,
      double? radius}) {
    Widget image = Image.asset(
      imagePath,
      fit: BoxFit.fill,
    );
    return radius != null
        ? Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(radius),
              ),
              image: DecorationImage(
                  image: AssetImage(imagePath), fit: BoxFit.fill),
            ),
          )
        : image;
  }
}

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

  static Widget network(
      {required String imageUrl,
      double width = 150,
      double height = 150,
      double? radius}) {
    Widget image = Image.network(
      imageUrl,
      width: width,
      height: height,
      fit: BoxFit.fill,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }

        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return const Text('Fail to load image.');
      },
    );

    return radius != null
        ? ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            child: image,
          )
        : image;
  }
}

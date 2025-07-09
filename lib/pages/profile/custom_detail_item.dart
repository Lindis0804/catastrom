import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:template/common/constants/colors.dart';
import 'package:template/generated/assets.gen.dart';

class CustomDetailItem extends StatelessWidget {
  final String title;
  final String value;
  final SvgGenImage icon;

  const CustomDetailItem({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon.svg(
        height: 24,
        width: 24,
        color: Theme.of(context).iconTheme.color,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
        ),
      ),
      trailing: Text(
        value,
        style: const TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }
}

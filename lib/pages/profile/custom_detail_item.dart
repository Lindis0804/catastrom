import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:template/common/constants/colors.dart';
import 'package:template/generated/assets.gen.dart';

class CustomDetailItem extends StatelessWidget {
  final String title;
  final String value;
  final SvgGenImage? icon;
  final IconData? materialIcon;

  const CustomDetailItem({
    super.key,
    required this.title,
    required this.value,
    this.icon,
    this.materialIcon,
  });

  @override
  Widget build(BuildContext context) {
    final iconColor = Theme.of(context).iconTheme.color;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (icon != null)
            icon!.svg(
              height: 24,
              width: 24,
              color: iconColor,
            )
          else if (materialIcon != null)
            Icon(
              materialIcon,
              size: 24,
              color: iconColor,
            ),

          const SizedBox(width: 16),

          // Expanded(
          //   child: Text(
          //     title,
          //     style: const TextStyle(
          //       fontSize: 16,
          //     ),
          //     maxLines: 2,
          //     overflow: TextOverflow.ellipsis,
          //   ),
          // ),

          // const SizedBox(width: 12),

          Flexible(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
              ),
              textAlign: TextAlign.end,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

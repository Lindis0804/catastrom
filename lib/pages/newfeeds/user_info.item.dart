import 'package:flutter/material.dart';
import 'package:template/common/utils/env.dart';
import 'package:template/common/widgets/custom_image.widget.dart';
import 'package:template/data/models/user/user.model.dart';
import 'package:template/generated/assets.gen.dart';

class UserInfoItem extends StatelessWidget {
  final User user;
  final Function()? onTap;
  const UserInfoItem({required this.user, super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(230, 238, 250, 1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomImage.network(
                imageUrl: EnvVariable.defaultAvatar,
                width: 50,
                height: 50,
                radius: 10),
            const SizedBox(
              width: 7,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${user.firstName} ${user.lastName}',
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

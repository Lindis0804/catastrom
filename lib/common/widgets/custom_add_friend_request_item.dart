import 'package:flutter/material.dart';
import 'package:template/api/user/dto/getAddFriendRequests/ResGetAddFriendRequests.dart';
import 'package:template/common/utils/env.dart';
import 'package:template/common/widgets/custom_button.dart';
import 'package:template/common/widgets/custom_gap.dart';
import 'package:template/common/widgets/custom_image.widget.dart';

class CustomAddFriendRequestItem extends StatelessWidget {
  final void Function()? onTap, onAccept, onReject;
  final AddFriendRequest addFriendRequest;
  const CustomAddFriendRequestItem({
    super.key,
    required this.addFriendRequest,
    this.onTap,
    this.onAccept,
    this.onReject,
  });
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${addFriendRequest.firstname} ${addFriendRequest.lastname} vừa gửi cho bạn lời mời kết bạn',
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  Row(
                    children: [
                      OutlinedButton(
                        onPressed: onReject,
                        child: const Text('Từ chối'),
                      ),
                      const CustomVerticalGap(),
                      BigCustomButton(
                        onPressed: onAccept,
                        text: 'Chấp nhận',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

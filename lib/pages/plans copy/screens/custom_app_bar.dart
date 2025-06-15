import 'package:flutter/material.dart';
import 'package:template/generated/assets.gen.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.name});
  final String name;
  @override
  State<StatefulWidget> createState() => _CustomAppBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size(double.infinity, 120);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      color: Colors.green,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              child: Container(
            margin: const EdgeInsets.only(left: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hi ${widget.name}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 30),
                ),
                const Text(
                  'Bạn muốn đi đâu?',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                )
              ],
            ),
          )),
          Container(
            margin: const EdgeInsets.only(right: 30),
            child: Image(
              image: Assets.images.logo4x.provider(),
              width: 60,
            ),
          )
        ],
      ),
    );
  }
}

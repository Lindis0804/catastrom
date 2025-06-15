import 'package:flutter/material.dart';
import 'package:template/common/utils/share_preferences.dart';
import 'package:template/common/widgets/custom_button.dart';
import 'package:template/root/app_routers.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Container(
        child: BigCustomButton(
            onPressed: () {
              SharedPreferencesManager.removeToken(SPKeys.ACCESS_TOKEN);
              Navigator.pushReplacementNamed(context, AppRouters.login);
            },
            text: 'Log out'),
      ),
    );
  }
}

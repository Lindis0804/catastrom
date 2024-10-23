import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:template/common/widgets/custom_icon.dart';
import 'package:template/pages/home/screen/home.screen.dart';
import 'package:template/pages/messenger/messenger.screen.dart';
import 'package:template/pages/plans/plans.screen.dart';
import 'package:template/pages/profile/profile.screen.dart';
import 'package:template/pages/shop/shop.screen.dart';

class ManageScreen extends StatefulWidget {
  const ManageScreen({super.key});

  @override
  State<ManageScreen> createState() => _ManageScreenState();
}

class _ManageScreenState extends State<ManageScreen> {
  int index = 2;
  @override
  Widget build(BuildContext context) {
    final screens = [
      const HomeScreen(),
      const PlanScreen(),
      const ShopScreen(),
      const MessengerScreen(),
      const ProfileScreen()
    ];
    final items = <Widget>[
      const ManageNavigationBarIcon(icon: Icons.home),
      const ManageNavigationBarIcon(icon: Icons.directions_walk),
      const ManageNavigationBarIcon(icon: Icons.shopping_cart),
      const ManageNavigationBarIcon(icon: Icons.messenger),
      const ManageNavigationBarIcon(icon: Icons.person_pin)
    ];
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: Theme(
        data: Theme.of(context)
            .copyWith(iconTheme: const IconThemeData(color: Colors.black)),
        child: CurvedNavigationBar(
          height: 60,
          index: index,
          items: items,
          backgroundColor: Colors.white,
          buttonBackgroundColor: Colors.green[700],
          color: const Color(0xffd9d9d9d),
          onTap: (index) => setState(() => this.index = index),
        ),
      ),
    );
  }
}

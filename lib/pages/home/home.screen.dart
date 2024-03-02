import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:template/common/widgets/custom_icon.dart';
import 'package:template/pages/messenger/messenger.screen.dart';
import 'package:template/pages/newfeeds/newfeeds.screen.dart';
import 'package:template/pages/plans/plans.screen.dart';
import 'package:template/pages/profile/profile.screen.dart';
import 'package:template/pages/shop/shop.screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 2;
  @override
  Widget build(BuildContext context) {
    final screens = [
      NewfeedsScreen(),
      PlanScreen(),
      ShopScreen(),
      MessengerScreen(),
      ProfileScreen()
    ];
    final items = <Widget>[
      HomeNavigationBarIcon(icon: Icons.home),
      HomeNavigationBarIcon(icon: Icons.directions_walk),
      HomeNavigationBarIcon(icon: Icons.shopping_cart),
      HomeNavigationBarIcon(icon: Icons.messenger),
      HomeNavigationBarIcon(icon: Icons.person_pin)
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

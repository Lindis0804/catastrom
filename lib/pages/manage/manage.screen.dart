import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/common/constants/colors.dart';
import 'package:template/common/enums/manage.enum.dart';
import 'package:template/pages/home/screen/home.screen.dart';
import 'package:template/pages/manage/bloc/manage.bloc.dart';
import 'package:template/pages/manage/constants.dart';
import 'package:template/pages/newfeeds/newfeeds.screen.dart';
import 'package:template/pages/notifications/screen/notifications.screen.dart';
import 'package:template/pages/plans/screens/plans.screen.dart';
import 'package:template/pages/profile/profile.screen.dart';
import 'package:template/pages/shop/shop.screen.dart';
import 'package:template/pages/trip/trip.screen.dart';
import 'package:template/root/app_routers.dart';
import 'package:template/pages/settings/screen/settings.screen.dart';
import 'package:template/generated/assets.gen.dart';

class Manage extends StatefulWidget {
  const Manage({super.key, required this.manageBloc});
  final ManageBloc manageBloc;

  @override
  State<Manage> createState() => _ManageState();
}

class _ManageState extends State<Manage> {
  @override
  Widget build(BuildContext context) {
    final screens = [
      const HomeScreen(),
      const PlansScreen(),
      const ShopScreen(),
      const TripScreen(),
      const ProfileScreen(),
      const NewfeedsScreen(),
      const ProfileScreen(),
      const NotificationsScreen(),
      const SettingsScreen(),
    ];

    return BlocBuilder<ManageBloc, ManageState>(
      bloc: widget.manageBloc,
      builder: (context, state) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.transparent,
          // appBar: AppBar(
          //   backgroundColor: Colors.transparent,
          //   leading: Builder(
          //     builder: (context) {
          //       return IconButton(
          //         onPressed: () {
          //           Scaffold.of(context).openDrawer();
          //         },
          //         icon: const Icon(
          //           Icons.menu,
          //           color: Colors.white,
          //         ),
          //       );
          //     },
          //   ),
          //   actions: [
          //     CustomImage.network(
          //         imageUrl: state.user?.avatar ?? EnvVariable.defaultAvatar,
          //         width: 30,
          //         height: 30,
          //         radius: 15),
          //     const SizedBox(
          //       width: 10,
          //     )
          //   ],
          // ),
          drawer: Drawer(
            child: ListView(),
          ),
          body: screens[state.pageIdx],
          floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            shape: const CircleBorder(),
            onPressed: () {
              widget.manageBloc.add(
                ChangePageIdxEvent(pageIdx: IManagePageIdx.CREATE_PLAN),
              );
            },
            backgroundColor: CustomColors.primary,
            elevation: 8,
            child: const Icon(
              Icons.add,
              color: Colors.white,
              size: 40,
            ),
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.lightBlueAccent.withValues(alpha: 0.1),
                  blurRadius: 20,
                  offset: const Offset(0, -5),
                  spreadRadius: 0,
                ),
                BoxShadow(
                  color: Colors.lightBlueAccent.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                  spreadRadius: 0,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
              child: BottomAppBar(
                color: Colors.white,
                shape: CustomCircularNotchedRectangle(),
                notchMargin: 12,
                elevation: 0,
                child: SizedBox(
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildBottomNavItem(
                        icon: Assets.svgIcons.homePage,
                        label: 'Trang chủ',
                        index: IManagePageIdx.HOME_PAGE,
                        currentIndex: state.pageIdx,
                        onTap: () => widget.manageBloc.add(
                          ChangePageIdxEvent(pageIdx: IManagePageIdx.HOME_PAGE),
                        ),
                      ),
                      _buildBottomNavItem(
                        icon: Assets.svgIcons.favorite,
                        label: 'Yêu thích',
                        index: IManagePageIdx.FAVORITE,
                        currentIndex: state.pageIdx,
                        onTap: () => widget.manageBloc.add(
                          ChangePageIdxEvent(pageIdx: IManagePageIdx.FAVORITE),
                        ),
                      ),
                      const SizedBox(width: 40), // Khoảng trống cho FAB
                      _buildBottomNavItem(
                        icon: Assets.svgIcons.myPlan,
                        label: 'Kế hoạch',
                        index: IManagePageIdx.MY_PLANS,
                        currentIndex: state.pageIdx,
                        onTap: () => widget.manageBloc.add(
                          ChangePageIdxEvent(pageIdx: IManagePageIdx.MY_PLANS),
                        ),
                      ),
                      _buildBottomNavItem(
                        icon: Assets.svgIcons.profile,
                        label: 'Cá nhân',
                        index: IManagePageIdx.PROFILE,
                        currentIndex: state.pageIdx,
                        onTap: () => widget.manageBloc.add(
                          ChangePageIdxEvent(pageIdx: IManagePageIdx.PROFILE),
                        ),
                      ),
                      // _buildBottomNavItem(
                      //   icon: Assets.svgIcons.profile,
                      //   label: 'Thông báo',
                      //   index: IManagePageIdx.NOTIFICATIONS,
                      //   currentIndex: state.pageIdx,
                      //   onTap: () => widget.manageBloc.add(
                      //     ChangePageIdxEvent(pageIdx: IManagePageIdx.NOTIFICATIONS),
                      //   ),
                      // ),
                      // _buildBottomNavItem(
                      //   icon: Assets.svgIcons.profile,
                      //   label: 'Cài đặt',
                      //   index: IManagePageIdx.SETTINGS,
                      //   currentIndex: state.pageIdx,
                      //   onTap: () => widget.manageBloc.add(
                      //     ChangePageIdxEvent(pageIdx: IManagePageIdx.SETTINGS),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBottomNavItem({
    required SvgGenImage icon,
    required String label,
    required int index,
    required int currentIndex,
    required VoidCallback onTap,
  }) {
    final isSelected = index == currentIndex;
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon.svg(
            height: 24,
            width: 24,
            colorFilter: ColorFilter.mode(
              isSelected ? CustomColors.primary : CustomColors.gray,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: isSelected ? CustomColors.primary : Colors.transparent,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }
}

void _listener(BuildContext context, ManageState state) async {
  switch (state.pageIdx) {
  // case IManagePageIdx.CREATE_PLAN:
  //   ResCreateTrip? resCreateTrip = await Navigator.of(context)
  //       .pushNamed(AppRouters.newPlan) as ResCreateTrip?;
  //   if (!context.mounted) {
  //     return;
  //   }
  //   if (resCreateTrip != null) {
  //     context.read<ManageBloc>().emit(
  //           state.copyWith(
  //             pageManageStatus: EPageManageStatus.init,
  //             pageIdx: IManagePageIdx.MY_PLANS,
  //           ),
  //         );
  //   }

  //   context.read<ManageBloc>().emit(
  //         state.copyWith(
  //           pageManageStatus: EPageManageStatus.init,
  //           pageIdx: IManagePageIdx.HOME_PAGE,
  //         ),
  //       );
  //   break;
    default:
  }
}

class ManageScreen extends StatelessWidget {
  const ManageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ManageBloc>(
      create: (_) => ManageBloc(),
      child: BlocListener<ManageBloc, ManageState>(
        // listenWhen: ((previous, current) =>
        //     previous.loadManagePageStatus != current.loadManagePageStatus ||
        //     previous.pageManageStatus != current.pageManageStatus),
        listener: _listener,
        child: Builder(
          builder: (BuildContext context) => Scaffold(
            resizeToAvoidBottomInset: false,
            body: Manage(manageBloc: context.read<ManageBloc>()),
          ),
        ),
      ),
    );
  }
}

class CustomCircularNotchedRectangle extends CircularNotchedRectangle{
  @override
  Path getOuterPath(Rect host, Rect? guest) {
    if (guest == null || !host.overlaps(guest)) {
      return Path()..addRect(host);
    }

    // The guest's shape is a circle bounded by the guest rectangle.
    // So the guest's radius is half the guest width.
    final double r = guest.width / 2.0;
    final Radius notchRadius = Radius.circular(r);

    // The variables [p2yA] and [p2yB] need to be inverted
    // when the notch is drawn on the bottom of a path.
    final double invertMultiplier = inverted ? -1.0 : 1.0;

    // We build a path for the notch from 3 segments:
    // Segment A - a Bezier curve from the host's top edge to segment B.
    // Segment B - an arc with radius notchRadius.
    // Segment C - a Bezier curve from segment B back to the host's top edge.
    //
    // A detailed explanation and the derivation of the formulas below is
    // available at: https://goo.gl/Ufzrqn

    const double s1 = 15.0;
    const double s2 = 5.0;

    final double a = -r - s2;
    final double b = (inverted ? host.bottom : host.top) - guest.center.dy;

    final double n2 = math.sqrt(b * b * r * r * (a * a + b * b - r * r));
    final double p2xA = ((a * r * r) - n2) / (a * a + b * b);
    final double p2xB = ((a * r * r) + n2) / (a * a + b * b);
    final double p2yA = math.sqrt(r * r - p2xA * p2xA) * invertMultiplier;
    final double p2yB = math.sqrt(r * r - p2xB * p2xB) * invertMultiplier;

    final List<Offset> p = List<Offset>.filled(6, Offset.zero);

    // p0, p1, and p2 are the control points for segment A.
    p[0] = Offset(a - s1, b);
    p[1] = Offset(a, b);
    final double cmp = b < 0 ? -1.0 : 1.0;
    p[2] = cmp * p2yA > cmp * p2yB ? Offset(p2xA, p2yA) : Offset(p2xB, p2yB);

    // p3, p4, and p5 are the control points for segment B, which is a mirror
    // of segment A around the y axis.
    p[3] = Offset(-1.0 * p[2].dx, p[2].dy);
    p[4] = Offset(-1.0 * p[1].dx, p[1].dy);
    p[5] = Offset(-1.0 * p[0].dx, p[0].dy);

    // translate all points back to the absolute coordinate system.
    for (int i = 0; i < p.length; i += 1) {
      p[i] += guest.center;
    }

    // Use the calculated points to draw out a path object.
    final Path path = Path()..moveTo(host.left, host.top);
    if (!inverted) {
      path
        ..lineTo(p[0].dx, p[0].dy)
        ..quadraticBezierTo(p[1].dx, p[1].dy, p[2].dx, p[2].dy)
        ..arcToPoint(p[3], radius: notchRadius, clockwise: false)
        ..quadraticBezierTo(p[4].dx, p[4].dy, p[5].dx, p[5].dy)
        ..lineTo(host.right, host.top)
        ..lineTo(host.right, host.bottom)
        ..lineTo(host.left, host.bottom);
    } else {
      path
        ..lineTo(host.right, host.top)
        ..lineTo(host.right, host.bottom)
        ..lineTo(p[5].dx, p[5].dy)
        ..quadraticBezierTo(p[4].dx, p[4].dy, p[3].dx, p[3].dy)
        ..arcToPoint(p[2], radius: notchRadius, clockwise: false)
        ..quadraticBezierTo(p[1].dx, p[1].dy, p[0].dx, p[0].dy)
        ..lineTo(host.left, host.bottom);
    }

    return path..close();
  }
}
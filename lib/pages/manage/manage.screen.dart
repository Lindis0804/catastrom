import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/common/constants/colors.dart';
import 'package:template/pages/home/screen/home.screen.dart';
import 'package:template/pages/manage/bloc/manage.bloc.dart';
import 'package:template/pages/manage/constants.dart';
import 'package:template/pages/newfeeds/newfeeds.screen.dart';
import 'package:template/pages/notifications/screen/notifications.screen.dart';
import 'package:template/pages/plans/screens/plans.screen.dart';
import 'package:template/pages/profile/profile.screen.dart';
import 'package:template/pages/settings/screen/settings.screen.dart';
import 'package:template/generated/assets.gen.dart';
import 'package:template/pages/shop/shop.screen.dart';
import 'package:template/pages/trip/trip.screen.dart';
import 'dart:math' as math;

class Manage extends StatefulWidget {
  const Manage({super.key, required this.manageBloc});
  final ManageBloc manageBloc;

  @override
  State<Manage> createState() => _ManageState();
}

BottomNavigationBarItem getCustomNavigationItem(
    {required SvgGenImage icon,
    required String label,
    bool isSelected = false}) {
  return BottomNavigationBarItem(
    icon: icon.svg(
      height: 24,
      width: 24,
      color: isSelected ? CustomColors.primary : CustomColors.gray,
    ),
    label: label,
  );
}

class _ManageState extends State<Manage> {
  @override
  Widget build(BuildContext context) {
    final screens = [
      const HomeScreen(),
      const TripScreen(),
      const NewfeedsScreen(),
      const ProfileScreen(),
      const NotificationsScreen(),
      const SettingsScreen(),
    ];
    final items = <BottomNavigationBarItem>[];

    return BlocBuilder<ManageBloc, ManageState>(
      bloc: widget.manageBloc,
      builder: (context, state) {
        return Scaffold(
          body: screens[state.pageIdx],
          bottomNavigationBar: Theme(
            data: Theme.of(context)
                .copyWith(iconTheme: const IconThemeData(color: Colors.black)),
            child: BottomNavigationBar(
              currentIndex: state.pageIdx,
              selectedItemColor: CustomColors.primary,
              items: <BottomNavigationBarItem>[
                getCustomNavigationItem(
                    icon: Assets.svgIcons.homePage,
                    label: 'Trang chủ',
                    isSelected: state.pageIdx == IManagePageIdx.HOME_PAGE),
                getCustomNavigationItem(
                    icon: Assets.svgIcons.myPlan,
                    label: 'Kế hoạch',
                    isSelected: state.pageIdx == IManagePageIdx.MY_PLANS),
                getCustomNavigationItem(
                    icon: Assets.svgIcons.favorite,
                    label: 'Yêu thích',
                    isSelected: state.pageIdx == IManagePageIdx.FAVORITE),
                getCustomNavigationItem(
                    icon: Assets.svgIcons.profile,
                    label: 'Cá nhân',
                    isSelected: state.pageIdx == IManagePageIdx.PROFILE),
                getCustomNavigationItem(
                    icon: Assets.svgIcons.notify,
                    label: 'Thông báo',
                    isSelected: state.pageIdx == IManagePageIdx.NOTIFICATIONS),
                getCustomNavigationItem(
                    icon: Assets.svgIcons.settings,
                    label: 'Cài đặt',
                    isSelected: state.pageIdx == IManagePageIdx.SETTINGS),
              ],
              backgroundColor: Colors.white,
              onTap: (index) {
                widget.manageBloc.add(
                  ChangePageIdxEvent(pageIdx: index),
                );
              },
            ),
          ),
        );
      },
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

class CustomCircularNotchedRectangle extends CircularNotchedRectangle {
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

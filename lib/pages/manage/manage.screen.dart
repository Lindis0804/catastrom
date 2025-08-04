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

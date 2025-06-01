import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/common/constants/colors.dart';
import 'package:template/common/enums/manage.enum.dart';
import 'package:template/common/widgets/custom_icon.dart';
import 'package:template/pages/home/screen/home.screen.dart';
import 'package:template/pages/manage/bloc/manage.bloc.dart';
import 'package:template/pages/manage/constants.dart';
import 'package:template/pages/messenger/messenger.screen.dart';
import 'package:template/pages/plans/screens/plans.screen.dart';
import 'package:template/pages/profile/profile.screen.dart';
import 'package:template/pages/shop/shop.screen.dart';
import 'package:template/root/app_routers.dart';
import 'package:template/generated/assets.gen.dart';

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
      const PlansScreen(),
      const ShopScreen(),
      const MessengerScreen(),
      const ProfileScreen()
    ];
    final items = <BottomNavigationBarItem>[];

    return BlocBuilder<ManageBloc, ManageState>(
      bloc: widget.manageBloc,
      builder: (context, state) {
        return Scaffold(
          body: screens[state.pageIdx],
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            shape: CircleBorder(),
            onPressed: () {
              widget.manageBloc.add(
                ChangePageIdxEvent(pageIdx: IManagePageIdx.CREATE_PLAN),
              );
            },
            backgroundColor: CustomColors.primary,
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
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
                    icon: Assets.svgIcons.favorite,
                    label: 'Yêu thích',
                    isSelected: state.pageIdx == IManagePageIdx.FAVORITE),
                const BottomNavigationBarItem(
                  icon: const SizedBox(
                      height: 24, width: 24), // chỗ trống cho FAB
                  label: '',
                ),
                getCustomNavigationItem(
                    icon: Assets.svgIcons.myPlan,
                    label: 'Kế hoạch',
                    isSelected: state.pageIdx == IManagePageIdx.MY_PLANS),
                getCustomNavigationItem(
                    icon: Assets.svgIcons.profile,
                    label: 'Cá nhân',
                    isSelected: state.pageIdx == IManagePageIdx.PROFILE),
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
    case IManagePageIdx.CREATE_PLAN:
      await Navigator.of(context).pushNamed(AppRouters.newPlan);
      if (!context.mounted) {
        return;
      }
      context.read<ManageBloc>().emit(
            state.copyWith(
              pageManageStatus: EPageManageStatus.init,
              pageIdx: IManagePageIdx.HOME_PAGE,
            ),
          );
      break;
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

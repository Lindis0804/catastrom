import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/common/constants/colors.dart';
import 'package:template/common/utils/env.dart';
import 'package:template/common/utils/share_preferences.dart';
import 'package:template/common/utils/size.dart';
import 'package:template/common/widgets/custom_button.dart';
import 'package:template/common/widgets/custom_image.widget.dart';
import 'package:template/generated/assets.gen.dart';
import 'package:template/pages/profile/bloc/profile.bloc.dart';
import 'package:template/pages/profile/custom_detail_item.dart';
import 'package:template/root/app_routers.dart';

class BLOCProfile extends StatefulWidget {
  final ProfileBloc profileBloc;
  const BLOCProfile({super.key, required this.profileBloc});

  @override
  State<BLOCProfile> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<BLOCProfile> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = getScreenHeight(context);
    double screenWidth = getScreenWidth(context);
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return Scaffold(
          body: Container(
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Image(
                        image: Assets.images.defaultCover.provider(),
                        width: screenWidth,
                        height: 200,
                        fit: BoxFit.fitWidth),
                    Column(
                      children: [
                        const SizedBox(height: 150),
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.white,
                              width: 5,
                            ),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: CustomImage.network(
                              imageUrl: state.user?.avatar ??
                                  EnvVariable.defaultAvatar,
                              width: 100,
                              height: 100,
                              radius: 100),
                        ),
                        Text(
                          '${state.user?.firstName} ${state.user?.lastName}',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Chi tiết',
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: CustomColors.primary))
                                ],
                              ),
                              CustomDetailItem(
                                title: 'Số chuyến đi',
                                value: '0',
                                icon: Assets.svgIcons.trip,
                              ),
                              CustomDetailItem(
                                title: 'Gần đây',
                                value: 'Unknown',
                                icon: Assets.svgIcons.location,
                              ),
                              CustomDetailItem(
                                title: 'Số điện thoại',
                                value: 'Unknown',
                                icon: Assets.svgIcons.phone,
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) => BlocProvider<ProfileBloc>(
        create: (_) => ProfileBloc(),
        child: BlocListener<ProfileBloc, ProfileState>(
          // listenWhen: (pre, cur) => pre.homeStatus != cur.homeStatus,
          listener: _listener,
          child: Builder(
            builder: (BuildContext context) => BLOCProfile(
              profileBloc: context.read<ProfileBloc>(),
            ),
          ),
        ),
      );
}

void _listener(BuildContext context, ProfileState state) {}

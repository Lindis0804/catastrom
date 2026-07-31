import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/api/user/dto/addFriend/ReqAddFriend.dart';
import 'package:template/common/constants/colors.dart';
import 'package:template/common/enums/loading_status.enum.dart';
import 'package:template/common/utils/env.dart';
import 'package:template/common/utils/size.dart';
import 'package:template/common/utils/user.utils.dart';
import 'package:template/common/widgets/custom_button.dart';
import 'package:template/common/widgets/custom_image.widget.dart';
import 'package:template/generated/assets.gen.dart';
import 'package:template/pages/profile/bloc/profile.bloc.dart';
import 'package:template/pages/profile/custom_detail_item.dart';

class ProfileBlocBuilder extends StatefulWidget {
  final ProfileBloc profileBloc;
  final int? userId;
  const ProfileBlocBuilder({super.key, required this.profileBloc, this.userId});

  @override
  State<ProfileBlocBuilder> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileBlocBuilder> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.profileBloc.add(Inititalize(userId: widget.userId));
  }

  Future<void> _onRefresh() {
    widget.profileBloc.add(Inititalize(userId: widget.userId));
    return widget.profileBloc.stream
        .firstWhere((state) => state.getUserStatus.isCompleted);
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = getScreenHeight(context);
    double screenWidth = getScreenWidth(context);
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return Scaffold(
          appBar: widget.userId != null
              ? AppBar(
                  title: const Text('Profile'),
                )
              : null,
          body: RefreshIndicator(
            onRefresh: _onRefresh,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
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
                              imageUrl: state.user?.avatarUrl ??
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
                                  Text(
                                    'Chi tiết',
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: CustomColors.primary),
                                  )
                                ],
                              ),
                              CustomDetailItem(
                                title: 'email',
                                value: state.user?.email ?? '',
                                materialIcon: CupertinoIcons.mail_solid,
                              ),
                              CustomDetailItem(
                                title: 'số điện thoại',
                                value: state.user?.phone ?? '',
                                materialIcon: CupertinoIcons.phone_fill,
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
          ),
        );
      },
    );
  }
}

class ProfileScreen extends StatelessWidget {
  final int? userId;
  const ProfileScreen({super.key, this.userId});
  @override
  Widget build(BuildContext context) => BlocProvider<ProfileBloc>(
        create: (_) => ProfileBloc(),
        child: BlocListener<ProfileBloc, ProfileState>(
          // listenWhen: (pre, cur) => pre.homeStatus != cur.homeStatus,
          listener: _listener,
          child: Builder(
            builder: (BuildContext context) => ProfileBlocBuilder(
              profileBloc: context.read<ProfileBloc>(),
              userId: userId,
            ),
          ),
        ),
      );
}

void _listener(BuildContext context, ProfileState state) {}

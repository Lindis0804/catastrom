import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/common/enums/loading_status.enum.dart';
import 'package:template/common/utils/size.dart';
import 'package:template/common/widgets/custom_image.widget.dart';
import 'package:template/generated/assets.gen.dart';
import 'package:template/pages/template/bloc/template.bloc.dart';

class Home extends StatefulWidget {
  final HomeBloc homeBloc;
  const Home({super.key, required this.homeBloc});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = getScreenHeight(context);
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Stack(
          children: [
            Image(
              image: Assets.images.defaultCover.provider(),
              height: screenHeight * 0.37,
            ),
            Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                leading: Builder(
                  builder: (context) {
                    return IconButton(
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                      icon: const Icon(
                        Icons.menu,
                        color: Colors.white,
                      ),
                    );
                  },
                ),
                actions: [
                  CustomImage.asset(
                      imagePath: 'assets/images/default_avatar.png',
                      width: 30,
                      height: 30,
                      radius: 15),
                  const SizedBox(
                    width: 10,
                  )
                ],
              ),
              drawer: Drawer(
                child: ListView(),
              ),
              body: Container(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Good morning, Hiếu',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Colors.white,
                              ),
                              Text(
                                'Đại Lộ Thăng Long, Hà Nội',
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) => BlocProvider<HomeBloc>(
        create: (_) => HomeBloc(),
        child: BlocListener<HomeBloc, HomeState>(
          listenWhen: (pre, cur) => pre.homeStatus != cur.homeStatus,
          listener: _listener,
          child: Builder(
            builder: (BuildContext context) => Home(
              homeBloc: context.read<HomeBloc>(),
            ),
          ),
        ),
      );
}

void _listener(BuildContext context, HomeState state) {
  switch (state.homeStatus) {
    case LoadingStatus.initialize:
    default:
  }
}

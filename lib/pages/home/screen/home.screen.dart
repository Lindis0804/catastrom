import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/common/enums/loading_status.enum.dart';
import 'package:template/common/utils/size.dart';
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
                actions: [],
              ),
              drawer: Drawer(
                child: ListView(),
              ),
            )
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

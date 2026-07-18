import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/common/enums/loading_status.enum.dart';
import 'package:template/common/utils/size.dart';

import 'package:template/pages/home/bloc/home.bloc.dart';

class Home extends StatefulWidget {
  final HomeBloc homeBloc;
  const Home({super.key, required this.homeBloc});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.homeBloc.add(const Inititalize());
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = getScreenHeight(context);
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Container();
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

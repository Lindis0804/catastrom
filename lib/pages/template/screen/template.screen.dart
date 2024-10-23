import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/common/enums/loading_status.enum.dart';
import 'package:template/pages/template/bloc/template.bloc.dart';

class Template extends StatefulWidget {
  final HomeBloc templateBloc;
  const Template({super.key, required this.templateBloc});

  @override
  State<Template> createState() => _TemplateState();
}

class _TemplateState extends State<Template> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return const Scaffold(
          body: SafeArea(child: Text('template')),
        );
      },
    );
  }
}

class TemplateScreen extends StatelessWidget {
  const TemplateScreen({super.key});
  @override
  Widget build(BuildContext context) => BlocProvider<HomeBloc>(
        create: (_) => HomeBloc(),
        child: BlocListener<HomeBloc, HomeState>(
          listenWhen: (pre, cur) => pre.homeStatus != cur.homeStatus,
          listener: _listener,
          child: Builder(
            builder: (BuildContext context) => Template(
              templateBloc: context.read<HomeBloc>(),
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

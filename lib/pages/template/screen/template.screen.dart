import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/common/enums/loading_status.enum.dart';
import 'package:template/pages/template/bloc/template.bloc.dart';

class Template extends StatefulWidget {
  final TemplateBloc templateBloc;
  const Template({super.key, required this.templateBloc});

  @override
  State<Template> createState() => _TemplateState();
}

class _TemplateState extends State<Template> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TemplateBloc, TemplateState>(
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
  Widget build(BuildContext context) => BlocProvider<TemplateBloc>(
        create: (_) => TemplateBloc(),
        child: BlocListener<TemplateBloc, TemplateState>(
          listenWhen: (pre, cur) => pre.homeStatus != cur.homeStatus,
          listener: _listener,
          child: Builder(
            builder: (BuildContext context) => Template(
              templateBloc: context.read<TemplateBloc>(),
            ),
          ),
        ),
      );
}

void _listener(BuildContext context, TemplateState state) {
  switch (state.homeStatus) {
    case LoadingStatus.initialize:
    default:
  }
}

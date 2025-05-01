import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/common/enums/loading_status.enum.dart';
import 'package:template/pages/new_plan/bloc/new_plan.bloc.dart';

class NewPlan extends StatefulWidget {
  final NewPlanBloc newPlanBloc;
  const NewPlan({super.key, required this.newPlanBloc});

  @override
  State<NewPlan> createState() => _NewPlanState();
}

class _NewPlanState extends State<NewPlan> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewPlanBloc, NewPlanState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Container(),
        );
      },
    );
  }
}

class NewPlanScreen extends StatelessWidget {
  const NewPlanScreen({super.key});
  @override
  Widget build(BuildContext context) => BlocProvider<NewPlanBloc>(
        create: (_) => NewPlanBloc(),
        child: BlocListener<NewPlanBloc, NewPlanState>(
          listener: _listener,
          child: Builder(
            builder: (BuildContext context) => NewPlan(
              newPlanBloc: context.read<NewPlanBloc>(),
            ),
          ),
        ),
      );
}

void _listener(BuildContext context, NewPlanState state) {
  switch (state.createPlanStatus) {
    case LoadingStatus.initialize:
    default:
  }
}

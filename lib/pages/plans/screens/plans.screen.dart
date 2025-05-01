import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/common/enums/plans.enum.dart';
import 'package:template/pages/home/screen/my_plan.item.dart';
import 'package:template/pages/plans/bloc/plans.bloc.dart';
import 'package:template/pages/plans/screens/custom_app_bar.dart';
import 'package:template/root/app_routers.dart';

class Plans extends StatefulWidget {
  final PlansBloc plansBloc;
  const Plans({super.key, required this.plansBloc});

  @override
  State<Plans> createState() => _PlanState();
}

class _PlanState extends State<Plans> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlansBloc, PlansState>(
      builder: (context, state) => Scaffold(
        appBar: const CustomAppBar(name: "Hiếu"),
        body: Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Lịch trình của tôi',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      widget.plansBloc.add(
                        const ToNewPlanScreenEvent(),
                      );
                    },
                    icon: const Icon(
                      Icons.add,
                      size: 40,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: state.myPlans != null && state.myPlans!.isNotEmpty
                    ? ListView.separated(
                        itemBuilder: (context, idx) {
                          return MyPlanItem(
                            plan: state.myPlans![idx],
                          );
                        },
                        separatorBuilder: (context, idx) {
                          return const SizedBox(
                            height: 5,
                          );
                        },
                        itemCount: state.myPlans!.length)
                    : const Text('Không có lịch trình'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PlansScreen extends StatelessWidget {
  const PlansScreen({super.key});
  @override
  Widget build(BuildContext context) => BlocProvider<PlansBloc>(
        create: (_) => PlansBloc(),
        child: BlocListener<PlansBloc, PlansState>(
          listener: _listener,
          child: Builder(
            builder: (BuildContext context) => Plans(
              plansBloc: context.read<PlansBloc>(),
            ),
          ),
        ),
      );
}

void _listener(BuildContext context, PlansState state) async {
  switch (state.plansStatus) {
    case EPlans.toNewPlanScreen:
      dynamic plan = await Navigator.of(context).pushNamed(AppRouters.newPlan);

      if (context.mounted) {
        context.read<PlansBloc>().add(CreatedPlanEvent(plan: plan));
      }

    default:
  }
}

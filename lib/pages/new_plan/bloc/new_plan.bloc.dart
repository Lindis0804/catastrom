import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/api/plan/dto/CreatePlanDto.dart';
import 'package:template/common/enums/loading_status.enum.dart';
import 'package:template/data/models/plan/plan.model.dart';

part 'new_plan.event.dart';
part 'new_plan.state.dart';

class NewPlanBloc extends Bloc<NewPlanEvent, NewPlanState> {
  NewPlanBloc() : super(NewPlanState.initialize()) {
    on<Inititalize>(_onInitialize);
    on<CreatePlanEvent>(_onCreatePlan);
    add(
      const Inititalize(),
    );
  }

  void _onInitialize(
    NewPlanEvent event,
    Emitter<NewPlanState> emitter,
  ) async {
    if (event is! Inititalize) {
      return;
    }
  }

  void _onCreatePlan(
    NewPlanEvent event,
    Emitter<NewPlanState> emitter,
  ) async {}
}

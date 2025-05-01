part of 'new_plan.bloc.dart';

sealed class NewPlanEvent {
  const NewPlanEvent();
}

class Inititalize extends NewPlanEvent {
  const Inititalize();
}

class CreatePlanEvent extends NewPlanEvent {
  final CreatePlanDto createPlanDto;

  const CreatePlanEvent({required this.createPlanDto});
}

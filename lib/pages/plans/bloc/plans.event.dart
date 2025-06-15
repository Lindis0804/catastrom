part of 'plans.bloc.dart';

sealed class PlansEvent {
  const PlansEvent();
}

class Inititalize extends PlansEvent {
  const Inititalize();
}

class ToNewPlanScreenEvent extends PlansEvent {
  const ToNewPlanScreenEvent();
}

class CreatedPlanEvent extends PlansEvent {
  final Plan? plan;
  const CreatedPlanEvent({this.plan});
}

class DeletePlanEvent extends PlansEvent {
  final String planCode;
  const DeletePlanEvent({required this.planCode});
}

class ToEditPlanScreenEvent extends PlansEvent {
  const ToEditPlanScreenEvent();
}

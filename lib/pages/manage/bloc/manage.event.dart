part of 'manage.bloc.dart';

sealed class ManageEvent {
  const ManageEvent();
}

class Inititalize extends ManageEvent {
  const Inititalize();
}

class ToPageCreatePlanEvent extends ManageEvent {
  const ToPageCreatePlanEvent();
}

class ChangePageIdxEvent extends ManageEvent {
  final int pageIdx;

  ChangePageIdxEvent({required this.pageIdx});
}

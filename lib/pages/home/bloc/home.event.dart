part of 'home.bloc.dart';

sealed class HomeEvent {
  const HomeEvent();
}

class Inititalize extends HomeEvent {
  const Inititalize();
}

class ChangeMonthFilterEvent extends HomeEvent {
  final DateTime? monthFrom;
  final DateTime? monthTo;
  const ChangeMonthFilterEvent({this.monthFrom, this.monthTo});
}

class ChangeSortOrderEvent extends HomeEvent {
  final ESortOrder order;
  const ChangeSortOrderEvent({required this.order});
}

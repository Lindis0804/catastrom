part of 'spending_by_category.bloc.dart';

sealed class SpendingByCategoryEvent {
  const SpendingByCategoryEvent();
}

class Inititalize extends SpendingByCategoryEvent {
  const Inititalize();
}

class RefreshEvent extends SpendingByCategoryEvent {
  const RefreshEvent();
}

class ChangeOrderEvent extends SpendingByCategoryEvent {
  final ESortOrder order;
  const ChangeOrderEvent({required this.order});
}

part of 'payment_transactions.bloc.dart';

sealed class PaymentTransactionsEvent {
  const PaymentTransactionsEvent();
}

class Inititalize extends PaymentTransactionsEvent {
  const Inititalize();
}

class LoadTransactions extends PaymentTransactionsEvent {
  const LoadTransactions();
}

class ToggleFilterEvent extends PaymentTransactionsEvent {
  const ToggleFilterEvent();
}

class FilterChanged extends PaymentTransactionsEvent {
  final List<Category>? categories;
  final DateTime? dateFrom;
  final DateTime? dateTo;
  const FilterChanged({this.categories, this.dateFrom, this.dateTo});
}

class ToAddTransactionsEvent extends PaymentTransactionsEvent {
  const ToAddTransactionsEvent();
}

class BackFromAddTransactionsEvent extends PaymentTransactionsEvent {
  const BackFromAddTransactionsEvent();
}

class DeleteTransactionEvent extends PaymentTransactionsEvent {
  final int id;
  const DeleteTransactionEvent({required this.id});
}

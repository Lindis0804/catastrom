part of 'add_transactions.bloc.dart';

sealed class AddTransactionsEvent {
  const AddTransactionsEvent();
}

class Inititalize extends AddTransactionsEvent {
  const Inititalize();
}

class AddTempTransactionEvent extends AddTransactionsEvent {
  final Transaction transaction;
  const AddTempTransactionEvent({required this.transaction});
}

class RemoveTempTransactionEvent extends AddTransactionsEvent {
  final int index;
  const RemoveTempTransactionEvent({required this.index});
}

class SubmitTransactionsEvent extends AddTransactionsEvent {
  const SubmitTransactionsEvent();
}

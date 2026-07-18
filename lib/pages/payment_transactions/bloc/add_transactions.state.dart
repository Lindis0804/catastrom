part of 'add_transactions.bloc.dart';

class AddTransactionsState extends Equatable {
  final EAddTransactions pageStatus;
  final LoadingStatus getCategoriesStatus, submitStatus;
  final List<Category>? categories;
  final List<Transaction> tempTransactions;
  final String? getCategoriesErrMsg, submitErrMsg;

  const AddTransactionsState({
    this.pageStatus = EAddTransactions.init,
    this.getCategoriesStatus = LoadingStatus.initialize,
    this.submitStatus = LoadingStatus.initialize,
    this.categories,
    this.tempTransactions = const [],
    this.getCategoriesErrMsg,
    this.submitErrMsg,
  });

  factory AddTransactionsState.initialize() {
    return const AddTransactionsState();
  }

  AddTransactionsState copyWith({
    EAddTransactions? pageStatus,
    LoadingStatus? getCategoriesStatus,
    LoadingStatus? submitStatus,
    List<Category>? categories,
    List<Transaction>? tempTransactions,
    String? getCategoriesErrMsg,
    String? submitErrMsg,
  }) {
    return AddTransactionsState(
      pageStatus: pageStatus ?? this.pageStatus,
      getCategoriesStatus: getCategoriesStatus ?? this.getCategoriesStatus,
      submitStatus: submitStatus ?? this.submitStatus,
      categories: categories ?? this.categories,
      tempTransactions: tempTransactions ?? this.tempTransactions,
      getCategoriesErrMsg: getCategoriesErrMsg ?? this.getCategoriesErrMsg,
      submitErrMsg: submitErrMsg ?? this.submitErrMsg,
    );
  }

  @override
  List<Object?> get props => [
        pageStatus,
        getCategoriesStatus,
        submitStatus,
        categories,
        tempTransactions,
        getCategoriesErrMsg,
        submitErrMsg,
      ];
}

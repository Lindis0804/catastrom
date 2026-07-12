part of 'payment_transactions.bloc.dart';

class PaymentTransactionsState extends Equatable {
  final EPaymentTransactions pageStatus;
  final LoadingStatus getTransactionsStatus,
      getCategoriesStatus,
      deleteTransactionStatus;
  final List<Transaction>? transactions;
  final List<Category>? categories;
  final List<Category> selectedFilterCategories;
  final DateTime dateFrom, dateTo;
  final bool isFilterExpanded;
  final String? getTransactionsErrMsg,
      getCategoriesErrMsg,
      deleteTransactionErrMsg;

  const PaymentTransactionsState({
    this.pageStatus = EPaymentTransactions.init,
    this.getTransactionsStatus = LoadingStatus.initialize,
    this.getCategoriesStatus = LoadingStatus.initialize,
    this.deleteTransactionStatus = LoadingStatus.initialize,
    this.transactions,
    this.categories,
    this.selectedFilterCategories = const [],
    required this.dateFrom,
    required this.dateTo,
    this.isFilterExpanded = false,
    this.getTransactionsErrMsg,
    this.getCategoriesErrMsg,
    this.deleteTransactionErrMsg,
  });

  factory PaymentTransactionsState.initialize() {
    DateTime now = DateTime.now();
    return PaymentTransactionsState(
      dateFrom: now.subtract(const Duration(days: 10)),
      dateTo: now,
    );
  }

  PaymentTransactionsState copyWith({
    EPaymentTransactions? pageStatus,
    LoadingStatus? getTransactionsStatus,
    LoadingStatus? getCategoriesStatus,
    LoadingStatus? deleteTransactionStatus,
    List<Transaction>? transactions,
    List<Category>? categories,
    List<Category>? selectedFilterCategories,
    DateTime? dateFrom,
    DateTime? dateTo,
    bool? isFilterExpanded,
    String? getTransactionsErrMsg,
    String? getCategoriesErrMsg,
    String? deleteTransactionErrMsg,
  }) {
    return PaymentTransactionsState(
      pageStatus: pageStatus ?? this.pageStatus,
      getTransactionsStatus: getTransactionsStatus ?? this.getTransactionsStatus,
      getCategoriesStatus: getCategoriesStatus ?? this.getCategoriesStatus,
      deleteTransactionStatus:
          deleteTransactionStatus ?? this.deleteTransactionStatus,
      transactions: transactions ?? this.transactions,
      categories: categories ?? this.categories,
      selectedFilterCategories:
          selectedFilterCategories ?? this.selectedFilterCategories,
      dateFrom: dateFrom ?? this.dateFrom,
      dateTo: dateTo ?? this.dateTo,
      isFilterExpanded: isFilterExpanded ?? this.isFilterExpanded,
      getTransactionsErrMsg: getTransactionsErrMsg ?? this.getTransactionsErrMsg,
      getCategoriesErrMsg: getCategoriesErrMsg ?? this.getCategoriesErrMsg,
      deleteTransactionErrMsg:
          deleteTransactionErrMsg ?? this.deleteTransactionErrMsg,
    );
  }

  @override
  List<Object?> get props => [
        pageStatus,
        getTransactionsStatus,
        getCategoriesStatus,
        deleteTransactionStatus,
        transactions,
        categories,
        selectedFilterCategories,
        dateFrom,
        dateTo,
        isFilterExpanded,
        getTransactionsErrMsg,
        getCategoriesErrMsg,
        deleteTransactionErrMsg,
      ];
}

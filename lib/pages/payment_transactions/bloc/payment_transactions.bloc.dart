import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/api/payment/provider.dart';
import 'package:template/common/enums/loading_status.enum.dart';
import 'package:template/common/enums/payment_transactions.enum.dart';
import 'package:template/common/utils/share_preferences.dart';
import 'package:template/data/models/payment/category.model.dart';
import 'package:template/data/models/payment/transaction.model.dart';

part 'payment_transactions.event.dart';
part 'payment_transactions.state.dart';

class PaymentTransactionsBloc
    extends Bloc<PaymentTransactionsEvent, PaymentTransactionsState> {
  PaymentTransactionsBloc() : super(PaymentTransactionsState.initialize()) {
    on<Inititalize>(_onInitialize);
    on<LoadTransactions>(_onLoadTransactions);
    on<ToggleFilterEvent>(_onToggleFilter);
    on<FilterChanged>(_onFilterChanged);
    on<ToAddTransactionsEvent>(_onToAddTransactions);
    on<BackFromAddTransactionsEvent>(_onBackFromAddTransactions);
    on<DeleteTransactionEvent>(_onDeleteTransaction);

    add(const Inititalize());
  }

  void _onInitialize(
    PaymentTransactionsEvent event,
    Emitter<PaymentTransactionsState> emitter,
  ) async {
    if (event is! Inititalize) {
      return;
    }

    emitter(
      state.copyWith(
        getTransactionsStatus: LoadingStatus.loading,
        getCategoriesStatus: LoadingStatus.loading,
      ),
    );

    String accessToken = await SharedPreferencesManager.getAccessToken();
    PaymentApiProvider paymentApiProvider =
        PaymentApiProvider(accessToken: accessToken);

    await Future.wait(
      [
        () async {
          try {
            List<Category> categories =
                await paymentApiProvider.getCategories();
            emitter(
              state.copyWith(
                categories: categories,
                getCategoriesStatus: LoadingStatus.loaded,
              ),
            );
          } catch (err) {
            emitter(
              state.copyWith(
                getCategoriesStatus: LoadingStatus.error,
                getCategoriesErrMsg: 'Get categories fail: $err',
              ),
            );
          }
        }(),
        () async {
          try {
            List<Transaction> transactions =
                await paymentApiProvider.getTransactions(
              dateFrom: state.dateFrom,
              dateTo: state.dateTo,
              categoryIds: state.selectedFilterCategories.isEmpty
                  ? null
                  : state.selectedFilterCategories.map((c) => c.id).toList(),
            );
            transactions.sort((a, b) => b.transDate.compareTo(a.transDate));
            emitter(
              state.copyWith(
                transactions: transactions,
                getTransactionsStatus: LoadingStatus.loaded,
              ),
            );
          } catch (err) {
            emitter(
              state.copyWith(
                getTransactionsStatus: LoadingStatus.error,
                getTransactionsErrMsg: 'Get transactions fail: $err',
              ),
            );
          }
        }(),
      ],
    );
  }

  void _onLoadTransactions(
    PaymentTransactionsEvent event,
    Emitter<PaymentTransactionsState> emitter,
  ) async {
    emitter(
      state.copyWith(getTransactionsStatus: LoadingStatus.loading),
    );
    try {
      String accessToken = await SharedPreferencesManager.getAccessToken();
      List<Transaction> transactions =
          await PaymentApiProvider(accessToken: accessToken).getTransactions(
        dateFrom: state.dateFrom,
        dateTo: state.dateTo,
        categoryIds: state.selectedFilterCategories.isEmpty
            ? null
            : state.selectedFilterCategories.map((c) => c.id).toList(),
      );
      transactions.sort((a, b) => b.transDate.compareTo(a.transDate));
      emitter(
        state.copyWith(
          transactions: transactions,
          getTransactionsStatus: LoadingStatus.loaded,
        ),
      );
    } catch (err) {
      emitter(
        state.copyWith(
          getTransactionsStatus: LoadingStatus.error,
          getTransactionsErrMsg: 'Get transactions fail: $err',
        ),
      );
    }
  }

  void _onToggleFilter(
    PaymentTransactionsEvent event,
    Emitter<PaymentTransactionsState> emitter,
  ) {
    emitter(
      state.copyWith(isFilterExpanded: !state.isFilterExpanded),
    );
  }

  void _onFilterChanged(
    FilterChanged event,
    Emitter<PaymentTransactionsState> emitter,
  ) {
    emitter(
      state.copyWith(
        selectedFilterCategories: event.categories,
        dateFrom: event.dateFrom,
        dateTo: event.dateTo,
      ),
    );
    add(const LoadTransactions());
  }

  void _onToAddTransactions(
    PaymentTransactionsEvent event,
    Emitter<PaymentTransactionsState> emitter,
  ) {
    emitter(
      state.copyWith(pageStatus: EPaymentTransactions.toAddTransactions),
    );
  }

  void _onBackFromAddTransactions(
    PaymentTransactionsEvent event,
    Emitter<PaymentTransactionsState> emitter,
  ) {
    emitter(
      state.copyWith(pageStatus: EPaymentTransactions.init),
    );
    add(const LoadTransactions());
  }

  void _onDeleteTransaction(
    DeleteTransactionEvent event,
    Emitter<PaymentTransactionsState> emitter,
  ) async {
    emitter(
      state.copyWith(deleteTransactionStatus: LoadingStatus.loading),
    );
    try {
      String accessToken = await SharedPreferencesManager.getAccessToken();
      await PaymentApiProvider(accessToken: accessToken)
          .deleteTransaction(event.id);
      List<Transaction> transactions = [...state.transactions ?? []]
        ..removeWhere((t) => t.id == event.id);
      emitter(
        state.copyWith(
          transactions: transactions,
          deleteTransactionStatus: LoadingStatus.loaded,
        ),
      );
    } catch (err) {
      emitter(
        state.copyWith(
          deleteTransactionStatus: LoadingStatus.error,
          deleteTransactionErrMsg: '$err',
        ),
      );
    }
  }
}

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/api/payment/provider.dart';
import 'package:template/common/enums/loading_status.enum.dart';
import 'package:template/common/enums/payment_transactions.enum.dart';
import 'package:template/common/utils/share_preferences.dart';
import 'package:template/data/models/payment/category.model.dart';
import 'package:template/data/models/payment/transaction.model.dart';

part 'add_transactions.event.dart';
part 'add_transactions.state.dart';

class AddTransactionsBloc
    extends Bloc<AddTransactionsEvent, AddTransactionsState> {
  AddTransactionsBloc() : super(AddTransactionsState.initialize()) {
    on<Inititalize>(_onInitialize);
    on<AddTempTransactionEvent>(_onAddTempTransaction);
    on<RemoveTempTransactionEvent>(_onRemoveTempTransaction);
    on<SubmitTransactionsEvent>(_onSubmitTransactions);

    add(const Inititalize());
  }

  void _onInitialize(
    AddTransactionsEvent event,
    Emitter<AddTransactionsState> emitter,
  ) async {
    if (event is! Inititalize) {
      return;
    }
    emitter(
      state.copyWith(getCategoriesStatus: LoadingStatus.loading),
    );
    try {
      String accessToken = await SharedPreferencesManager.getAccessToken();
      List<Category> categories =
          await PaymentApiProvider(accessToken: accessToken).getCategories();
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
  }

  void _onAddTempTransaction(
    AddTempTransactionEvent event,
    Emitter<AddTransactionsState> emitter,
  ) {
    List<Transaction> tempTransactions = [
      ...state.tempTransactions,
      event.transaction,
    ];
    emitter(
      state.copyWith(tempTransactions: tempTransactions),
    );
  }

  void _onRemoveTempTransaction(
    RemoveTempTransactionEvent event,
    Emitter<AddTransactionsState> emitter,
  ) {
    List<Transaction> tempTransactions = [...state.tempTransactions]
      ..removeAt(event.index);
    emitter(
      state.copyWith(tempTransactions: tempTransactions),
    );
  }

  void _onSubmitTransactions(
    AddTransactionsEvent event,
    Emitter<AddTransactionsState> emitter,
  ) async {
    if (state.tempTransactions.isEmpty) {
      return;
    }
    emitter(
      state.copyWith(
        submitStatus: LoadingStatus.loading,
        pageStatus: EAddTransactions.init,
      ),
    );
    try {
      String accessToken = await SharedPreferencesManager.getAccessToken();
      await PaymentApiProvider(accessToken: accessToken)
          .insertTransactions(state.tempTransactions);
      emitter(
        state.copyWith(
          submitStatus: LoadingStatus.loaded,
          pageStatus: EAddTransactions.submitSuccess,
        ),
      );
    } catch (err) {
      emitter(
        state.copyWith(
          submitStatus: LoadingStatus.error,
          submitErrMsg: '$err',
          pageStatus: EAddTransactions.submitError,
        ),
      );
    }
  }
}

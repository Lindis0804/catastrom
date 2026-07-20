import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/api/payment/provider.dart';
import 'package:template/common/enums/loading_status.enum.dart';
import 'package:template/common/enums/sort_order.enum.dart';
import 'package:template/common/utils/share_preferences.dart';
import 'package:template/data/models/payment/spending_by_category_summary.model.dart';

part 'spending_by_category.event.dart';
part 'spending_by_category.state.dart';

class SpendingByCategoryBloc
    extends Bloc<SpendingByCategoryEvent, SpendingByCategoryState> {
  final DateTime dateFrom;
  final DateTime dateTo;

  SpendingByCategoryBloc({required this.dateFrom, required this.dateTo})
      : super(const SpendingByCategoryState()) {
    on<Inititalize>(_onInitialize);
    on<RefreshEvent>(_onRefresh);
    on<ChangeOrderEvent>(_onChangeOrder);

    add(const Inititalize());
  }

  Future<void> _fetchSummary(Emitter<SpendingByCategoryState> emitter) async {
    emitter(state.copyWith(status: LoadingStatus.loading));
    try {
      String accessToken = await SharedPreferencesManager.getAccessToken();
      SpendingByCategorySummary summary =
          await PaymentApiProvider(accessToken: accessToken).getTotalByCategory(
        dateFrom: dateFrom,
        dateTo: dateTo,
        orderValue: state.orderValue.apiValue,
      );
      emitter(
        state.copyWith(summary: summary, status: LoadingStatus.loaded),
      );
    } catch (err) {
      emitter(
        state.copyWith(
          status: LoadingStatus.error,
          errMsg: 'Get total by category fail: $err',
        ),
      );
    }
  }

  void _onInitialize(
    SpendingByCategoryEvent event,
    Emitter<SpendingByCategoryState> emitter,
  ) async {
    await _fetchSummary(emitter);
  }

  void _onRefresh(
    SpendingByCategoryEvent event,
    Emitter<SpendingByCategoryState> emitter,
  ) async {
    await _fetchSummary(emitter);
  }

  void _onChangeOrder(
    ChangeOrderEvent event,
    Emitter<SpendingByCategoryState> emitter,
  ) async {
    emitter(state.copyWith(orderValue: event.order));
    await _fetchSummary(emitter);
  }
}

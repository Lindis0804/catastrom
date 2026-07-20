part of 'spending_by_category.bloc.dart';

class SpendingByCategoryState extends Equatable {
  final LoadingStatus status;
  final SpendingByCategorySummary? summary;
  final ESortOrder orderValue;
  final String? errMsg;

  const SpendingByCategoryState({
    this.status = LoadingStatus.initialize,
    this.summary,
    this.orderValue = ESortOrder.desc,
    this.errMsg,
  });

  SpendingByCategoryState copyWith({
    LoadingStatus? status,
    SpendingByCategorySummary? summary,
    ESortOrder? orderValue,
    String? errMsg,
  }) {
    return SpendingByCategoryState(
      status: status ?? this.status,
      summary: summary ?? this.summary,
      orderValue: orderValue ?? this.orderValue,
      errMsg: errMsg ?? this.errMsg,
    );
  }

  @override
  List<Object?> get props => [status, summary, orderValue, errMsg];
}

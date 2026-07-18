import 'package:template/data/models/payment/amount_by_category.model.dart';

class SpendingByCategorySummary {
  final num totalAmount;
  final List<AmountByCategory> amountByCategory;

  const SpendingByCategorySummary({
    required this.totalAmount,
    required this.amountByCategory,
  });

  factory SpendingByCategorySummary.fromDynamic(dynamic rawSummary) {
    return SpendingByCategorySummary(
      totalAmount: rawSummary['totalAmount'] ?? 0,
      amountByCategory: ((rawSummary['amountByCategory'] as List<dynamic>?) ?? [])
          .map((raw) => AmountByCategory.fromDynamic(raw))
          .toList(),
    );
  }
}

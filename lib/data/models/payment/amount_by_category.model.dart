class AmountByCategory {
  final int cId;
  final String cCode;
  final String cDescription;
  final num totalAmount;

  const AmountByCategory({
    required this.cId,
    required this.cCode,
    required this.cDescription,
    required this.totalAmount,
  });

  factory AmountByCategory.fromDynamic(dynamic rawAmountByCategory) {
    return AmountByCategory(
      cId: rawAmountByCategory['c_id'] ?? 0,
      cCode: rawAmountByCategory['c_code'] ?? '',
      cDescription: rawAmountByCategory['c_description'] ?? '',
      totalAmount: rawAmountByCategory['total_amount'] ?? 0,
    );
  }
}

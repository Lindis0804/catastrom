class TotalByDate {
  final num totalAmount;
  final String transDate;

  const TotalByDate({
    required this.totalAmount,
    required this.transDate,
  });

  factory TotalByDate.fromDynamic(dynamic rawTotalByDate) {
    return TotalByDate(
      totalAmount: rawTotalByDate['totalAmount'] ?? 0,
      transDate: rawTotalByDate['transDate'] ?? '',
    );
  }
}

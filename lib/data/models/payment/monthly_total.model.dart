class MonthlyTotal {
  final String month;
  final num total;

  const MonthlyTotal({
    required this.month,
    required this.total,
  });

  factory MonthlyTotal.fromDynamic(dynamic rawMonthlyTotal) {
    return MonthlyTotal(
      month: rawMonthlyTotal['month'] ?? '',
      total: rawMonthlyTotal['total'] ?? 0,
    );
  }
}

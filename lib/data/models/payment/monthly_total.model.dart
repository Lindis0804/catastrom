class MonthlyTotal {
  final String month;
  final num total;
  final String dateFrom;
  final String dateTo;

  const MonthlyTotal({
    required this.month,
    required this.total,
    required this.dateFrom,
    required this.dateTo,
  });

  factory MonthlyTotal.fromDynamic(dynamic rawMonthlyTotal) {
    return MonthlyTotal(
      month: rawMonthlyTotal['month'] ?? '',
      total: rawMonthlyTotal['total'] ?? 0,
      dateFrom: rawMonthlyTotal['date_from'] ?? '',
      dateTo: rawMonthlyTotal['date_to'] ?? '',
    );
  }
}

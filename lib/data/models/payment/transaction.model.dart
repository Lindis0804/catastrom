import 'package:intl/intl.dart';

class Transaction {
  final int? id;
  final String description;
  final num transAmount;
  final DateTime transDate;
  final List<int>? categoryList;
  final List<String> categories;

  const Transaction({
    this.id,
    required this.description,
    required this.transAmount,
    required this.transDate,
    this.categoryList,
    this.categories = const [],
  });

  factory Transaction.fromDynamic(dynamic rawTransaction) {
    return Transaction(
      id: rawTransaction['id'],
      description: rawTransaction['description'] ?? '',
      transAmount: rawTransaction['transAmount'] ?? 0,
      transDate: DateTime.parse(rawTransaction['transDate']),
      categories: ((rawTransaction['categories'] as List<dynamic>?) ?? [])
          .map((rawCategory) => rawCategory.toString())
          .toList(),
    );
  }

  Map<String, dynamic> toInsertJson() {
    return {
      'description': description,
      'transAmount': transAmount,
      'transDate': DateFormat('dd/MM/yyyy').format(transDate),
      'categoryList': categoryList ?? [],
    };
  }
}

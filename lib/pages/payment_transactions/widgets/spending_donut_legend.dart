import 'package:flutter/material.dart';
import 'package:template/data/models/payment/amount_by_category.model.dart';
import 'package:template/pages/payment_transactions/widgets/category_color.dart';

class SpendingDonutLegend extends StatelessWidget {
  final List<AmountByCategory> items;

  const SpendingDonutLegend({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    num total = items.fold<num>(0, (sum, item) => sum + item.totalAmount);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: items.map((item) {
        String percentage =
            total <= 0 ? '0.00' : (item.totalAmount / total * 100).toStringAsFixed(2);
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: categoryColor(item.cDescription),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  item.cDescription,
                  style: const TextStyle(fontSize: 13),
                ),
              ),
              const SizedBox(width: 2),
              Text(
                '$percentage%',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

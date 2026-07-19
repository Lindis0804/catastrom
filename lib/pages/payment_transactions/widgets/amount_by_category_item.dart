import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:template/common/constants/colors.dart';
import 'package:template/data/models/payment/amount_by_category.model.dart';
import 'package:template/pages/payment_transactions/widgets/category_color.dart';

class AmountByCategoryItem extends StatelessWidget {
  final AmountByCategory item;

  const AmountByCategoryItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    Color color = categoryColor(item.cDescription);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              item.cDescription,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            NumberFormat.decimalPattern('vi').format(item.totalAmount),
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: CustomColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}

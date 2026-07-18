import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:template/common/constants/colors.dart';
import 'package:template/data/models/payment/amount_by_category.model.dart';

class AmountByCategoryItem extends StatelessWidget {
  final AmountByCategory item;

  const AmountByCategoryItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: CustomColors.border),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
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

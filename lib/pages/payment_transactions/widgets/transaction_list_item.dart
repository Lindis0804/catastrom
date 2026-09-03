import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:template/common/constants/colors.dart';
import 'package:template/data/models/payment/transaction.model.dart';
import 'package:template/pages/payment_transactions/widgets/category_color.dart';

class TransactionListItem extends StatelessWidget {
  final Transaction transaction;

  const TransactionListItem({
    super.key,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: CustomColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  transaction.description,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                NumberFormat.decimalPattern('vi')
                    .format(transaction.transAmount),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: CustomColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Text(
                  DateFormat('dd/MM/yyyy').format(transaction.transDate),
                  style: const TextStyle(
                    fontSize: 12,
                    color: CustomColors.textLabel,
                  ),
                ),
              ),
              if (transaction.categories.isNotEmpty) ...[
                const SizedBox(width: 6),
                Flexible(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Wrap(
                      alignment: WrapAlignment.end,
                      spacing: 6,
                      runSpacing: 6,
                      children: transaction.categories.map((name) {
                        final color = categoryColor(name);

                        return Chip(
                          label: Text(
                            name,
                            style: TextStyle(
                              fontSize: 11,
                              color: color,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          backgroundColor: color.withValues(alpha: 0.12),
                          side: BorderSide(color: color),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          visualDensity: VisualDensity.compact,
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ],
          )
        ],
      ),
    );
  }
}

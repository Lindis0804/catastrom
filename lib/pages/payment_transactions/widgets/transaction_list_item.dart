import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:template/common/constants/colors.dart';
import 'package:template/data/models/payment/transaction.model.dart';
import 'package:template/pages/payment_transactions/widgets/category_color.dart';

class TransactionListItem extends StatelessWidget {
  final Transaction transaction;
  final VoidCallback? onDelete;

  const TransactionListItem({
    super.key,
    required this.transaction,
    this.onDelete,
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
              if (onDelete != null) ...[
                const SizedBox(width: 4),
                IconButton(
                  icon: const Icon(Icons.delete_outline, size: 20),
                  color: CustomColors.error,
                  onPressed: onDelete,
                ),
              ],
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
              if (transaction.categories.isNotEmpty)
                Container(
                  color: Colors.transparent,
                  child: Flexible(
                    // Container padding is 12 on the right; shift by 7px so
                    // the chip list itself sits only 5px from the card's edge.
                    child: Transform.translate(
                      offset: const Offset(7, 0),
                      child: Wrap(
                        alignment: WrapAlignment.end,
                        spacing: 6,
                        runSpacing: 6,
                        children: transaction.categories.map((name) {
                          Color color = categoryColor(name);
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
                )
            ],
          ),
        ],
      ),
    );
  }
}

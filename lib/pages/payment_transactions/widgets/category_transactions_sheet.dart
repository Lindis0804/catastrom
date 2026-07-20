import 'package:flutter/material.dart';
import 'package:template/common/constants/colors.dart';
import 'package:template/data/models/payment/amount_by_category.model.dart';
import 'package:template/data/models/payment/category.model.dart';
import 'package:template/pages/payment_transactions/screen/payment_transactions.screen.dart';

void showCategoryTransactionsSheet(
  BuildContext context, {
  required AmountByCategory category,
  required DateTime dateFrom,
  required DateTime dateTo,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Chi tiết giao dịch',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    category.cDescription,
                    style: const TextStyle(
                      fontSize: 14,
                      color: CustomColors.textLabel,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: PaymentTransactionsScreen(
                initialDateFrom: dateFrom,
                initialDateTo: dateTo,
                initialCategories: [
                  Category(
                    id: category.cId,
                    code: category.cCode,
                    description: category.cDescription,
                  ),
                ],
                lockDateRange: true,
                showFilterBar: false,
                embedded: true,
                pageSize: 5,
              ),
            ),
          ],
        ),
      );
    },
  );
}

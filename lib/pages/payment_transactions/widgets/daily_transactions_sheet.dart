import 'package:flutter/material.dart';
import 'package:template/pages/payment_transactions/screen/payment_transactions.screen.dart';

void showDailyTransactionsSheet(
  BuildContext context, {
  required DateTime date,
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
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Text(
                'Chi tiết giao dịch',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            Expanded(
              child: PaymentTransactionsScreen(
                initialDateFrom: date,
                initialDateTo: date,
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

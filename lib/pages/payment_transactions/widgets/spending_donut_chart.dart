import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:template/data/models/payment/amount_by_category.model.dart';
import 'package:template/pages/payment_transactions/widgets/category_color.dart';

class SpendingDonutChart extends StatelessWidget {
  final List<AmountByCategory> items;

  const SpendingDonutChart({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 160,
        height: 160,
        child: CustomPaint(
          painter: _DonutChartPainter(items: items),
        ),
      ),
    );
  }
}

class _DonutChartPainter extends CustomPainter {
  final List<AmountByCategory> items;

  _DonutChartPainter({required this.items});

  static const double _strokeWidth = 28;
  static const double _gapDegrees = 3;

  @override
  void paint(Canvas canvas, Size size) {
    num total = items.fold<num>(0, (sum, item) => sum + item.totalAmount);
    if (total <= 0 || items.isEmpty) return;

    Rect rect = (Offset.zero & size).deflate(_strokeWidth / 2);
    double gap = _gapDegrees * math.pi / 180;
    double startAngle = -math.pi / 2;

    for (final item in items) {
      double sweepAngle = (item.totalAmount / total) * 2 * math.pi;
      double drawSweep = (sweepAngle - gap).clamp(0, sweepAngle);

      Paint paint = Paint()
        ..color = categoryColor(item.cDescription)
        ..style = PaintingStyle.stroke
        ..strokeWidth = _strokeWidth
        ..strokeCap = StrokeCap.butt;

      canvas.drawArc(rect, startAngle + gap / 2, drawSweep, false, paint);
      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant _DonutChartPainter oldDelegate) {
    return oldDelegate.items != items;
  }
}

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:template/common/constants/colors.dart';
import 'package:template/data/models/payment/total_by_date.model.dart';
import 'package:template/pages/payment_transactions/widgets/daily_transactions_sheet.dart';

class DailyTotalsBarChart extends StatelessWidget {
  const DailyTotalsBarChart({
    super.key,
    required this.items,
    required this.isLoading,
  });

  final List<TotalByDate> items;
  final bool isLoading;

  static const double _chartHeight = 220;
  static const num _yAxisStep = 50;
  static const num _yAxisHeadroom = 50;
  static const double _groupsSpace = 2;
  static const Color _foreground = Color(0xFF0B4A28);
  static final NumberFormat _compactFormat = NumberFormat.compact(locale: 'vi');

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 12),
      decoration: BoxDecoration(
        color: CustomColors.primary.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: CustomColors.primary),
      ),
      child: items.isEmpty
          ? SizedBox(
              height: _chartHeight,
              child: isLoading
                  ? const Center(
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: _foreground,
                        ),
                      ),
                    )
                  : null,
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 4, bottom: 8),
                  child: Text(
                    'Số tiền (k VND)',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: _foreground,
                    ),
                  ),
                ),
                SizedBox(
                  height: _chartHeight,
                  child: BarChart(_buildChartData(context)),
                ),
              ],
            ),
    );
  }

  BarChartData _buildChartData(BuildContext context) {
    final num maxAmount = items
        .map((item) => item.totalAmount.abs())
        .fold<num>(0, (a, b) => a > b ? a : b);
    final double axisMax = (maxAmount + _yAxisHeadroom).toDouble();

    return BarChartData(
      minY: 0,
      maxY: axisMax,
      groupsSpace: _groupsSpace,
      alignment: BarChartAlignment.spaceAround,
      barTouchData: BarTouchData(
        enabled: true,
        touchCallback: (FlTouchEvent event, BarTouchResponse? response) {
          if (event is! FlTapUpEvent) {
            return;
          }
          final int? idx = response?.spot?.touchedBarGroupIndex;
          if (idx == null || idx < 0 || idx >= items.length) {
            return;
          }
          final DateTime date =
              DateFormat('dd/MM/yyyy').parse(items[idx].transDate);
          showDailyTransactionsSheet(context, date: date);
        },
        touchTooltipData: BarTouchTooltipData(
          getTooltipColor: (_) => Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 4,
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            return BarTooltipItem(
              _compactFormat.format(rod.toY),
              const TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w600,
                color: _foreground,
              ),
            );
          },
        ),
      ),
      gridData: const FlGridData(show: false),
      borderData: FlBorderData(show: false),
      titlesData: FlTitlesData(
        show: true,
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 40,
            interval: _yAxisStep.toDouble(),
            getTitlesWidget: (value, meta) => Padding(
              padding: const EdgeInsets.only(right: 4),
              child: Text(
                _compactFormat.format(value),
                style: const TextStyle(fontSize: 10, color: _foreground),
              ),
            ),
          ),
        ),
        bottomTitles: AxisTitles(
          axisNameWidget: const Padding(
            padding: EdgeInsets.only(top: 4),
            child: Text(
              'Ngày',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: _foreground,
              ),
            ),
          ),
          axisNameSize: 20,
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 24,
            getTitlesWidget: (value, meta) {
              final int idx = value.toInt();
              if (idx < 0 || idx >= items.length) {
                return const SizedBox.shrink();
              }
              final String transDate = items[idx].transDate;
              final String dayLabel =
                  transDate.length >= 5 ? transDate.substring(0, 5) : transDate;
              return Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text(
                  dayLabel,
                  style: const TextStyle(fontSize: 10, color: _foreground),
                ),
              );
            },
          ),
        ),
      ),
      barGroups: List.generate(items.length, (idx) {
        final double value = items[idx].totalAmount.abs().toDouble();
        return BarChartGroupData(
          x: idx,
          showingTooltipIndicators: const [0],
          barRods: [
            BarChartRodData(
              toY: value,
              color: CustomColors.primary,
              width: 32,
              borderRadius: BorderRadius.circular(4),
            ),
          ],
        );
      }),
    );
  }
}

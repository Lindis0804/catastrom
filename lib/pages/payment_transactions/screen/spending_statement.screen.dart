import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:template/common/constants/colors.dart';
import 'package:template/common/enums/loading_status.enum.dart';
import 'package:template/common/enums/sort_order.enum.dart';
import 'package:template/common/widgets/custom_empty_list.dart';
import 'package:template/common/widgets/custom_list_separator.dart';
import 'package:template/common/widgets/custom_tab_bar.dart';
import 'package:template/common/widgets/error_dialog_utils.dart';
import 'package:template/data/models/payment/monthly_total.model.dart';
import 'package:template/pages/payment_transactions/bloc/spending_by_category.bloc.dart';
import 'package:template/pages/payment_transactions/screen/payment_transactions.screen.dart';
import 'package:template/pages/payment_transactions/widgets/amount_by_category_item.dart';
import 'package:template/pages/payment_transactions/widgets/category_transactions_sheet.dart';
import 'package:template/pages/payment_transactions/widgets/spending_donut_chart.dart';
import 'package:template/pages/payment_transactions/widgets/spending_donut_legend.dart';

class SpendingStatementScreen extends StatefulWidget {
  const SpendingStatementScreen({super.key, required this.monthlyTotal});

  final MonthlyTotal monthlyTotal;

  @override
  State<SpendingStatementScreen> createState() =>
      _SpendingStatementScreenState();
}

class _SpendingStatementScreenState extends State<SpendingStatementScreen> {
  int _selectedTabIndex = 0;
  final List<String> _tabs = const ['Sơ đồ tổng quan', 'Chi tiết giao dịch'];

  late final DateTime _dateFrom;
  late final DateTime _dateTo;

  @override
  void initState() {
    super.initState();
    _dateFrom = DateFormat('dd/MM/yyyy').parse(widget.monthlyTotal.dateFrom);
    _dateTo = DateFormat('dd/MM/yyyy').parse(widget.monthlyTotal.dateTo);
  }

  void _onTabSelected(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text.rich(
          TextSpan(
            children: [
              const TextSpan(text: 'Sao kê chi tiêu '),
              TextSpan(
                text: widget.monthlyTotal.month,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: CustomColors.primary,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: CustomTabBar(
              tabs: _tabs,
              selectedIndex: _selectedTabIndex,
              onTabSelected: _onTabSelected,
              activeColor: CustomColors.primary,
            ),
          ),
          Expanded(
            child: IndexedStack(
              index: _selectedTabIndex,
              children: [
                _SpendingByCategoryTab(dateFrom: _dateFrom, dateTo: _dateTo),
                PaymentTransactionsScreen(
                  initialDateFrom: _dateFrom,
                  initialDateTo: _dateTo,
                  lockDateRange: true,
                  embedded: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SpendingByCategoryTab extends StatelessWidget {
  const _SpendingByCategoryTab({required this.dateFrom, required this.dateTo});

  final DateTime dateFrom;
  final DateTime dateTo;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SpendingByCategoryBloc>(
      create: (_) => SpendingByCategoryBloc(dateFrom: dateFrom, dateTo: dateTo),
      child: BlocListener<SpendingByCategoryBloc, SpendingByCategoryState>(
        listenWhen: (previous, current) =>
            previous.status != current.status &&
            current.status == LoadingStatus.error,
        listener: (context, state) => ErrorDialogUtils.showErrorToast(
          context: context,
          message: state.errMsg,
        ),
        child: Builder(
          builder: (context) => _SpendingByCategoryBody(
            bloc: context.read<SpendingByCategoryBloc>(),
          ),
        ),
      ),
    );
  }
}

class _SpendingByCategoryBody extends StatelessWidget {
  const _SpendingByCategoryBody({required this.bloc});

  final SpendingByCategoryBloc bloc;

  Future<void> _onRefresh() {
    bloc.add(const RefreshEvent());
    return bloc.stream.firstWhere((state) => state.status.isCompleted);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SpendingByCategoryBloc, SpendingByCategoryState>(
      bloc: bloc,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: CustomColors.primary.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: CustomColors.primary),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Tổng số tiền (k VND)',
                      style: TextStyle(
                        fontSize: 13,
                        color: CustomColors.textLabel,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      NumberFormat.decimalPattern('vi')
                          .format(state.summary?.totalAmount ?? 0),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: CustomColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
              if (state.summary != null &&
                  state.summary!.amountByCategory.isNotEmpty) ...[
                const SizedBox(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: SpendingDonutChart(
                        items: state.summary!.amountByCategory,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: SpendingDonutLegend(
                        items: state.summary!.amountByCategory,
                      ),
                    ),
                  ],
                ),
              ],
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: PopupMenuButton<ESortOrder>(
                  position: PopupMenuPosition.under,
                  onSelected: (order) {
                    bloc.add(ChangeOrderEvent(order: order));
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: ESortOrder.asc,
                      child: Text(
                        ESortOrder.asc.label,
                        style: const TextStyle(color: CustomColors.primary),
                      ),
                    ),
                    PopupMenuItem(
                      value: ESortOrder.desc,
                      child: Text(
                        ESortOrder.desc.label,
                        style: const TextStyle(color: CustomColors.primary),
                      ),
                    ),
                  ],
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.sort_rounded, size: 18),
                        const SizedBox(width: 4),
                        Text('Sắp xếp: ${state.orderValue.label}'),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: state.status.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : RefreshIndicator(
                        onRefresh: _onRefresh,
                        child: (state.summary == null ||
                                state.summary!.amountByCategory.isEmpty)
                            ? ListView(
                                physics: const AlwaysScrollableScrollPhysics(),
                                children: const [
                                  CustomEmptyList(
                                    icon: Icons.pie_chart_outline,
                                    title: 'Không có dữ liệu',
                                  ),
                                ],
                              )
                            : ListView.separated(
                                physics: const AlwaysScrollableScrollPhysics(),
                                itemBuilder: (context, idx) {
                                  final category =
                                      state.summary!.amountByCategory[idx];
                                  return Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(8),
                                      onTap: () {
                                        showCategoryTransactionsSheet(
                                          context,
                                          category: category,
                                          dateFrom: bloc.dateFrom,
                                          dateTo: bloc.dateTo,
                                        );
                                      },
                                      child: AmountByCategoryItem(
                                        item: category,
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: (context, idx) =>
                                    const CustomListSeparator(),
                                itemCount:
                                    state.summary!.amountByCategory.length,
                              ),
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:template/common/constants/colors.dart';
import 'package:template/common/enums/loading_status.enum.dart';
import 'package:template/common/enums/payment_transactions.enum.dart';
import 'package:template/common/widgets/custom_date_picker.dart';
import 'package:template/common/widgets/custom_empty_list.dart';
import 'package:template/common/widgets/error_dialog_utils.dart';
import 'package:template/common/widgets/top_notification.dart';
import 'package:template/data/models/payment/category.model.dart';
import 'package:template/data/models/payment/transaction.model.dart';
import 'package:template/pages/payment_transactions/bloc/payment_transactions.bloc.dart';
import 'package:template/pages/payment_transactions/widgets/category_search_picker.dart';
import 'package:template/pages/payment_transactions/widgets/transaction_list_item.dart';
import 'package:template/root/app_routers.dart';

// Flattens a transDate-sorted list into date-header + transaction rows for
// ListView.builder (transactions are already sorted DESC by transDate, so
// this only needs to detect when the date changes, not resort anything).
List<Object> _groupTransactionsByDate(List<Transaction> transactions) {
  List<Object> rows = [];
  DateTime? lastDate;
  for (final transaction in transactions) {
    DateTime dateOnly = DateTime(
      transaction.transDate.year,
      transaction.transDate.month,
      transaction.transDate.day,
    );
    if (lastDate == null || dateOnly != lastDate) {
      rows.add(dateOnly);
      lastDate = dateOnly;
    }
    rows.add(transaction);
  }
  return rows;
}

class PaymentTransactions extends StatefulWidget {
  const PaymentTransactions({
    super.key,
    required this.bloc,
    this.lockDateRange = false,
    this.embedded = false,
    this.showFilterBar = true,
  });
  final PaymentTransactionsBloc bloc;
  final bool lockDateRange;
  final bool embedded;
  final bool showFilterBar;

  @override
  State<PaymentTransactions> createState() => _PaymentTransactionsState();
}

class _PaymentTransactionsState extends State<PaymentTransactions> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentTransactionsBloc, PaymentTransactionsState>(
      bloc: widget.bloc,
      builder: (context, state) {
        if (widget.embedded) {
          return _buildBody(state);
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text('Quản lý thu chi'),
            actions: [
              IconButton(
                icon: const Icon(Icons.add_rounded),
                tooltip: 'Add transaction',
                onPressed: () {
                  widget.bloc.add(const ToAddTransactionsEvent());
                },
              ),
            ],
          ),
          body: _buildBody(state),
        );
      },
    );
  }

  Widget _buildBody(PaymentTransactionsState state) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          if (widget.showFilterBar) ...[
            Row(
              children: [
                TextButton.icon(
                  onPressed: () {
                    widget.bloc.add(const ToggleFilterEvent());
                  },
                  icon: const Icon(Icons.filter_list_rounded),
                  label: const Text('Filter'),
                ),
                if (widget.embedded) ...[
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.add_rounded),
                    tooltip: 'Add transaction',
                    onPressed: () {
                      widget.bloc.add(const ToAddTransactionsEvent());
                    },
                  ),
                ],
              ],
            ),
            if (state.isFilterExpanded) ...[
              CategorySearchPicker(
                selectedCategories: state.selectedFilterCategories,
                onChanged: (categories) {
                  widget.bloc.add(
                    FilterChanged(
                      categories: categories,
                      dateFrom: state.dateFrom,
                      dateTo: state.dateTo,
                    ),
                  );
                },
              ),
              if (!widget.lockDateRange) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: CustomDatePicker(
                        label: 'Từ ngày',
                        placeholder: 'Từ ngày',
                        dateFormat: 'dd/MM/yyyy',
                        initialDate: state.dateFrom,
                        onDateChanged: (date) {
                          widget.bloc.add(
                            FilterChanged(
                              categories: state.selectedFilterCategories,
                              dateFrom: date,
                              dateTo: state.dateTo,
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: CustomDatePicker(
                        label: 'Đến ngày',
                        placeholder: 'Đến ngày',
                        dateFormat: 'dd/MM/yyyy',
                        initialDate: state.dateTo,
                        onDateChanged: (date) {
                          widget.bloc.add(
                            FilterChanged(
                              categories: state.selectedFilterCategories,
                              dateFrom: state.dateFrom,
                              dateTo: date,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ],
          const SizedBox(height: 8),
          Expanded(
            child: state.getTransactionsStatus.isLoading
                ? const Center(child: CircularProgressIndicator())
                : RefreshIndicator(
                    onRefresh: () => _onRefresh(widget.bloc),
                    child: _buildTransactionsList(state),
                  ),
          ),
          if (!state.getTransactionsStatus.isLoading &&
              state.transactions != null &&
              (state.pageIdx > 0 || state.hasMoreTransactions))
            _PaginationControls(bloc: widget.bloc, state: state),
        ],
      ),
    );
  }

  Widget _buildTransactionsList(PaymentTransactionsState state) {
    if (state.transactions == null || state.transactions!.isEmpty) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: const [
          CustomEmptyList(
            icon: Icons.receipt_long_outlined,
            title: 'Không có giao dịch nào',
          ),
        ],
      );
    }

    List<Object> rows = _groupTransactionsByDate(state.transactions!);
    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: rows.length,
      itemBuilder: (context, idx) {
        final row = rows[idx];
        if (row is DateTime) {
          return Padding(
            padding: EdgeInsets.only(top: idx == 0 ? 0 : 12, bottom: 6),
            child: Text(
              DateFormat('dd/MM/yyyy').format(row),
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: CustomColors.textLabel,
              ),
            ),
          );
        }
        final transaction = row as Transaction;
        return Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Slidable(
            endActionPane: ActionPane(
              motion: const StretchMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) => _confirmDeleteTransaction(
                    context,
                    widget.bloc,
                    transaction.id!,
                  ),
                  backgroundColor: CustomColors.error,
                  icon: Icons.delete_rounded,
                  label: 'Xoá',
                ),
              ],
            ),
            child: TransactionListItem(transaction: transaction),
          ),
        );
      },
    );
  }
}

class _PaginationControls extends StatelessWidget {
  const _PaginationControls({required this.bloc, required this.state});

  final PaymentTransactionsBloc bloc;
  final PaymentTransactionsState state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: state.pageIdx > 0
                ? () => bloc.add(ChangePageEvent(pageIdx: state.pageIdx - 1))
                : null,
          ),
          Text(
            'Trang ${state.pageIdx + 1}',
            style: const TextStyle(fontSize: 13, color: CustomColors.textLabel),
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: state.hasMoreTransactions
                ? () => bloc.add(ChangePageEvent(pageIdx: state.pageIdx + 1))
                : null,
          ),
        ],
      ),
    );
  }
}

void _confirmDeleteTransaction(
  BuildContext context,
  PaymentTransactionsBloc bloc,
  int id,
) {
  showDialog(
    context: context,
    builder: (dialogContext) => AlertDialog(
      content: const Text('Bạn có chắc muốn xoá giao dịch này không'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(dialogContext).pop();
            bloc.add(DeleteTransactionEvent(id: id));
          },
          child: const Text('OK'),
        ),
      ],
    ),
  );
}

Future<void> _onRefresh(PaymentTransactionsBloc bloc) {
  bloc.add(const LoadTransactions());
  return bloc.stream.firstWhere(
    (state) => state.getTransactionsStatus.isCompleted,
  );
}

void _navigationListener(
    BuildContext context, PaymentTransactionsState state) async {
  switch (state.pageStatus) {
    case EPaymentTransactions.toAddTransactions:
      await Navigator.of(context).pushNamed(AppRouters.addTransactions);
      if (!context.mounted) {
        return;
      }
      context.read<PaymentTransactionsBloc>().add(
            const BackFromAddTransactionsEvent(),
          );
      break;
    default:
  }
}

class PaymentTransactionsScreen extends StatelessWidget {
  const PaymentTransactionsScreen({
    super.key,
    this.initialDateFrom,
    this.initialDateTo,
    this.initialCategories,
    this.lockDateRange = false,
    this.embedded = false,
    this.showFilterBar = true,
    this.pageSize = 6,
  });

  final DateTime? initialDateFrom;
  final DateTime? initialDateTo;
  final List<Category>? initialCategories;
  final bool lockDateRange;
  final bool embedded;
  final bool showFilterBar;
  final int pageSize;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PaymentTransactionsBloc>(
      create: (_) => PaymentTransactionsBloc(
        initialDateFrom: initialDateFrom,
        initialDateTo: initialDateTo,
        initialCategories: initialCategories,
        pageSize: pageSize,
      ),
      child: MultiBlocListener(
        listeners: [
          BlocListener<PaymentTransactionsBloc, PaymentTransactionsState>(
            listenWhen: (previous, current) =>
                previous.pageStatus != current.pageStatus,
            listener: _navigationListener,
          ),
          BlocListener<PaymentTransactionsBloc, PaymentTransactionsState>(
            listenWhen: (previous, current) =>
                previous.getTransactionsStatus !=
                    current.getTransactionsStatus &&
                current.getTransactionsStatus == LoadingStatus.error,
            listener: (context, state) => ErrorDialogUtils.showErrorToast(
              context: context,
              message: state.getTransactionsErrMsg,
            ),
          ),
          BlocListener<PaymentTransactionsBloc, PaymentTransactionsState>(
            listenWhen: (previous, current) =>
                previous.getCategoriesStatus != current.getCategoriesStatus &&
                current.getCategoriesStatus == LoadingStatus.error,
            listener: (context, state) => ErrorDialogUtils.showErrorToast(
              context: context,
              message: state.getCategoriesErrMsg,
            ),
          ),
          BlocListener<PaymentTransactionsBloc, PaymentTransactionsState>(
            listenWhen: (previous, current) =>
                previous.deleteTransactionStatus !=
                    current.deleteTransactionStatus &&
                current.deleteTransactionStatus.isCompleted,
            listener: (context, state) {
              if (state.deleteTransactionStatus == LoadingStatus.loaded) {
                TopNotification.show(
                  context: context,
                  message: 'Xoá bản ghi thành công',
                  isSuccess: true,
                );
              } else {
                TopNotification.show(
                  context: context,
                  message: 'Xoá bản ghi thất bại',
                  isSuccess: false,
                );
              }
            },
          ),
        ],
        child: Builder(
          builder: (BuildContext context) => PaymentTransactions(
            bloc: context.read<PaymentTransactionsBloc>(),
            lockDateRange: lockDateRange,
            embedded: embedded,
            showFilterBar: showFilterBar,
          ),
        ),
      ),
    );
  }
}

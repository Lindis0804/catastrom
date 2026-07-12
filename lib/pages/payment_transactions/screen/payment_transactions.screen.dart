import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:template/common/constants/colors.dart';
import 'package:template/common/enums/loading_status.enum.dart';
import 'package:template/common/enums/payment_transactions.enum.dart';
import 'package:template/common/widgets/custom_date_picker.dart';
import 'package:template/common/widgets/custom_empty_list.dart';
import 'package:template/common/widgets/custom_list_separator.dart';
import 'package:template/common/widgets/error_dialog_utils.dart';
import 'package:template/common/widgets/top_notification.dart';
import 'package:template/pages/payment_transactions/bloc/payment_transactions.bloc.dart';
import 'package:template/pages/payment_transactions/widgets/category_search_picker.dart';
import 'package:template/pages/payment_transactions/widgets/transaction_list_item.dart';
import 'package:template/root/app_routers.dart';

class PaymentTransactions extends StatefulWidget {
  const PaymentTransactions({super.key, required this.bloc});
  final PaymentTransactionsBloc bloc;

  @override
  State<PaymentTransactions> createState() => _PaymentTransactionsState();
}

class _PaymentTransactionsState extends State<PaymentTransactions> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentTransactionsBloc, PaymentTransactionsState>(
      bloc: widget.bloc,
      builder: (context, state) {
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
          body: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Row(
                  children: [
                    TextButton.icon(
                      onPressed: () {
                        widget.bloc.add(const ToggleFilterEvent());
                      },
                      icon: const Icon(Icons.filter_list_rounded),
                      label: const Text('Filter'),
                    ),
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
                const SizedBox(height: 8),
                Expanded(
                  child: state.getTransactionsStatus.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : RefreshIndicator(
                          onRefresh: () => _onRefresh(widget.bloc),
                          child: (state.transactions == null ||
                                  state.transactions!.isEmpty)
                              ? ListView(
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  children: const [
                                    CustomEmptyList(
                                      icon: Icons.receipt_long_outlined,
                                      title: 'Không có giao dịch nào',
                                    ),
                                  ],
                                )
                              : ListView.separated(
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  itemBuilder: (context, idx) {
                                    final transaction =
                                        state.transactions![idx];
                                    return Slidable(
                                      endActionPane: ActionPane(
                                        motion: const StretchMotion(),
                                        children: [
                                          SlidableAction(
                                            onPressed: (context) =>
                                                _confirmDeleteTransaction(
                                              context,
                                              widget.bloc,
                                              transaction.id!,
                                            ),
                                            backgroundColor:
                                                CustomColors.error,
                                            icon: Icons.delete_rounded,
                                            label: 'Xoá',
                                          ),
                                        ],
                                      ),
                                      child: TransactionListItem(
                                        transaction: transaction,
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, idx) =>
                                      const CustomListSeparator(),
                                  itemCount: state.transactions!.length,
                                ),
                        ),
                ),
              ],
            ),
          ),
        );
      },
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
  const PaymentTransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PaymentTransactionsBloc>(
      create: (_) => PaymentTransactionsBloc(),
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
          ),
        ),
      ),
    );
  }
}

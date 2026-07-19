import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:template/common/constants/colors.dart';
import 'package:template/common/enums/payment_transactions.enum.dart';
import 'package:template/common/widgets/custom_button.dart';
import 'package:template/common/widgets/custom_empty_list.dart';
import 'package:template/common/widgets/custom_list_separator.dart';
import 'package:template/common/widgets/error_dialog_utils.dart';
import 'package:template/pages/payment_transactions/bloc/add_transactions.bloc.dart';
import 'package:template/pages/payment_transactions/widgets/add_transaction_sheet.dart';
import 'package:template/pages/payment_transactions/widgets/transaction_list_item.dart';

class AddTransactions extends StatefulWidget {
  const AddTransactions({super.key, required this.bloc});
  final AddTransactionsBloc bloc;

  @override
  State<AddTransactions> createState() => _AddTransactionsState();
}

class _AddTransactionsState extends State<AddTransactions> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddTransactionsBloc, AddTransactionsState>(
      bloc: widget.bloc,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Add transactions'),
            actions: [
              IconButton(
                icon: const Icon(Icons.add_rounded),
                tooltip: 'Thêm giao dịch',
                onPressed: () {
                  showAddTransactionSheet(
                    context,
                    onSave: (transaction) {
                      widget.bloc.add(
                        AddTempTransactionEvent(transaction: transaction),
                      );
                    },
                  );
                },
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(12),
            child: state.tempTransactions.isEmpty
                ? const CustomEmptyList(
                    icon: Icons.receipt_long_outlined,
                    title: 'Chưa có giao dịch nào',
                    subtitle: 'Nhấn nút "+" để thêm giao dịch',
                  )
                : ListView.separated(
                    itemBuilder: (context, idx) {
                      final transaction = state.tempTransactions[idx];
                      return Slidable(
                        endActionPane: ActionPane(
                          motion: const StretchMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) {
                                showAddTransactionSheet(
                                  context,
                                  initialTransaction: transaction,
                                  onSave: (updated) {
                                    widget.bloc.add(
                                      EditTempTransactionEvent(
                                        index: idx,
                                        transaction: updated,
                                      ),
                                    );
                                  },
                                );
                              },
                              backgroundColor: CustomColors.primary,
                              icon: Icons.edit_rounded,
                              label: 'Sửa',
                            ),
                            SlidableAction(
                              onPressed: (context) {
                                widget.bloc.add(
                                  RemoveTempTransactionEvent(index: idx),
                                );
                              },
                              backgroundColor: CustomColors.error,
                              icon: Icons.delete_rounded,
                              label: 'Xoá',
                            ),
                          ],
                        ),
                        child: TransactionListItem(transaction: transaction),
                      );
                    },
                    separatorBuilder: (context, idx) =>
                        const CustomListSeparator(),
                    itemCount: state.tempTransactions.length,
                  ),
          ),
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: BigCustomButton(
                text: 'Submit',
                onPressed: state.tempTransactions.isEmpty ||
                        state.submitStatus.isLoading
                    ? null
                    : () {
                        widget.bloc.add(const SubmitTransactionsEvent());
                      },
              ),
            ),
          ),
        );
      },
    );
  }
}

void _listener(BuildContext context, AddTransactionsState state) {
  switch (state.pageStatus) {
    case EAddTransactions.submitSuccess:
      showDialog(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: const Text('Thành công'),
          content: const Text('Insert transaction successfully'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                Navigator.of(context).pop(true);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
      break;
    case EAddTransactions.submitError:
      ErrorDialogUtils.showErrorDialog(
        context: context,
        title: 'Insert transaction failed',
        errorMessage: state.submitErrMsg,
      );
      break;
    default:
  }
}

class AddTransactionsScreen extends StatelessWidget {
  const AddTransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddTransactionsBloc>(
      create: (_) => AddTransactionsBloc(),
      child: BlocListener<AddTransactionsBloc, AddTransactionsState>(
        listener: _listener,
        listenWhen: (previous, current) =>
            previous.pageStatus != current.pageStatus,
        child: Builder(
          builder: (BuildContext context) => AddTransactions(
            bloc: context.read<AddTransactionsBloc>(),
          ),
        ),
      ),
    );
  }
}

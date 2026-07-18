import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:template/common/constants/colors.dart';
import 'package:template/common/enums/loading_status.enum.dart';
import 'package:template/common/enums/sort_order.enum.dart';
import 'package:template/common/widgets/custom_date_picker.dart';
import 'package:template/common/widgets/custom_empty_list.dart';
import 'package:template/common/widgets/custom_list_separator.dart';
import 'package:template/common/widgets/error_dialog_utils.dart';

import 'package:template/pages/home/bloc/home.bloc.dart';

class Home extends StatefulWidget {
  final HomeBloc homeBloc;
  const Home({super.key, required this.homeBloc});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    widget.homeBloc.add(const Inititalize());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Trang chủ'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: CustomDatePicker(
                        label: 'Từ tháng',
                        placeholder: 'Từ tháng',
                        dateFormat: 'MM/yyyy',
                        initialDate: state.monthFrom,
                        onDateChanged: (date) {
                          widget.homeBloc.add(
                            ChangeMonthFilterEvent(
                              monthFrom: date,
                              monthTo: state.monthTo,
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: CustomDatePicker(
                        label: 'Đến tháng',
                        placeholder: 'Đến tháng',
                        dateFormat: 'MM/yyyy',
                        initialDate: state.monthTo,
                        onDateChanged: (date) {
                          widget.homeBloc.add(
                            ChangeMonthFilterEvent(
                              monthFrom: state.monthFrom,
                              monthTo: date,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: PopupMenuButton<ESortOrder>(
                    onSelected: (order) {
                      widget.homeBloc.add(ChangeSortOrderEvent(order: order));
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: ESortOrder.asc,
                        child: Text(ESortOrder.asc.label),
                      ),
                      PopupMenuItem(
                        value: ESortOrder.desc,
                        child: Text(ESortOrder.desc.label),
                      ),
                    ],
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.sort_rounded, size: 18),
                          const SizedBox(width: 4),
                          Text('Sắp xếp: ${state.sortOrder.label}'),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: state.getMonthlyTotalsStatus.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : (state.monthlyTotals == null ||
                              state.monthlyTotals!.isEmpty)
                          ? const CustomEmptyList(
                              icon: Icons.bar_chart_outlined,
                              title: 'Không có dữ liệu',
                            )
                          : ListView.separated(
                              itemBuilder: (context, idx) {
                                final item = state.monthlyTotals![idx];
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    border:
                                        Border.all(color: CustomColors.border),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        item.month,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        NumberFormat.decimalPattern('vi')
                                            .format(item.total),
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: CustomColors.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder: (context, idx) =>
                                  const CustomListSeparator(),
                              itemCount: state.monthlyTotals!.length,
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

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) => BlocProvider<HomeBloc>(
        create: (_) => HomeBloc(),
        child: BlocListener<HomeBloc, HomeState>(
          listenWhen: (previous, current) =>
              previous.getMonthlyTotalsStatus != current.getMonthlyTotalsStatus &&
              current.getMonthlyTotalsStatus == LoadingStatus.error,
          listener: (context, state) => ErrorDialogUtils.showErrorToast(
            context: context,
            message: state.getMonthlyTotalsErrMsg,
          ),
          child: Builder(
            builder: (BuildContext context) => Home(
              homeBloc: context.read<HomeBloc>(),
            ),
          ),
        ),
      );
}

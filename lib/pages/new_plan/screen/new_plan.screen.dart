import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:template/api/plan/dto/ReqCreateTrip.dart';
import 'package:template/api/plan/dto/getSection.dart';
import 'package:template/common/constants/page_title.dart';
import 'package:template/common/enums/loading_status.enum.dart';
import 'package:template/common/utils/log.dart';
import 'package:template/common/utils/string.utils.dart';
import 'package:template/common/widgets/custom_button.dart';
import 'package:template/common/widgets/custom_datetime_picker.dart';
import 'package:template/common/widgets/custom_gap.dart';
import 'package:template/common/widgets/custom_textfield.dart';
import 'package:template/common/widgets/custome_component_title.dart';
import 'package:template/pages/new_plan/bloc/new_plan.bloc.dart';
import 'package:template/pages/new_plan/screen/pick_section.dart';

class NewPlan extends StatefulWidget {
  final NewPlanBloc newPlanBloc;
  const NewPlan({super.key, required this.newPlanBloc});

  @override
  State<NewPlan> createState() => _NewPlanState();
}

class _NewPlanState extends State<NewPlan> {
  final TextEditingController _planNameController = TextEditingController(),
      _startTimeController = TextEditingController(),
      _endTimeController = TextEditingController(),
      _minBudgetController = TextEditingController(),
      _maxBudgetController = TextEditingController(),
      _numOfMember = TextEditingController(),
      _tripIntentController = TextEditingController(),
      _tripIntentDescController = TextEditingController();
  DateTime _startTime = DateTime.now(), _endTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewPlanBloc, NewPlanState>(
      builder: (context, state) {
        List<SectionItem>? sections = state.sections;
        return Scaffold(
          appBar: AppBar(
            title: const Text(PageTitle.createPlan),
            // actions: [
            //   IconButton(
            //     icon: const Icon(Icons.save),
            //     onPressed: () {
            //       widget.newPlanBloc.add(SavePlanEvent());
            //     },
            //   ),
            // ],
          ),
          body: Container(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FormTextField(
                            label: 'Tên chuyến đi',
                            controller: _planNameController,
                          ),
                          const SizedBox(height: 5),
                          FormTextField(
                            label: 'Mô tả chuyến đi',
                            controller: _tripIntentController,
                          ),
                          const SizedBox(height: 5),
                          FormTextField(
                            label: 'Một số yêu cầu cho chuyến đi',
                            controller: _tripIntentDescController,
                          ),
                          const SizedBox(height: 5),
                          FormTextField(
                            label: 'Bắt đầu',
                            controller: _startTimeController,
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.calendar_today),
                              onPressed: () {
                                CustomDateTimePicker.showDateTimePicker(
                                  context,
                                  (date, list) {
                                    _startTimeController.text =
                                        DateFormat('dd/MM/yyyy HH:mm')
                                            .format(date);
                                    setState(
                                      () {
                                        _startTime = date;
                                      },
                                    );
                                  },
                                );
                                // widget.newPlanBloc.add(
                                //   const SelectStartTimeEvent(),
                                // );
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          FormTextField(
                            label: 'Kết thúc',
                            controller: _endTimeController,
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.calendar_today),
                              onPressed: () {
                                CustomDateTimePicker.showDateTimePicker(
                                  context,
                                  (date, list) {
                                    _endTimeController.text =
                                        DateFormat('dd/MM/yyyy HH:mm')
                                            .format(date);
                                    setState(
                                      () {
                                        _endTime = date;
                                      },
                                    );
                                  },
                                );
                                // widget.newPlanBloc.add(
                                //   const SelectStartTimeEvent(),
                                // );
                              },
                            ),
                          ),
                          const SizedBox(height: 5),
                          FormTextField(
                            label: 'Số thành viên',
                            controller: _numOfMember,
                            keyboardType: TextInputType.number,
                          ),
                          const ComponentTitle(title: 'Ngân sách (VND)'),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Expanded(
                                child: FormTextField(
                                  label: 'Min',
                                  controller: _minBudgetController,
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    setState(() {
                                      String newFormattedValue =
                                          StringUtils.formatNumber(value);
                                      _minBudgetController.text =
                                          newFormattedValue;
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(width: 7),
                              Expanded(
                                child: FormTextField(
                                  label: 'Max',
                                  controller: _maxBudgetController,
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    setState(
                                      () {
                                        _maxBudgetController.text =
                                            StringUtils.formatNumber(value);
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          const ComponentTitle(title: 'Địa điểm'),
                          const SizedBox(height: 2),
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return PickSectionsScreen(
                                    selectedSections: state.sections,
                                    getSelectedSections: (sectionList) {
                                      widget.newPlanBloc.add(
                                        SelectSectionListEvent(
                                            selectedSections: sectionList),
                                      );
                                    },
                                  );
                                },
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: sections == null || sections.isEmpty
                                  ? const Text(
                                      "Chọn tỉnh...",
                                      style: TextStyle(color: Colors.grey),
                                    )
                                  : Wrap(
                                      spacing: 6,
                                      runSpacing: 6,
                                      children: sections.map(
                                        (item) {
                                          return Chip(
                                            label: Text(item.sectionName),
                                            deleteIcon: const Icon(Icons.cancel,
                                                size: 18),
                                            onDeleted: () {
                                              widget.newPlanBloc.add(
                                                SelectSectionEvent(
                                                  isSelected: false,
                                                  section: item,
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      ).toList(),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomOutlinedButton(
                        text: 'Tạo lịch trình bằng AI',
                        onPressed: () {},
                      ),
                      const CustomVerticalGap(),
                      state.createPlanStatus == LoadingStatus.loading
                          ? const CircularProgressIndicator()
                          : BigCustomButton(
                              text: 'Lưu',
                              onPressed: () {
                                widget.newPlanBloc.add(
                                  CreatePlanEvent(
                                    reqCreateTrip: ReqCreateTrip(
                                      mainLocations: state.sections != null
                                          ? state.sections!
                                              .map((item) => item.sectionId)
                                              .toList()
                                          : [],
                                      tripName: _planNameController.text,
                                      tripIntent: _tripIntentController.text,
                                      tripIntentDescription:
                                          _tripIntentDescController.text,
                                      numOfMembers:
                                          int.tryParse(_numOfMember.text) ?? 1,
                                      startTime: _startTime,
                                      endTime: _endTime,
                                      minBudget:
                                          StringUtils.parseFormattedStrToDouble(
                                              _minBudgetController.text),
                                      maxBudget:
                                          StringUtils.parseFormattedStrToDouble(
                                              _maxBudgetController.text),
                                    ),
                                  ),
                                );
                              },
                            )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class NewPlanScreen extends StatelessWidget {
  const NewPlanScreen({super.key});
  @override
  Widget build(BuildContext context) => BlocProvider<NewPlanBloc>(
        create: (_) => NewPlanBloc(),
        child: BlocListener<NewPlanBloc, NewPlanState>(
          listener: _listener,
          child: Builder(
            builder: (BuildContext context) => NewPlan(
              newPlanBloc: context.read<NewPlanBloc>(),
            ),
          ),
        ),
      );
}

void _listener(BuildContext context, NewPlanState state) {
  switch (state.createPlanStatus) {
    case LoadingStatus.loaded:
      Navigator.of(context).pop(state.createdPlan);
      // Do nothing
      break;
    case LoadingStatus.error:
      showMessage(context, state.createPlanErrMsg ?? 'Error in create plan', 1);
    default:
  }
}

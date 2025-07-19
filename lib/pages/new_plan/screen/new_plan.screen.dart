import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/api/plan/dto/ReqCreateTrip.dart';
import 'package:template/api/plan/dto/getSection.dart';
import 'package:template/common/constants/colors.dart';
import 'package:template/common/constants/page_title.dart';
import 'package:template/common/enums/loading_status.enum.dart';
import 'package:template/common/utils/log.dart';
import 'package:template/common/widgets/custom_date_picker.dart';
import 'package:template/common/widgets/custom_text_area.dart';
import 'package:template/common/widgets/custom_textfield.dart';
import 'package:template/common/widgets/custome_component_title.dart';
import 'package:template/common/widgets/tagify_input.dart';
import 'package:template/pages/new_plan/bloc/new_plan.bloc.dart';
import 'package:template/pages/new_plan/bloc/pick_section/pick_section.bloc.dart';

class NewPlan extends StatefulWidget {
  final NewPlanBloc newPlanBloc;
  const NewPlan({super.key, required this.newPlanBloc});

  @override
  State<NewPlan> createState() => _NewPlanState();
}

class _NewPlanState extends State<NewPlan> {
  final TextEditingController _planNameController = TextEditingController(),
      _minBudgetController = TextEditingController(),
      _maxBudgetController = TextEditingController(),
      _numOfMember = TextEditingController(),
      _tripIntentController = TextEditingController(),
      _tripIntentDescController = TextEditingController();
  DateTime _startTime = DateTime.now(), _endTime = DateTime.now();

  // Biến để lưu trữ địa điểm đã chọn cho TagifyInput
  List<TagifyItem<SectionItem>> _selectedLocations = [];
  List<TagifyItem<SectionItem>> _availableLocations = [];

  // Tạo PickSectionBloc để lấy sections
  late PickSectionBloc _pickSectionBloc;

  @override
  void initState() {
    super.initState();
    // Khởi tạo PickSectionBloc để lấy sections
    _pickSectionBloc = PickSectionBloc();
  }

  @override
  void dispose() {
    _pickSectionBloc.close();
    super.dispose();
  }

  // Convert SectionItem list thành TagifyItem list
  List<TagifyItem<SectionItem>> _convertToTagifyItems(List<SectionItem>? sections) {
    if (sections == null) return [];
    return sections.map((section) {
      return TagifyItem<SectionItem>(
        displayName: section.sectionName,
        value: section,
        icon: Icons.location_city, // Default icon
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: widget.newPlanBloc),
        BlocProvider.value(value: _pickSectionBloc),
      ],
      child: BlocBuilder<NewPlanBloc, NewPlanState>(
        builder: (context, newPlanState) {
          return BlocBuilder<PickSectionBloc, PickSectionState>(
            builder: (context, pickSectionState) {
              // Cập nhật available locations từ PickSectionBloc
              _availableLocations = _convertToTagifyItems(pickSectionState.sections);

              return Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  title: const Text(PageTitle.createPlan),
                ),
                body: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FormTextField(
                                label: 'Tên chuyến đi',
                                controller: _planNameController,
                              ),
                              const SizedBox(height: 5),
                              CustomTextArea(
                                label: 'Mô tả chuyến đi',
                                controller: _tripIntentController,
                                placeholder: 'Nhập mô tả chuyến đi',
                              ),
                              const SizedBox(height: 5),
                              CustomTextArea(
                                label: 'Một số yêu cầu cho chuyến đi',
                                controller: _tripIntentDescController,
                                placeholder: 'Một số yêu cầu cho chuyến đi',
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  Expanded(
                                    child: CustomDatePicker(
                                      label: 'Thời gian bắt đầu',
                                      placeholder: 'Bắt đầu',
                                      onDateChanged: (date) {
                                        setState(() {
                                          _startTime = date;
                                        });
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 7),
                                  Expanded(
                                    child: CustomDatePicker(
                                      label: 'Thời gian kết thúc',
                                      placeholder: 'Kết thúc',
                                      onDateChanged: (date) {
                                        setState(() {
                                          _endTime = date;
                                        });
                                      },
                                    ),
                                  ),
                                ],
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
                                    ),
                                  ),
                                  const SizedBox(width: 7),
                                  Expanded(
                                    child: FormTextField(
                                      label: 'Max',
                                      controller: _maxBudgetController,
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                ],
                              ),
                              TagifyInput<SectionItem>(
                                label: "Địa điểm",
                                placeholder: "Tìm và chọn địa điểm...",
                                availableItems: _availableLocations,
                                selectedItems: _selectedLocations,
                                selectedTagColor: CustomColors.primary,
                                unselectedTagColor: Colors.grey[300]!,
                                backgroundColor: Colors.white,
                                borderColor: Colors.grey[300]!,
                                labelColor: const Color(0xFF808080),
                                borderRadius: 8,
                                tagBorderRadius: 16,
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                margin: const EdgeInsets.symmetric(vertical: 4),
                                showDropdown: true,
                                maxDropdownHeight: 200,
                                maxSelection: 10,
                                onItemsChanged: (selectedItems) {
                                  setState(() {
                                    _selectedLocations = selectedItems;
                                  });

                                  // Cập nhật NewPlanBloc state
                                  List<SectionItem> selectedSections = selectedItems
                                      .map((item) => item.value)
                                      .toList();
                                  widget.newPlanBloc.add(
                                    SelectSectionListEvent(
                                      selectedSections: selectedSections,
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                        child: SafeArea(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              OutlinedButton(
                                onPressed: () {
                                  // TODO: Implement AI plan creation
                                },
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(color: CustomColors.primary),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                                ),
                                child: const Text(
                                  'Tạo lịch trình bằng AI',
                                  style: TextStyle(fontWeight: FontWeight.w600, color: CustomColors.primary),
                                ),
                              ),
                              const SizedBox(width: 16),
                              ElevatedButton(
                                onPressed: () {
                                  // Validate required fields before creating the trip
                                  final tripName = _planNameController.text.trim();
                                  final tripIntent = _tripIntentController.text.trim();
                                  final tripIntentDescription = _tripIntentDescController.text.trim();

                                  // Check if required fields are not empty
                                  if (tripName.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Vui lòng nhập tên chuyến đi'),
                                        backgroundColor: CustomColors.error,
                                      ),
                                    );
                                    return;
                                  }

                                  // Debug logging to identify null values
                                  print('Debug - Creating trip with:');
                                  print('tripName: "$tripName"');
                                  print('tripIntent: "$tripIntent"');
                                  print('tripIntentDescription: "$tripIntentDescription"');
                                  print('startTime: $_startTime');
                                  print('endTime: $_endTime');
                                  print('sections: ${newPlanState.sections?.map((s) => 'id: ${s.sectionId}, name: ${s.sectionName}').toList()}');

                                  // Safely extract section IDs with null filtering
                                  final List<String> mainLocations = newPlanState.sections
                                      ?.where((item) => item.sectionId.isNotEmpty) // Filter out empty IDs
                                      .map((item) => item.sectionId)
                                      .toList() ?? <String>[];

                                  print('Debug - mainLocations after filtering: $mainLocations');

                                  final reqCreateTrip = ReqCreateTrip(
                                    mainLocations: mainLocations,
                                    tripName: tripName,
                                    tripIntent: tripIntent.isEmpty ? '' : tripIntent,
                                    tripIntentDescription: tripIntentDescription.isEmpty ? '' : tripIntentDescription,
                                    numOfMembers: int.tryParse(_numOfMember.text.trim()) ?? 1,
                                    startTime: _startTime,
                                    endTime: _endTime,
                                    minBudget: double.tryParse(_minBudgetController.text.trim()) ?? 0.0,
                                    maxBudget: double.tryParse(_maxBudgetController.text.trim()) ?? 0.0,
                                  );

                                  print('Debug - ReqCreateTrip created successfully');
                                  try {
                                    final json = reqCreateTrip.toJson();
                                    print('=== COMPLETE JSON REQUEST ===');
                                    print('tripName: ${json['tripName']}');
                                    print('tripIntent: ${json['tripIntent']}');
                                    print('startDate: ${json['startDate']}');
                                    print('endDate: ${json['endDate']}');
                                    print('numOfParticipants: ${json['numOfParticipants']}');
                                    print('budget: ${json['budget']}');
                                    print('mainLocation: ${json['mainLocation']}');
                                    print('intentDescription: ${json['intentDescription']}');
                                    print('=== FULL JSON ===');
                                    print('JSON: $json');
                                    print('=== END JSON REQUEST ===');
                                  } catch (e) {
                                    print('Error creating JSON: $e');
                                    return;
                                  }

                                  widget.newPlanBloc.add(
                                    CreatePlanEvent(
                                      reqCreateTrip: reqCreateTrip,
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: CustomColors.primary,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                                ),
                                child: const Text(
                                  'Lưu',
                                  style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
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

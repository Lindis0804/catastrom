import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:template/api/plan/dto/ReqCreateTrip.dart';
import 'package:template/api/plan/dto/getSection.dart';
import 'package:template/common/constants/colors.dart';
import 'package:template/common/constants/page_title.dart';
import 'package:template/common/enums/loading_status.enum.dart';
import 'package:template/common/utils/log.dart';
import 'package:template/common/widgets/custom_button.dart';
import 'package:template/common/widgets/custom_date_picker.dart';
import 'package:template/common/widgets/custom_text_area.dart';
import 'package:template/common/widgets/custom_textfield.dart';
import 'package:template/common/widgets/custome_component_title.dart';
import 'package:template/common/widgets/tagify_input.dart';
import 'package:template/pages/new_plan/bloc/new_plan.bloc.dart';

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

  // Danh sách tất cả địa điểm có sẵn (có thể lấy từ API hoặc hardcode)
  final List<TagifyItem<SectionItem>> _allLocations = [
    TagifyItem<SectionItem>(
      displayName: "Hà Nội",
      value: SectionItem(sectionId: "1", sectionName: "Hà Nội"),
      icon: Icons.location_city,
    ),
    TagifyItem<SectionItem>(
      displayName: "TP. Hồ Chí Minh",
      value: SectionItem(sectionId: "2", sectionName: "TP. Hồ Chí Minh"),
      icon: Icons.location_city,
    ),
    TagifyItem<SectionItem>(
      displayName: "Đà Nẵng",
      value: SectionItem(sectionId: "3", sectionName: "Đà Nẵng"),
      icon: Icons.beach_access,
    ),
    TagifyItem<SectionItem>(
      displayName: "Hội An",
      value: SectionItem(sectionId: "4", sectionName: "Hội An"),
      icon: Icons.temple_buddhist,
    ),
    TagifyItem<SectionItem>(
      displayName: "Nha Trang",
      value: SectionItem(sectionId: "5", sectionName: "Nha Trang"),
      icon: Icons.beach_access,
    ),
    TagifyItem<SectionItem>(
      displayName: "Phú Quốc",
      value: SectionItem(sectionId: "6", sectionName: "Phú Quốc"),
      icon: Icons.waves,
    ),
    TagifyItem<SectionItem>(
      displayName: "Sapa",
      value: SectionItem(sectionId: "7", sectionName: "Sapa"),
      icon: Icons.landscape,
    ),
    TagifyItem<SectionItem>(
      displayName: "Hạ Long",
      value: SectionItem(sectionId: "8", sectionName: "Hạ Long"),
      icon: Icons.sailing,
    ),
  ];

  // Convert SectionItem list thành TagifyItem list
  List<TagifyItem<SectionItem>> _convertToTagifyItems(List<SectionItem>? sections) {
    if (sections == null) return [];
    return sections.map((section) {
      // Tìm item tương ứng trong _allLocations để lấy icon
      final matchingItem = _allLocations.firstWhere(
        (item) => item.value.sectionId == section.sectionId,
        orElse: () => TagifyItem<SectionItem>(
          displayName: section.sectionName,
          value: section,
        ),
      );
      return matchingItem;
    }).toList();
  }

  // Cập nhật selected locations từ state.sections
  void _updateSelectedLocations(List<SectionItem>? sections) {
    if (sections != null) {
      _selectedLocations = _convertToTagifyItems(sections);
    } else {
      _selectedLocations = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewPlanBloc, NewPlanState>(
      builder: (context, state) {
        List<SectionItem>? sections = state.sections;
        _updateSelectedLocations(sections); // Cập nhật biến lưu trữ địa điểm đã chọn
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text(PageTitle.createPlan),
            // actions: [ ... ]
          ),
          body: GestureDetector(
            onTap: () {
              // Unfocus any focused text field when tapping outside
              FocusScope.of(context).unfocus();
            },
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: SingleChildScrollView(
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
                        FormTextField(
                          label: 'Một số yêu cầu cho chuyến đi',
                          controller: _tripIntentDescController,
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Expanded(
                              child: CustomDatePicker(
                                label: 'Thời gian bắt đầu',
                                placeholder: 'Chọn thời gian bắt đầu',
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
                                placeholder: 'Chọn thời gian kết thúc',
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
                          availableItems: _allLocations,
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
                            // Cập nhật BLoC state khi có thay đổi
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
                        const SizedBox(height: 80), // Add space for bottom buttons
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
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
                            // TODO: Implement save logic
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

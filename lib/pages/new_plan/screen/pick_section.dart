import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/api/plan/dto/getSection.dart';
import 'package:template/common/enums/loading_status.enum.dart';
import 'package:template/common/utils/log.dart';
import 'package:template/pages/new_plan/bloc/pick_section/pick_section.bloc.dart';

class PickSections extends StatefulWidget {
  final PickSectionBloc pickSectionsBloc;
  final void Function(List<SectionItem> selectedSections) getSelectedSections;
  final List<SectionItem>? selectedSections;
  const PickSections(
      {super.key,
      required this.pickSectionsBloc,
      required this.getSelectedSections,
      this.selectedSections});

  @override
  State<PickSections> createState() => _PickSectionsState();
}

class _PickSectionsState extends State<PickSections> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.pickSectionsBloc.add(
      Inititalize(selectedSections: widget.selectedSections),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PickSectionBloc, PickSectionState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                autofocus: true,
                decoration: const InputDecoration(
                  labelText: 'Tìm kiếm...',
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: (text) {
                  widget.pickSectionsBloc.add(SearchSectionEvent(text));
                },
              ),
              const SizedBox(height: 16),
              Expanded(
                child: state.sections != null
                    ? SingleChildScrollView(
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: state.sections!.map(
                            (option) {
                              final isSelected =
                                  state.selectedSections != null &&
                                      state.selectedSections!
                                          .map((item) => item.sectionName)
                                          .contains(option.sectionName);
                              return FilterChip(
                                label: Text(option.sectionName),
                                selected: isSelected,
                                onSelected: (selected) {
                                  widget.pickSectionsBloc.add(
                                    SelectSectionEvent(
                                      section: option,
                                      isSelected: isSelected,
                                    ),
                                  ); // Cập nhật giao diện bên ngoài
                                },
                              );
                            },
                          ).toList(),
                        ),
                      )
                    : SizedBox(),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                child: const Text('Xong'),
                onPressed: () {
                  Navigator.pop(context);
                  if (state.selectedSections != null &&
                      state.selectedSections!.isNotEmpty) {
                    widget.getSelectedSections(state.selectedSections!);
                  }
                },
              )
            ],
          ),
        );
      },
    );
  }
}

class PickSectionsScreen extends StatelessWidget {
  const PickSectionsScreen(
      {super.key, required this.getSelectedSections, this.selectedSections});
  final void Function(List<SectionItem> selectedSections) getSelectedSections;
  final List<SectionItem>? selectedSections;
  @override
  Widget build(BuildContext context) => BlocProvider<PickSectionBloc>(
        create: (_) => PickSectionBloc(),
        child: BlocListener<PickSectionBloc, PickSectionState>(
          //  listenWhen: (pre, cur) => pre.homeStatus != cur.homeStatus,
          listener: _listener,
          child: Builder(
            builder: (BuildContext context) => PickSections(
              pickSectionsBloc: context.read<PickSectionBloc>(),
              getSelectedSections: getSelectedSections,
              selectedSections: selectedSections,
            ),
          ),
        ),
      );
}

void _listener(BuildContext context, PickSectionState state) {
  switch (state.getSectionsStatus) {
    case LoadingStatus.error:
      showMessage(context, '${state.getSectionsFailMsg}', 1);
    default:
  }
}

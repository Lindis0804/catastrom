part of 'pick_section.bloc.dart';

class PickSectionState extends Equatable {
  final LoadingStatus getSectionsStatus;
  final String? getSectionsFailMsg;
  final List<SectionItem>? sections, selectedSections;
  const PickSectionState(
      {required this.getSectionsStatus,
      this.getSectionsFailMsg,
      this.selectedSections,
      this.sections});

  factory PickSectionState.initialize() {
    return const PickSectionState(
      getSectionsStatus: LoadingStatus.initialize,
    );
  }

  PickSectionState copyWith(
      {LoadingStatus? getSectionsStatus,
      String? getSectionsFailMsg,
      List<SectionItem>? sections,
      List<SectionItem>? selectedSections}) {
    return PickSectionState(
      getSectionsStatus: getSectionsStatus ?? this.getSectionsStatus,
      getSectionsFailMsg: getSectionsFailMsg ?? this.getSectionsFailMsg,
      sections: sections ?? this.sections,
      selectedSections: selectedSections ?? this.selectedSections,
    );
  }

  @override
  List<Object?> get props =>
      [getSectionsStatus, getSectionsFailMsg, sections, selectedSections];
}

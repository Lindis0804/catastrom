part of 'pick_section.bloc.dart';

sealed class PickSectionEvent {
  const PickSectionEvent();
}

class Inititalize extends PickSectionEvent {
  final List<SectionItem>? selectedSections;
  const Inititalize({this.selectedSections});
}

class SearchSectionEvent extends PickSectionEvent {
  final String searchText;

  const SearchSectionEvent(this.searchText);
}

class SelectSectionEvent extends PickSectionEvent {
  final SectionItem section;
  final bool isSelected;
  const SelectSectionEvent({required this.section, required this.isSelected});
}

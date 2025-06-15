part of 'edit_plan.bloc.dart';

sealed class NewPlanEvent {
  const NewPlanEvent();
}

class Inititalize extends NewPlanEvent {
  const Inititalize();
}

class CreatePlanEvent extends NewPlanEvent {
  final ReqCreateTrip reqCreateTrip;

  const CreatePlanEvent({required this.reqCreateTrip});
}

class SelectSectionEvent extends NewPlanEvent {
  final SectionItem section;
  final bool isSelected;

  const SelectSectionEvent({required this.section, required this.isSelected});
}

class SelectSectionListEvent extends NewPlanEvent {
  final List<SectionItem> selectedSections;

  const SelectSectionListEvent({required this.selectedSections});
}

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/api/plan/dto/getSection.dart';
import 'package:template/api/plan/provider.dart';
import 'package:template/common/enums/loading_status.enum.dart';
import 'package:template/common/utils/share_preferences.dart';

part 'pick_section.event.dart';
part 'pick_section.state.dart';

class PickSectionBloc extends Bloc<PickSectionEvent, PickSectionState> {
  PickSectionBloc() : super(PickSectionState.initialize()) {
    on<Inititalize>(_onInitialize);
    on<SearchSectionEvent>(_onSearchSection);
    on<SelectSectionEvent>(_onSelectSection);

    add(
      const Inititalize(),
    );
  }

  void _onInitialize(
    PickSectionEvent event,
    Emitter<PickSectionState> emitter,
  ) async {
    if (event is! Inititalize) {
      return;
    }
    emitter(
      state.copyWith(
        getSectionsStatus: LoadingStatus.loading,
      ),
    );
    try {
      String accessToken = await SharedPreferencesManager.getAccessToken();
      List<SectionItem> sections =
          (await PlanApiProvider(accessToken: accessToken)
                  .getSections(reqGetSections: ReqGetSections()))
              .sections;
      emitter(
        state.copyWith(
          getSectionsStatus: LoadingStatus.loaded,
          sections: sections,
        ),
      );
    } catch (e) {
      emitter(
        state.copyWith(
          getSectionsStatus: LoadingStatus.error,
          getSectionsFailMsg: 'Error in getting sections: ${e.toString()}',
        ),
      );
    }
  }

  void _onSearchSection(
    SearchSectionEvent event,
    Emitter<PickSectionState> emitter,
  ) async {
    if (event is! SearchSectionEvent) {
      return;
    }
    emitter(
      state.copyWith(
        getSectionsStatus: LoadingStatus.loading,
      ),
    );
    final searchText = event.searchText.toLowerCase();
    try {
      String accessToken = await SharedPreferencesManager.getAccessToken();
      List<SectionItem> sections =
          (await PlanApiProvider(accessToken: accessToken).getSections(
                  reqGetSections: ReqGetSections(searchKey: searchText)))
              .sections;

      emitter(
        state.copyWith(
          sections: sections,
          getSectionsStatus: LoadingStatus.loaded,
        ),
      );
    } catch (e) {
      emitter(
        state.copyWith(
          getSectionsStatus: LoadingStatus.error,
          getSectionsFailMsg: 'Error in getting sections: ${e.toString()}',
        ),
      );
    }
  }

  void _onSelectSection(
    SelectSectionEvent event,
    Emitter<PickSectionState> emitter,
  ) {
    if (event is! SelectSectionEvent) {
      return;
    }
    final selectedSections =
        List<SectionItem>.from(state.selectedSections ?? []);
    if (!event.isSelected) {
      selectedSections.add(event.section);
    } else {
      selectedSections
          .removeWhere((item) => item.sectionName == event.section.sectionName);
    }
    emitter(
      state.copyWith(
        selectedSections: selectedSections,
      ),
    );
  }
}

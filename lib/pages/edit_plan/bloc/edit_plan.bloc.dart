import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/api/plan/dto/ReqCreateTrip.dart';
import 'package:template/api/plan/dto/getSection.dart';
import 'package:template/api/plan/provider.dart';
import 'package:template/common/enums/loading_status.enum.dart';
import 'package:template/common/utils/share_preferences.dart';
import 'package:template/data/models/plan/plan.model.dart';

part 'edit_plan.event.dart';
part 'edit_plan.state.dart';

class NewPlanBloc extends Bloc<NewPlanEvent, NewPlanState> {
  NewPlanBloc() : super(NewPlanState.initialize()) {
    on<Inititalize>(_onInitialize);
    on<CreatePlanEvent>(_onCreatePlan);
    on<SelectSectionEvent>(_onSelectSection);
    on<SelectSectionListEvent>(_onSelectSectionList);
    add(
      const Inititalize(),
    );
  }

  void _onInitialize(
    NewPlanEvent event,
    Emitter<NewPlanState> emitter,
  ) async {
    if (event is! Inititalize) {
      return;
    }
  }

  void _onCreatePlan(
    CreatePlanEvent event,
    Emitter<NewPlanState> emitter,
  ) async {
    emitter(
      state.copyWith(
        createPlanStatus: LoadingStatus.loading,
      ),
    );
    try {
      final ReqCreateTrip reqCreateTrip = event.reqCreateTrip;
      final String accessToken =
          await SharedPreferencesManager.getAccessToken();
      final createdTrip =
          await PlanApiProvider(accessToken: accessToken).createPlan(
        reqCreateTrip: reqCreateTrip,
      );
      emitter(
        state.copyWith(
          createPlanStatus: LoadingStatus.loaded,
          createdPlan: createdTrip,
        ),
      );
    } catch (e) {
      emitter(
        state.copyWith(
          createPlanStatus: LoadingStatus.error,
          createPlanErrMsg: 'Error in create trip: $e',
        ),
      );
    }
  }

  void _onSelectSection(
    NewPlanEvent event,
    Emitter<NewPlanState> emitter,
  ) async {
    if (event is! SelectSectionEvent) {
      return;
    }
    emitter(
      state.copyWith(
        getSectionsStatus: LoadingStatus.loading,
      ),
    );
    final List<SectionItem> sections = state.sections ?? [];

    print(sections);
    if (!event.isSelected) {
      sections
          .removeWhere((item) => item.sectionName == event.section.sectionName);
    }
    print(sections);
    emitter(
      state.copyWith(
        sections: sections,
        getSectionsStatus: LoadingStatus.loaded,
      ),
    );
  }

  void _onSelectSectionList(
    SelectSectionListEvent event,
    Emitter<NewPlanState> emitter,
  ) {
    emitter(
      state.copyWith(
          sections: event.selectedSections,
          getSectionsStatus: LoadingStatus.loaded),
    );
  }
}

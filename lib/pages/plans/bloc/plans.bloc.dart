import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/api/plan/dto/DeleteTrip.dart';
import 'package:template/api/plan/dto/ReqParamsSearchTrip.dart';
import 'package:template/api/plan/provider.dart';
import 'package:template/common/enums/loading_status.enum.dart';
import 'package:template/common/enums/plans.enum.dart';
import 'package:template/common/utils/share_preferences.dart';
import 'package:template/data/mocks/mock.plan.dart';
import 'package:template/data/models/plan/plan.model.dart';

part 'plans.event.dart';
part 'plans.state.dart';

class PlansBloc extends Bloc<PlansEvent, PlansState> {
  PlansBloc() : super(PlansState.initialize()) {
    on<Inititalize>(_onInitialize);
    on<ToNewPlanScreenEvent>(_onToNewPlanScreen);
    on<CreatedPlanEvent>(_onCreatedPlan);
    on<DeletePlanEvent>(_onDeletePlan);
    on<ToEditPlanScreenEvent>(_onToEditPlanScreen);
    add(
      const Inititalize(),
    );
  }

  void _onInitialize(
    PlansEvent event,
    Emitter<PlansState> emitter,
  ) async {
    if (event is! Inititalize) {
      return;
    }

    emitter(
      state.copyWith(getMyPlansStatus: LoadingStatus.loading),
    );
    List<Plan>? myPlans;
    try {
      String accessToken = await SharedPreferencesManager.getAccessToken();
      PlanApiProvider planApiProvider =
          PlanApiProvider(accessToken: accessToken);
      await Future.wait(
        [
          () async {
            try {
              myPlans = await planApiProvider.getMyPlans(
                reqParamsSearchTrip: ReqParamsSearchTrip(
                  pagable: ObjPagable(
                    page: state.plansPageIdx,
                    size: state.plansPageSize,
                    sort: [],
                  ),
                ),
              );
              emitter(
                state.copyWith(
                    myPlans: myPlans, getMyPlansStatus: LoadingStatus.loaded),
              );
            } catch (err) {
              emitter(
                state.copyWith(
                    getMyPlansStatus: LoadingStatus.error,
                    getMyPlansErrMsg: 'Get my plans fail: $err'),
              );
            }
          }()
        ],
      );
    } catch (err) {}
  }

  void _onToNewPlanScreen(
    PlansEvent event,
    Emitter<PlansState> emitter,
  ) {
    emitter(
      state.copyWith(plansStatus: EPlans.toNewPlanScreen),
    );
  }

  void _onCreatedPlan(
    PlansEvent event,
    Emitter<PlansState> emitter,
  ) {
    if (event is! CreatedPlanEvent) {
      return;
    }

    if (event.plan == null) {
      emitter(
        state.copyWith(
            plansStatus: EPlans.init, createPlanErrMsg: 'Create plan fail'),
      );
      return;
    }

    List<Plan> plans = state.myPlans ?? [];
    plans.insert(0, event.plan!);

    emitter(
      state.copyWith(myPlans: plans, plansStatus: EPlans.init),
    );
  }

  void _onDeletePlan(
    DeletePlanEvent event,
    Emitter<PlansState> emitter,
  ) async {
    emitter(
      state.copyWith(deletePlanStatus: LoadingStatus.loading),
    );

    String tripcode = event.planCode;
    String accessToken = await SharedPreferencesManager.getAccessToken();
    PlanApiProvider planApiProvider = PlanApiProvider(accessToken: accessToken);
    ResDeleteTrip resDeleteTrip = await planApiProvider.deletePlan(
      reqDeleteTrip: ReqDeleteTrip(tripCode: tripcode),
    );
    if (resDeleteTrip.status == EDeleteTripStatus.SUCCESS) {
      List<Plan>? myPlans = state.myPlans;
      if (myPlans != null && myPlans.isNotEmpty) {
        myPlans.removeWhere((item) => item.tripCode == tripcode);
      }
      emitter(
        state.copyWith(
            myPlans: myPlans, deletePlanStatus: LoadingStatus.loaded),
      );
    } else {
      emitter(
        state.copyWith(
            deletePlanStatus: LoadingStatus.error,
            deletePlanErrMsg: 'Delete plan $tripcode fail.'),
      );
    }
  }

  void _onToEditPlanScreen(
    ToEditPlanScreenEvent event,
    Emitter<PlansState> emitter,
  ) {
    emitter(
      state.copyWith(plansStatus: EPlans.toEditPlanScreen),
    );
  }
}

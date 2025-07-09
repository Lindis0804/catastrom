import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/common/enums/loading_status.enum.dart';
import 'package:template/common/enums/manage.enum.dart';
import 'package:template/data/models/user/user.model.dart';

part 'manage.event.dart';
part 'manage.state.dart';

class ManageBloc extends Bloc<ManageEvent, ManageState> {
  ManageBloc() : super(ManageState.initialize()) {
    on<Inititalize>(_onInitialize);
    on<ToPageCreatePlanEvent>(_onToPageCreatePlanEvent);
    on<ChangePageIdxEvent>(_onChangePageIdx);
    add(
      const Inititalize(),
    );
  }

  void _onInitialize(
    ManageEvent event,
    Emitter<ManageState> emitter,
  ) async {
    if (event is! Inititalize) {
      return;
    }
  }

  void _onToPageCreatePlanEvent(
    ManageEvent event,
    Emitter<ManageState> emitter,
  ) async {
    if (event is! ToPageCreatePlanEvent) {
      return;
    }
    emitter(
      state.copyWith(
        pageManageStatus: EPageManageStatus.toCreatePlanPage,
      ),
    );
  }

  void _onChangePageIdx(
    ChangePageIdxEvent event,
    Emitter<ManageState> emitter,
  ) async {
    emitter(
      state.copyWith(
        pageIdx: event.pageIdx,
      ),
    );
  }
}

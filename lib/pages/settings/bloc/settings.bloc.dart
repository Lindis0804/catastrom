import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/common/enums/loading_status.enum.dart';
part 'settings.event.dart';
part 'settings.state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsState.initialize()) {
    on<Inititalize>(_onInitialize);

    add(
      const Inititalize(),
    );
  }

  void _onInitialize(
    SettingsEvent event,
    Emitter<SettingsState> emitter,
  ) async {
    if (event is! Inititalize) {
      return;
    }
  }
}

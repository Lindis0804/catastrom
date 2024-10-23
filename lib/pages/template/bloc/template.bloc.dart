import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/common/enums/loading_status.enum.dart';

part 'template.event.dart';
part 'template.state.dart';

class HomeBloc extends Bloc<TemplateEvent, HomeState> {
  HomeBloc() : super(HomeState.initialize()) {
    on<Inititalize>(_onInitialize);

    add(
      const Inititalize(),
    );
  }

  void _onInitialize(
    TemplateEvent event,
    Emitter<HomeState> emitter,
  ) async {
    if (event is! Inititalize) {
      return;
    }
  }
}

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/common/enums/loading_status.enum.dart';

part 'template.event.dart';
part 'template.state.dart';

class TemplateBloc extends Bloc<TemplateEvent, TemplateState> {
  TemplateBloc() : super(TemplateState.initialize()) {
    on<Inititalize>(_onInitialize);

    add(
      const Inititalize(),
    );
  }

  void _onInitialize(
    TemplateEvent event,
    Emitter<TemplateState> emitter,
  ) async {
    if (event is! Inititalize) {
      return;
    }
  }
}

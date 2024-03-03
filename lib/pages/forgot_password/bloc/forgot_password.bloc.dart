import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/common/enums/forgot_password_status.enum.dart';
import 'package:equatable/equatable.dart';
part 'forgot_password.event.dart';
part 'forgot_password.state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc() : super(const ForgotPasswordState.init()) {
    on<ForgotPasswordStatusChanged>(_onStatusChanged);
  }
  void _onStatusChanged(
      ForgotPasswordEvent event, Emitter<ForgotPasswordState> emitter) {
    if (event is ForgotPasswordStatusChanged) {
      switch (event.status) {
        default:
      }
    }
  }
}

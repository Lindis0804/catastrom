import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/common/enums/loading_status.enum.dart';
import 'package:template/common/enums/profile.enum.dart';
import 'package:template/data/models/user/user.model.dart';

part 'profile.event.dart';
part 'profile.state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileState.initialize()) {
    on<Inititalize>(_onInitialize);

    add(
      const Inititalize(),
    );
  }

  void _onInitialize(
    ProfileEvent event,
    Emitter<ProfileState> emitter,
  ) async {
    if (event is! Inititalize) {
      return;
    }
  }
}

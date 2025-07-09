part of 'profile.bloc.dart';

sealed class ProfileEvent {
  const ProfileEvent();
}

class Inititalize extends ProfileEvent {
  const Inititalize();
}

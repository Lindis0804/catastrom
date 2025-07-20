part of 'settings.bloc.dart';

sealed class SettingsEvent {
  const SettingsEvent();
}

class Inititalize extends SettingsEvent {
  const Inititalize();
}

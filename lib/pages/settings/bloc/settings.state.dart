part of 'settings.bloc.dart';

class SettingsState extends Equatable {
  final LoadingStatus homeStatus;

  const SettingsState({
    required this.homeStatus,
  });

  factory SettingsState.initialize() {
    return const SettingsState(
      homeStatus: LoadingStatus.initialize,
    );
  }

  SettingsState copyWith({
    LoadingStatus? getSubscribedDocumentsStatus,
  }) {
    return SettingsState(
      homeStatus: getSubscribedDocumentsStatus ?? this.homeStatus,
    );
  }

  @override
  List<Object?> get props => [homeStatus];
}

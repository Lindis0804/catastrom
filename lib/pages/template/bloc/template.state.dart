part of 'template.bloc.dart';

class HomeState extends Equatable {
  final LoadingStatus homeStatus;

  const HomeState({
    required this.homeStatus,
  });

  factory HomeState.initialize() {
    return const HomeState(
      homeStatus: LoadingStatus.initialize,
    );
  }

  HomeState copyWith({
    LoadingStatus? getSubscribedDocumentsStatus,
  }) {
    return HomeState(
      homeStatus: getSubscribedDocumentsStatus ?? this.homeStatus,
    );
  }

  @override
  List<Object?> get props => [homeStatus];
}

part of 'home.bloc.dart';

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
    LoadingStatus? homeStatus,
  }) {
    return HomeState(
      homeStatus: homeStatus ?? this.homeStatus,
    );
  }

  @override
  List<Object?> get props => [homeStatus];
}

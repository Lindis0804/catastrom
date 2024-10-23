part of 'home.bloc.dart';

class HomeState extends Equatable {
  final LoadingStatus templateStatus;

  const HomeState({
    required this.templateStatus,
  });

  factory HomeState.initialize() {
    return const HomeState(
      templateStatus: LoadingStatus.initialize,
    );
  }

  HomeState copyWith({
    LoadingStatus? getSubscribedDocumentsStatus,
  }) {
    return HomeState(
      templateStatus: getSubscribedDocumentsStatus ?? this.templateStatus,
    );
  }

  @override
  List<Object?> get props => [templateStatus];
}

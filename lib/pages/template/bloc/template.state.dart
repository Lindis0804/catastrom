part of 'template.bloc.dart';

class TemplateState extends Equatable {
  final LoadingStatus homeStatus;

  const TemplateState({
    required this.homeStatus,
  });

  factory TemplateState.initialize() {
    return const TemplateState(
      homeStatus: LoadingStatus.initialize,
    );
  }

  TemplateState copyWith({
    LoadingStatus? getSubscribedDocumentsStatus,
  }) {
    return TemplateState(
      homeStatus: getSubscribedDocumentsStatus ?? this.homeStatus,
    );
  }

  @override
  List<Object?> get props => [homeStatus];
}

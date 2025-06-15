part of 'splash.bloc.dart';

class SplashState extends Equatable {
  final SplashStatus status;

  const SplashState.initial() : status = SplashStatus.unknown;

  const SplashState.authenticated() : status = SplashStatus.authenticated;

  const SplashState.unauthenticated() : status = SplashStatus.unauthenticated;

  const SplashState({required this.status});

  @override
  List<Object?> get props => [status];

  SplashState copyWith({SplashStatus? status}) {
    return SplashState(
      status: status ?? this.status,
    );
  }
}

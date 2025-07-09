part of 'profile.bloc.dart';

class ProfileState extends Equatable {
  final LoadingStatus getUserStatus;
  final EPageProfileStatus pageProfileStatus;
  final User? user;
  const ProfileState(
      {required this.getUserStatus,
      required this.pageProfileStatus,
      this.user});

  factory ProfileState.initialize() {
    return const ProfileState(
        getUserStatus: LoadingStatus.initialize,
        pageProfileStatus: EPageProfileStatus.init);
  }

  ProfileState copyWith(
      {LoadingStatus? getUserStatus,
      EPageProfileStatus? pageProfileStatus,
      User? user}) {
    return ProfileState(
      getUserStatus: getUserStatus ?? this.getUserStatus,
      pageProfileStatus: pageProfileStatus ?? this.pageProfileStatus,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [getUserStatus, pageProfileStatus, user];
}

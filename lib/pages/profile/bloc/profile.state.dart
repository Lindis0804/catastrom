part of 'profile.bloc.dart';

class ProfileState extends Equatable {
  final LoadingStatus getUserStatus,
      getCurrentProfileStatus,
      requestAddFriendStatus;
  final EPageProfileStatus pageProfileStatus;
  final User? user;
  final User? currentProfile;
  final String? getUserMsg, getCurrentProfileMsg, requestAddFriendMsg;
  final ResRequestAddFriend? resRequestAddFriend;

  const ProfileState(
      {required this.getUserStatus,
      required this.pageProfileStatus,
      required this.getCurrentProfileStatus,
      required this.requestAddFriendStatus,
      this.user,
      this.getUserMsg,
      this.currentProfile,
      this.getCurrentProfileMsg,
      this.requestAddFriendMsg,
      this.resRequestAddFriend});

  factory ProfileState.initialize() {
    return const ProfileState(
      getUserStatus: LoadingStatus.initialize,
      getCurrentProfileStatus: LoadingStatus.initialize,
      pageProfileStatus: EPageProfileStatus.init,
      requestAddFriendStatus: LoadingStatus.initialize,
    );
  }

  ProfileState copyWith({
    LoadingStatus? getUserStatus,
    EPageProfileStatus? pageProfileStatus,
    User? user,
    User? currentProfile,
    String? getUserMsg,
    String? getCurrentProfileMsg,
    LoadingStatus? getCurrentProfileStatus,
    LoadingStatus? requestAddFriendStatus,
    String? requestAddFriendMsg,
    ResRequestAddFriend? resRequestAddFriend,
  }) {
    return ProfileState(
      getUserStatus: getUserStatus ?? this.getUserStatus,
      pageProfileStatus: pageProfileStatus ?? this.pageProfileStatus,
      user: user ?? this.user,
      currentProfile: currentProfile ?? this.currentProfile,
      getUserMsg: getUserMsg ?? this.getUserMsg,
      getCurrentProfileStatus:
          getCurrentProfileStatus ?? this.getCurrentProfileStatus,
      getCurrentProfileMsg: getCurrentProfileMsg ?? this.getCurrentProfileMsg,
      requestAddFriendStatus:
          requestAddFriendStatus ?? this.requestAddFriendStatus,
      requestAddFriendMsg: requestAddFriendMsg ?? this.requestAddFriendMsg,
      resRequestAddFriend: resRequestAddFriend ?? this.resRequestAddFriend,
    );
  }

  @override
  List<Object?> get props => [
        getUserStatus,
        pageProfileStatus,
        user,
        getUserMsg,
        currentProfile,
        getCurrentProfileStatus,
        getCurrentProfileMsg,
        requestAddFriendStatus,
        requestAddFriendMsg,
        resRequestAddFriend,
      ];
}

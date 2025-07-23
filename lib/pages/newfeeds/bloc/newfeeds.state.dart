part of 'newfeeds.bloc.dart';

class NewfeedsState extends Equatable {
  final ENewFeeds newfeedsStatus;
  final LoadingStatus searchUsersStatus;
  final List<User>? users;
  final User? selectedUser;
  final String? getUserMsg;
  const NewfeedsState(
      {required this.newfeedsStatus,
      this.searchUsersStatus = LoadingStatus.initialize,
      this.users,
      this.selectedUser,
      this.getUserMsg});

  factory NewfeedsState.initialize() {
    return const NewfeedsState(
      newfeedsStatus: ENewFeeds.init,
    );
  }

  NewfeedsState copyWith(
      {ENewFeeds? newfeedsStatus,
      LoadingStatus? searchUsersStatus,
      List<User>? users,
      User? selectedUser,
      String? getUserMsg}) {
    return NewfeedsState(
      newfeedsStatus: newfeedsStatus ?? this.newfeedsStatus,
      searchUsersStatus: searchUsersStatus ?? this.searchUsersStatus,
      users: users ?? this.users,
      getUserMsg: getUserMsg ?? this.getUserMsg,
      selectedUser: selectedUser ?? this.selectedUser,
    );
  }

  @override
  List<Object?> get props =>
      [newfeedsStatus, searchUsersStatus, users, getUserMsg, selectedUser];
}

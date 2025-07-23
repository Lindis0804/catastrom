part of 'notifications.bloc.dart';

class NotificationsState extends Equatable {
  final LoadingStatus status, getAddFriendRequestsStatus;
  final String? getAddFriendRequetsMsg, acceptFriendMsg, rejectFriendMsg;
  final List<AddFriendRequest>? addFriendRequests;

  const NotificationsState(
      {required this.status,
      this.getAddFriendRequestsStatus = LoadingStatus.initialize,
      this.getAddFriendRequetsMsg,
      this.addFriendRequests,
      this.acceptFriendMsg,
      this.rejectFriendMsg});

  factory NotificationsState.initialize() {
    return const NotificationsState(
        status: LoadingStatus.initialize,
        getAddFriendRequestsStatus: LoadingStatus.initialize);
  }

  NotificationsState copyWith(
      {LoadingStatus? status,
      LoadingStatus? getAddFriendRequestsStatus,
      String? getAddFriendRequetsMsg,
      List<AddFriendRequest>? addFriendRequests,
      String? acceptFriendMsg,
      String? rejectFriendMsg}) {
    return NotificationsState(
        status: status ?? this.status,
        getAddFriendRequestsStatus:
            getAddFriendRequestsStatus ?? this.getAddFriendRequestsStatus,
        getAddFriendRequetsMsg:
            getAddFriendRequetsMsg ?? this.getAddFriendRequetsMsg,
        addFriendRequests: addFriendRequests,
        acceptFriendMsg: acceptFriendMsg ?? this.acceptFriendMsg,
        rejectFriendMsg: rejectFriendMsg ?? this.rejectFriendMsg);
  }

  @override
  List<Object?> get props => [
        status,
        getAddFriendRequestsStatus,
        getAddFriendRequetsMsg,
        addFriendRequests,
        acceptFriendMsg,
        rejectFriendMsg
      ];
}

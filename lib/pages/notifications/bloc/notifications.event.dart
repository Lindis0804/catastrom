part of 'notifications.bloc.dart';

sealed class NotificationsEvent {
  const NotificationsEvent();
}

class Inititalize extends NotificationsEvent {
  const Inititalize();
}

class GetAddFriendRequests extends NotificationsEvent {
  const GetAddFriendRequests();
}

class AcceptFriendEvent extends NotificationsEvent {
  final String username;
  const AcceptFriendEvent({required this.username});
}

class RejectFriendEvent extends NotificationsEvent {
  final String username;
  const RejectFriendEvent({required this.username});
}

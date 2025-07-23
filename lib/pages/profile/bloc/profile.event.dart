part of 'profile.bloc.dart';

sealed class ProfileEvent {
  const ProfileEvent();
}

class Inititalize extends ProfileEvent {
  final int? userId;
  const Inititalize({this.userId});
}

class GetUserEvent extends ProfileEvent {
  final int userId;

  const GetUserEvent({required this.userId});
}

class RequestAddFriendEvent extends ProfileEvent {
  final ReqRequestAddFriend req;

  const RequestAddFriendEvent({required this.req});
}

part of 'newfeeds.bloc.dart';

sealed class NewfeedsEvent {
  const NewfeedsEvent();
}

class Inititalize extends NewfeedsEvent {
  const Inititalize();
}

class SearchUsersEvent extends NewfeedsEvent {
  final ReqSearchUsers reqSearchUsers;

  const SearchUsersEvent(this.reqSearchUsers);
}

class ToProfileScreenEvent extends NewfeedsEvent {
  final User user;
  const ToProfileScreenEvent({required this.user});
}

class ChangeStatusEvent extends NewfeedsEvent {
  final ENewFeeds? newfeedsStatus;
  ChangeStatusEvent({this.newfeedsStatus});
}

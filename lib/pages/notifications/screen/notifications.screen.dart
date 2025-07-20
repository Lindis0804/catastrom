import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/common/utils/list.utils.dart';
import 'package:template/common/utils/log.dart';
import 'package:template/common/utils/string.utils.dart';
import 'package:template/common/widgets/custom_add_friend_request_item.dart';
import 'package:template/common/widgets/custom_list_separator.dart';
import 'package:template/pages/notifications/bloc/notifications.bloc.dart';

class NotificationsBlocBuilder extends StatefulWidget {
  final NotificationsBloc notificationsBloc;
  const NotificationsBlocBuilder({super.key, required this.notificationsBloc});

  @override
  State<NotificationsBlocBuilder> createState() =>
      _NotificationsBlocBuilderState();
}

class _NotificationsBlocBuilderState extends State<NotificationsBlocBuilder> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.notificationsBloc.add(const Inititalize());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationsBloc, NotificationsState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: ListUtils.isNullOrEmpty(state.addFriendRequests)
                ? const Center(child: Text('Không có lời mời kết bạn nào'))
                : // Replace with actual widget to display notifications
                ListView.separated(
                    itemBuilder: (context, index) => CustomAddFriendRequestItem(
                          addFriendRequest: state.addFriendRequests![index],
                          onAccept: () {
                            String username =
                                state.addFriendRequests![index].username;
                            widget.notificationsBloc.add(
                              AcceptFriendEvent(username: username),
                            );
                          },
                          onReject: () {
                            String username =
                                state.addFriendRequests![index].username;
                            widget.notificationsBloc.add(
                              RejectFriendEvent(username: username),
                            );
                          },
                        ),
                    separatorBuilder: (context, index) =>
                        const CustomListSeparator(),
                    itemCount: state.addFriendRequests!.length),
          ),
        );
      },
    );
  }
}

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});
  @override
  Widget build(BuildContext context) => BlocProvider<NotificationsBloc>(
        create: (_) => NotificationsBloc(),
        child: BlocListener<NotificationsBloc, NotificationsState>(
          listener: _listener,
          child: Builder(
            builder: (BuildContext context) => NotificationsBlocBuilder(
              notificationsBloc: context.read<NotificationsBloc>(),
            ),
          ),
        ),
      );
}

void _listener(BuildContext context, NotificationsState state) {
  String? acceptFriendMsg = state.acceptFriendMsg,
      rejectFriendMsg = state.rejectFriendMsg;
  if (!StringUtils.isNullOrEmpty(acceptFriendMsg)) {
    showToast(context: context, message: acceptFriendMsg!);
  }
  if (!StringUtils.isNullOrEmpty(rejectFriendMsg)) {
    showToast(context: context, message: rejectFriendMsg!);
  }
}

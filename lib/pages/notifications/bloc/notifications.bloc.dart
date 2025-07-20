import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/api/user/dto/acceptFriend/ReqAcceptFriend.dart';
import 'package:template/api/user/dto/acceptFriend/ResAcceptFriend.dart';
import 'package:template/api/user/dto/getAddFriendRequests/ReqGetAddFriendRequests.dart';
import 'package:template/api/user/dto/getAddFriendRequests/ResGetAddFriendRequests.dart';
import 'package:template/api/user/dto/rejectFriend/ReqRejectFriend.dart';
import 'package:template/api/user/dto/rejectFriend/ResRejectFriend.dart';
import 'package:template/api/user/provider.dart';
import 'package:template/common/enums/loading_status.enum.dart';
import 'package:template/common/utils/share_preferences.dart';

part 'notifications.event.dart';
part 'notifications.state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  NotificationsBloc() : super(NotificationsState.initialize()) {
    on<Inititalize>(_onInitialize);
    on<GetAddFriendRequests>(_onGetAddFriendRequests);
    on<AcceptFriendEvent>(_onAcceptFriend);
    on<RejectFriendEvent>(_onRejectFriend);
  }

  void _onInitialize(
    Inititalize event,
    Emitter<NotificationsState> emitter,
  ) async {
    emitter(
      state.copyWith(getAddFriendRequestsStatus: LoadingStatus.loading),
    );
    try {
      String accessToken = await SharedPreferencesManager.getAccessToken();
      UserApiProvider userApiProvider =
          UserApiProvider(accessToken: accessToken);
      // Assuming we got some data from the API
      ReqGetAddFriendRequests reqGetAddFriendRequests =
          ReqGetAddFriendRequests(); // Replace with actual request data
      List<AddFriendRequest>? addFriendRequests = (await userApiProvider
              .getAddFriendRequests(req: reqGetAddFriendRequests))
          .requests; // Replace with actual data; // Replace with actual data
      emitter(
        state.copyWith(
          getAddFriendRequestsStatus: LoadingStatus.loaded,
          addFriendRequests: addFriendRequests,
        ),
      );
    } catch (e) {
      emitter(
        state.copyWith(
          getAddFriendRequestsStatus: LoadingStatus.error,
          getAddFriendRequetsMsg: e.toString(),
        ),
      );
    }
  }

  void _onGetAddFriendRequests(
    NotificationsEvent event,
    Emitter<NotificationsState> emitter,
  ) async {}

  void _onAcceptFriend(
    AcceptFriendEvent event,
    Emitter<NotificationsState> emitter,
  ) async {
    try {
      String username = event.username;
      String accessToken = await SharedPreferencesManager.getAccessToken();
      UserApiProvider userApiProvider =
          UserApiProvider(accessToken: accessToken);
      ReqAcceptFriend req = ReqAcceptFriend(username: username);
      ResAcceptFriend res = await userApiProvider.acceptFriend(req: req);
      state.addFriendRequests?.removeWhere((item) => item.username == username);
      emitter(
        state.copyWith(
            addFriendRequests: state.addFriendRequests,
            acceptFriendMsg: 'Đã chấp nhận yêu cầu'),
      );
    } catch (e) {
      emitter(
        state.copyWith(
            addFriendRequests: state.addFriendRequests,
            acceptFriendMsg: 'Chấp nhận yêu cầu thất bại: $e'),
      );
    }
  }

  void _onRejectFriend(
    RejectFriendEvent event,
    Emitter<NotificationsState> emitter,
  ) async {
    try {
      String username = event.username;
      String accessToken = await SharedPreferencesManager.getAccessToken();
      UserApiProvider userApiProvider =
          UserApiProvider(accessToken: accessToken);
      ReqRejectFriend req = ReqRejectFriend(username: username);
      ResRejectFriend res = await userApiProvider.rejectFriend(req: req);
      state.addFriendRequests?.removeWhere((item) => item.username == username);
      emitter(
        state.copyWith(
            addFriendRequests: state.addFriendRequests,
            acceptFriendMsg: 'Đã từ chối yêu cầu'),
      );
    } catch (e) {
      emitter(
        state.copyWith(
            addFriendRequests: state.addFriendRequests,
            acceptFriendMsg: 'Từ chối yêu cầu thất bại: $e'),
      );
    }
  }
}

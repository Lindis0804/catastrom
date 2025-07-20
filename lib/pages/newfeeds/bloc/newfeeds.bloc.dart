import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/api/user/dto/searchUsers/ReqSearchUsers.dart';
import 'package:template/api/user/dto/searchUsers/ResSearchUsers.dart';
import 'package:template/api/user/provider.dart';
import 'package:template/common/enums/loading_status.enum.dart';
import 'package:template/common/enums/newfeeds.enum.dart';
import 'package:template/common/utils/share_preferences.dart';
import 'package:template/data/models/user/user.model.dart';

part 'newfeeds.event.dart';
part 'newfeeds.state.dart';

class NewfeedsBloc extends Bloc<NewfeedsEvent, NewfeedsState> {
  NewfeedsBloc() : super(NewfeedsState.initialize()) {
    on<Inititalize>(_onInitialize);
    on<SearchUsersEvent>(_onSearchUsers);
    on<ToProfileScreenEvent>(_onToProfileScreen);
    on<ChangeStatusEvent>(_onChangeStatus);
    add(
      const Inititalize(),
    );
  }

  void _onInitialize(
    NewfeedsEvent event,
    Emitter<NewfeedsState> emitter,
  ) async {
    if (event is! Inititalize) {
      return;
    }
  }

  void _onSearchUsers(
    SearchUsersEvent event,
    Emitter<NewfeedsState> emitter,
  ) async {
    try {
      String accessToken = await SharedPreferencesManager.getAccessToken();
      UserApiProvider userApiProvider =
          UserApiProvider(accessToken: accessToken);
      emitter(state.copyWith(searchUsersStatus: LoadingStatus.loading));
      ResSearchUsers resSearchUsers =
          await userApiProvider.searchUsers(req: event.reqSearchUsers);
      List<User>? users = resSearchUsers.users;
      emitter(
        state.copyWith(
          users: users,
          searchUsersStatus: LoadingStatus.loaded,
        ),
      );
    } catch (e) {
      emitter(
        state.copyWith(
          searchUsersStatus: LoadingStatus.error,
          getUserMsg: e.toString(),
        ),
      );
    }
  }

  void _onToProfileScreen(
    ToProfileScreenEvent event,
    Emitter<NewfeedsState> emitter,
  ) async {
    User selectedUser = event.user;
    emitter(
      state.copyWith(
        newfeedsStatus: ENewFeeds.toProfileScreen,
        selectedUser: selectedUser,
      ),
    );
    return;
  }

  void _onChangeStatus(
    ChangeStatusEvent event,
    Emitter<NewfeedsState> emitter,
  ) {
    ENewFeeds? newFeedsStatus = event.newfeedsStatus;
    emitter(
      state.copyWith(newfeedsStatus: newFeedsStatus),
    );
  }
}

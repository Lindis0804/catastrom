import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/api/user/dto/addFriend/ReqAddFriend.dart';
import 'package:template/api/user/dto/addFriend/ResAddFriend.dart';
import 'package:template/api/user/provider.dart';
import 'package:template/common/enums/loading_status.enum.dart';
import 'package:template/common/enums/profile.enum.dart';
import 'package:template/common/utils/share_preferences.dart';
import 'package:template/data/models/user/user.model.dart';

part 'profile.event.dart';
part 'profile.state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileState.initialize()) {
    on<Inititalize>(_onInitialize);
    on<RequestAddFriendEvent>(_onRequestAddFriend);
    add(
      const Inititalize(),
    );
  }

  void _onInitialize(
    Inititalize event,
    Emitter<ProfileState> emitter,
  ) async {
    int? userId = event.userId;
    emitter(
      state.copyWith(
        getUserStatus: LoadingStatus.loading,
      ),
    );
    User? user, currentProfile;
    try {
      currentProfile = await SharedPreferencesManager.getUser();
    } catch (e) {
      emitter(
        state.copyWith(
          getCurrentProfileStatus: LoadingStatus.error,
          getCurrentProfileMsg: e.toString(),
        ),
      );
      return;
    }

    try {
      if (userId == null) {
        user = currentProfile;
      } else {
        String accessToken = await SharedPreferencesManager.getAccessToken();
        user = await UserApiProvider(accessToken: accessToken)
            .getUser(userId: userId);
      }
      emitter(
        state.copyWith(
            getUserStatus: LoadingStatus.loaded,
            getCurrentProfileStatus: LoadingStatus.loaded,
            user: user,
            currentProfile: currentProfile),
      );
    } catch (e) {
      emitter(
        state.copyWith(
          getUserStatus: LoadingStatus.error,
          getUserMsg: e.toString(),
        ),
      );
      return;
    }
  }

  void _onRequestAddFriend(
    RequestAddFriendEvent event,
    Emitter<ProfileState> emitter,
  ) async {
    try {
      String accessToken = await SharedPreferencesManager.getAccessToken();
      UserApiProvider userApiProvider =
          UserApiProvider(accessToken: accessToken);
      emitter(
        state.copyWith(requestAddFriendStatus: LoadingStatus.loading),
      );
      ResRequestAddFriend resRequestAddFriend =
          await userApiProvider.requestAddFriend(req: event.req);
      emitter(
        state.copyWith(
          requestAddFriendStatus: LoadingStatus.loaded,
          resRequestAddFriend: resRequestAddFriend,
        ),
      );
    } catch (e) {
      emitter(
        state.copyWith(
          requestAddFriendStatus: LoadingStatus.error,
          requestAddFriendMsg: e.toString(),
        ),
      );
      return;
    }
  }
}

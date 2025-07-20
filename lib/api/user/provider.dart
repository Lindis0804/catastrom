import 'package:template/api/user/dto/acceptFriend/ReqAcceptFriend.dart';
import 'package:template/api/user/dto/acceptFriend/ResAcceptFriend.dart';
import 'package:template/api/user/dto/addFriend/ReqAddFriend.dart';
import 'package:template/api/user/dto/addFriend/ResAddFriend.dart';
import 'package:template/api/user/dto/getAddFriendRequests/ReqGetAddFriendRequests.dart';
import 'package:template/api/user/dto/getAddFriendRequests/ResGetAddFriendRequests.dart';
import 'package:template/api/user/dto/rejectFriend/ReqRejectFriend.dart';
import 'package:template/api/user/dto/rejectFriend/ResRejectFriend.dart';
import 'package:template/api/user/dto/searchUsers/ReqSearchUsers.dart';
import 'package:template/api/user/dto/searchUsers/ResSearchUsers.dart';
import 'package:template/common/utils/dio.utils.dart';
import 'package:dio/dio.dart';
import 'package:template/common/utils/env.dart';
import 'package:template/data/models/user/user.model.dart';

class UserApiProvider {
  String accessToken;
  late Dio dio;

  UserApiProvider({required this.accessToken}) {
    dio = DioUtils.getDioClient(accessToken: accessToken);
  }

  Future<User> getUser({required int userId}) async {
    Response res = await dio.get(
      '${EnvVariable.clientCustomerHost}/api/v1/user/$userId',
    );
    if (res.statusCode != 200) {
      throw Exception('Get user profile failed');
    }
    User user = User.fromJson(res.data['data']);

    return user;
  }

  Future<ResSearchUsers> searchUsers({required ReqSearchUsers req}) async {
    int? pageIdx = req.pageable?.page;
    int? pageSize = req.pageable?.size;
    Response res = await dio.get(
      '${EnvVariable.clientCustomerHost}/api/v1/user/search',
      queryParameters: {
        'id': req.id,
        'username': req.username,
        'page': pageIdx,
        'size': pageSize,
      },
    );
    if (res.statusCode != 200) {
      throw Exception('Search users failed');
    }
    ResSearchUsers resSearchUsers =
        ResSearchUsers.fromJson(res.data['data'] as Map<String, dynamic>);
    return resSearchUsers;
  }

  Future<ResRequestAddFriend> requestAddFriend({
    required ReqRequestAddFriend req,
  }) async {
    ResRequestAddFriend res;
    Response response = await dio.post(
      '${EnvVariable.clientCustomerHost}/api/v1/user/add-friend',
      data: req.toJson(),
    );
    if (response.statusCode != 200) {
      throw Exception('Request add friend failed');
    }
    res = ResRequestAddFriend.fromJson(response.data['data']);
    return res;
  }

  Future<ResGetAddFriendRequests> getAddFriendRequests({
    required ReqGetAddFriendRequests req,
  }) async {
    Response response = await dio.get(
      '${EnvVariable.clientCustomerHost}/api/v1/user/get-all-friend-request',
    );
    if (response.statusCode != 200) {
      throw Exception('Get add friend requests failed');
    }
    List<dynamic> rawAddFriendRequests = response.data['data'];
    List<AddFriendRequest> requests = List.generate(
      rawAddFriendRequests.length,
      (index) => AddFriendRequest.fromJson(
        rawAddFriendRequests[index] as Map<String, dynamic>,
      ),
    );
    return ResGetAddFriendRequests(requests: requests);
  }

  Future<ResAcceptFriend> acceptFriend({
    required ReqAcceptFriend req,
  }) async {
    Response response = await dio.post(
        '${EnvVariable.clientCustomerHost}/api/v1/user/accept-friend',
        data: req.toJson());
    if (response.statusCode != 200) {
      throw Exception('Accept friend request failed');
    }
    ResAcceptFriend res = ResAcceptFriend.fromJson(response.data['data']);
    return res;
  }

  Future<ResRejectFriend> rejectFriend({
    required ReqRejectFriend req,
  }) async {
    Response response = await dio.post(
        '${EnvVariable.clientCustomerHost}/api/v1/user/reject-friend',
        data: req.toJson());
    if (response.statusCode != 200) {
      throw Exception('Reject friend request failed');
    }
    ResRejectFriend res = ResRejectFriend.fromJson(response.data['data']);
    return res;
  }
}

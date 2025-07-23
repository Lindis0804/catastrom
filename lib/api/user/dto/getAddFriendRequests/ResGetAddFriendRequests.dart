import 'package:json_annotation/json_annotation.dart' as j;
part 'ResGetAddFriendRequests.g.dart';

@j.JsonSerializable()
class AddFriendRequest {
  @j.JsonKey(name: 'id')
  final int userId;
  final String username;
  final String? firstname;
  final String? lastname;
  final String? phoneNumber;

  AddFriendRequest({
    required this.userId,
    required this.username,
    this.firstname,
    this.lastname,
    this.phoneNumber,
  });
  factory AddFriendRequest.fromJson(Map<String, dynamic> json) =>
      _$AddFriendRequestFromJson(json);
  Map<String, dynamic> toJson() => _$AddFriendRequestToJson(this);
}

@j.JsonSerializable()
class ResGetAddFriendRequests {
  final List<AddFriendRequest>? requests;
  ResGetAddFriendRequests({
    this.requests,
  });
}

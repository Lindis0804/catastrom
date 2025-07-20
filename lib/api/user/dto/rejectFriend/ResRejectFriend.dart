import 'package:template/api/user/dto/addFriend/ResAddFriend.dart';
import 'package:json_annotation/json_annotation.dart' as j;
import 'package:template/data/models/user/user.model.dart';
part 'ResRejectFriend.g.dart';

@j.JsonSerializable()
class ResRejectFriend extends ResRequestAddFriend {
  ResRejectFriend(
      {required super.fromUser, required super.toUser, required super.status});

  factory ResRejectFriend.fromJson(Map<String, dynamic> json) =>
      _$ResRejectFriendFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ResRejectFriendToJson(this);
}

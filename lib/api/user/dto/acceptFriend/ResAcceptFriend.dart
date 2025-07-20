import 'package:template/api/user/dto/addFriend/ResAddFriend.dart';
import 'package:json_annotation/json_annotation.dart' as j;
import 'package:template/data/models/user/user.model.dart';
part 'ResAcceptFriend.g.dart';

@j.JsonSerializable()
class ResAcceptFriend extends ResRequestAddFriend {
  ResAcceptFriend(
      {required super.status, required super.fromUser, required super.toUser});

  factory ResAcceptFriend.fromJson(Map<String, dynamic> json) =>
      _$ResAcceptFriendFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ResAcceptFriendToJson(this);
}

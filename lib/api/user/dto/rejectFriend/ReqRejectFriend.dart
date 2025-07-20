import 'package:template/api/user/dto/addFriend/ReqAddFriend.dart';
import 'package:json_annotation/json_annotation.dart' as j;

part 'ReqRejectFriend.g.dart';

@j.JsonSerializable()
class ReqRejectFriend extends ReqRequestAddFriend {
  ReqRejectFriend({required super.username});

  @override
  Map<String, dynamic> toJson() => _$ReqRejectFriendToJson(this);
}

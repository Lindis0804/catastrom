import 'package:template/api/user/dto/addFriend/ReqAddFriend.dart';
import 'package:json_annotation/json_annotation.dart' as j;
part 'ReqAcceptFriend.g.dart';

@j.JsonSerializable()
class ReqAcceptFriend extends ReqRequestAddFriend {
  ReqAcceptFriend({required super.username});

  @override
  Map<String, dynamic> toJson() => _$ReqAcceptFriendToJson(this);
}

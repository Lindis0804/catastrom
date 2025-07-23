import 'package:template/data/models/user/user.model.dart';
import 'package:json_annotation/json_annotation.dart' as j;
part 'ResAddFriend.g.dart';

@j.JsonSerializable()
class ResRequestAddFriend {
  @j.JsonKey(name: 'firstUser')
  final User fromUser;

  @j.JsonKey(name: 'secondUser')
  final User toUser;

  @j.JsonKey(name: 'status')
  final String status;

  ResRequestAddFriend({
    required this.fromUser,
    required this.toUser,
    required this.status,
  });

  factory ResRequestAddFriend.fromJson(Map<String, dynamic> json) =>
      _$ResRequestAddFriendFromJson(json);

  Map<String, dynamic> toJson() => _$ResRequestAddFriendToJson(this);
}

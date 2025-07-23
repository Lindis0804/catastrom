import 'package:json_annotation/json_annotation.dart' as j;
part 'ReqAddFriend.g.dart';

@j.JsonSerializable()
class ReqRequestAddFriend {
  final String username;
  const ReqRequestAddFriend({
    required this.username,
  });

  Map<String, dynamic> toJson() => _$ReqRequestAddFriendToJson(this);
}

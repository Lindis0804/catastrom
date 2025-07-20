import 'package:json_annotation/json_annotation.dart' as j;
import 'package:template/data/models/user/user.model.dart';
part 'ResSearchUsers.g.dart';

@j.JsonSerializable()
class ResSearchUsers {
  @j.JsonKey(name: 'content')
  final List<User>? users;

  ResSearchUsers({this.users});

  factory ResSearchUsers.fromJson(Map<String, dynamic> json) =>
      _$ResSearchUsersFromJson(json);
}

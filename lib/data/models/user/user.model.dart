import 'package:drift/drift.dart';
import 'package:json_annotation/json_annotation.dart' as j;
part 'user.model.g.dart';

@j.JsonSerializable()
class User {
  @j.JsonKey(name: 'id')
  int? id;

  @j.JsonKey(name: 'firstName')
  String? firstName;

  @j.JsonKey(name: 'lastName')
  String? lastName;

  @j.JsonKey(name: 'email')
  String? email;

  @j.JsonKey(name: 'phone')
  String? phone;

  @j.JsonKey(name: 'username')
  String? username;

  @j.JsonKey(name: 'avatarUrl')
  String? avatarUrl;

  String? cover;
  User({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.username,
    this.avatarUrl,
    this.cover,
  });
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

import 'package:drift/drift.dart';
import 'package:json_annotation/json_annotation.dart' as j;
part 'user.model.g.dart';

@j.JsonSerializable()
class User {
  @j.JsonKey(name: 'id')
  int? id;

  @j.JsonKey(name: 'firstname')
  String? firstName;

  @j.JsonKey(name: 'lastname')
  String? lastName;

  @j.JsonKey(name: 'phoneNumber')
  String? phone;

  @j.JsonKey(name: 'username')
  String? username;

  String? avatar, cover;
  User({
    this.id,
    this.firstName,
    this.lastName,
    this.phone,
    this.username,
    this.avatar,
    this.cover,
  });
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

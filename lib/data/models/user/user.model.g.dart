// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: (json['id'] as num?)?.toInt(),
      firstName: json['firstname'] as String?,
      lastName: json['lastname'] as String?,
      phone: json['phoneNumber'] as String?,
      username: json['username'] as String?,
      avatar: json['avatar'] as String?,
      cover: json['cover'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'firstname': instance.firstName,
      'lastname': instance.lastName,
      'phoneNumber': instance.phone,
      'username': instance.username,
      'avatar': instance.avatar,
      'cover': instance.cover,
    };

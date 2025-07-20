// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ResSearchUsers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResSearchUsers _$ResSearchUsersFromJson(Map<String, dynamic> json) =>
    ResSearchUsers(
      users: (json['content'] as List<dynamic>?)
          ?.map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResSearchUsersToJson(ResSearchUsers instance) =>
    <String, dynamic>{
      'content': instance.users,
    };

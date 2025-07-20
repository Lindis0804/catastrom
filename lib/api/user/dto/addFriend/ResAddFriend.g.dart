// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ResAddFriend.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResRequestAddFriend _$ResRequestAddFriendFromJson(Map<String, dynamic> json) =>
    ResRequestAddFriend(
      fromUser: User.fromJson(json['firstUser'] as Map<String, dynamic>),
      toUser: User.fromJson(json['secondUser'] as Map<String, dynamic>),
      status: json['status'] as String,
    );

Map<String, dynamic> _$ResRequestAddFriendToJson(
        ResRequestAddFriend instance) =>
    <String, dynamic>{
      'firstUser': instance.fromUser,
      'secondUser': instance.toUser,
      'status': instance.status,
    };

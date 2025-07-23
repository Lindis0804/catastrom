// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ResRejectFriend.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResRejectFriend _$ResRejectFriendFromJson(Map<String, dynamic> json) =>
    ResRejectFriend(
      fromUser: User.fromJson(json['firstUser'] as Map<String, dynamic>),
      toUser: User.fromJson(json['secondUser'] as Map<String, dynamic>),
      status: json['status'] as String,
    );

Map<String, dynamic> _$ResRejectFriendToJson(ResRejectFriend instance) =>
    <String, dynamic>{
      'firstUser': instance.fromUser,
      'secondUser': instance.toUser,
      'status': instance.status,
    };

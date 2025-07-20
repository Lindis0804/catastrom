// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ResAcceptFriend.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResAcceptFriend _$ResAcceptFriendFromJson(Map<String, dynamic> json) =>
    ResAcceptFriend(
      status: json['status'] as String,
      fromUser: User.fromJson(json['firstUser'] as Map<String, dynamic>),
      toUser: User.fromJson(json['secondUser'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ResAcceptFriendToJson(ResAcceptFriend instance) =>
    <String, dynamic>{
      'firstUser': instance.fromUser,
      'secondUser': instance.toUser,
      'status': instance.status,
    };

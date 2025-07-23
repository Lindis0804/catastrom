// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ResGetAddFriendRequests.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddFriendRequest _$AddFriendRequestFromJson(Map<String, dynamic> json) =>
    AddFriendRequest(
      userId: (json['id'] as num).toInt(),
      username: json['username'] as String,
      firstname: json['firstname'] as String?,
      lastname: json['lastname'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
    );

Map<String, dynamic> _$AddFriendRequestToJson(AddFriendRequest instance) =>
    <String, dynamic>{
      'id': instance.userId,
      'username': instance.username,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'phoneNumber': instance.phoneNumber,
    };

ResGetAddFriendRequests _$ResGetAddFriendRequestsFromJson(
        Map<String, dynamic> json) =>
    ResGetAddFriendRequests(
      requests: (json['requests'] as List<dynamic>?)
          ?.map((e) => AddFriendRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResGetAddFriendRequestsToJson(
        ResGetAddFriendRequests instance) =>
    <String, dynamic>{
      'requests': instance.requests,
    };

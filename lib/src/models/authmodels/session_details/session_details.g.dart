// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SessionDetails _$SessionDetailsFromJson(Map<String, dynamic> json) =>
    SessionDetails(
      id: json['_id'] as String,
      userId: json['user_id'] as String,
      sessionToken: json['token'] as String,
      deviceName: json['name'] as String,
      webPushSubscription: json['subscription'] as String?,
    );

Map<String, dynamic> _$SessionDetailsToJson(SessionDetails instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'user_id': instance.userId,
      'token': instance.sessionToken,
      'name': instance.deviceName,
      'subscription': instance.webPushSubscription,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ws_events.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthenticateEvent _$AuthenticateEventFromJson(Map<String, dynamic> json) =>
    AuthenticateEvent(
      token: json['token'] as String,
    );

Map<String, dynamic> _$AuthenticateEventToJson(AuthenticateEvent instance) =>
    <String, dynamic>{
      'token': instance.token,
    };

AuthenticatedEvent _$AuthenticatedEventFromJson(Map<String, dynamic> json) =>
    AuthenticatedEvent();

Map<String, dynamic> _$AuthenticatedEventToJson(AuthenticatedEvent instance) =>
    <String, dynamic>{};

MessageEvent _$MessageEventFromJson(Map<String, dynamic> json) => MessageEvent(
      Message.fromJson(MessageEvent._passDownToParseMessage(json, 'message')
          as Map<String, dynamic>),
    );

Map<String, dynamic> _$MessageEventToJson(MessageEvent instance) =>
    <String, dynamic>{
      'message': instance.message,
    };

ReadyEvent _$ReadyEventFromJson(Map<String, dynamic> json) => ReadyEvent(
      (json['users'] as List<dynamic>)
          .map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['channels'] as List<dynamic>)
          .map((e) => Channel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReadyEventToJson(ReadyEvent instance) =>
    <String, dynamic>{
      'users': instance.users,
      'channels': instance.channels,
    };

UserRelationShipEvent _$UserRelationShipEventFromJson(
        Map<String, dynamic> json) =>
    UserRelationShipEvent(
      json['id'] as String,
      RelationUser.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserRelationShipEventToJson(
        UserRelationShipEvent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
    };

ChannelCreateEvent _$ChannelCreateEventFromJson(Map<String, dynamic> json) =>
    ChannelCreateEvent(
      Channel.fromJson(ChannelCreateEvent._passDownToParse(json, 'channel')
          as Map<String, dynamic>),
    );

Map<String, dynamic> _$ChannelCreateEventToJson(ChannelCreateEvent instance) =>
    <String, dynamic>{
      'channel': instance.channel,
    };

UnknownEvent _$UnknownEventFromJson(Map<String, dynamic> json) => UnknownEvent(
      type: json['type'] as String,
    );

Map<String, dynamic> _$UnknownEventToJson(UnknownEvent instance) =>
    <String, dynamic>{
      'type': instance.type,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      id: json['_id'] as String,
      nonce: json['nonce'] as String,
      channel: json['channel'] as String,
      author: json['author'] as String,
      content: json['content'] as String,
      user: json['user'] == null
          ? null
          : RelationUser.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      '_id': instance.id,
      'nonce': instance.nonce,
      'channel': instance.channel,
      'author': instance.author,
      'content': instance.content,
      'user': instance.user,
    };

// To parse this JSON data, do
//
//     final channel = channelFromJson(jsonString);

import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'channel.g.dart';

enum ChannelType {
  @JsonValue('DirectMessage')
  directMessage,
  unknown
}
@CopyWith()
@JsonSerializable()
class Channel {

  Channel({
    required this.channelType,
    required this.id,
    required this.active,
    required this.recipients,
    required this.lastMessageId,
  });

  factory Channel.fromJson(Map<String, dynamic> json) =>
      _$ChannelFromJson(json);
  @JsonKey(name: 'channel_type',unknownEnumValue: ChannelType.unknown)
  ChannelType channelType;
  @JsonKey(name: '_id')
  String id;
  @JsonKey(name: 'active')
  bool active;
  @JsonKey(name: 'recipients')
  List<String> recipients;
  @JsonKey(name: 'last_message_id')
  String? lastMessageId;

  Map<String, dynamic> toJson() => _$ChannelToJson(this);
}

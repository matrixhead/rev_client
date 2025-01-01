// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ChannelCWProxy {
  Channel channelType(ChannelType channelType);

  Channel id(String id);

  Channel active(bool active);

  Channel recipients(List<String> recipients);

  Channel lastMessageId(String? lastMessageId);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Channel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Channel(...).copyWith(id: 12, name: "My name")
  /// ````
  Channel call({
    ChannelType? channelType,
    String? id,
    bool? active,
    List<String>? recipients,
    String? lastMessageId,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfChannel.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfChannel.copyWith.fieldName(...)`
class _$ChannelCWProxyImpl implements _$ChannelCWProxy {
  const _$ChannelCWProxyImpl(this._value);

  final Channel _value;

  @override
  Channel channelType(ChannelType channelType) =>
      this(channelType: channelType);

  @override
  Channel id(String id) => this(id: id);

  @override
  Channel active(bool active) => this(active: active);

  @override
  Channel recipients(List<String> recipients) => this(recipients: recipients);

  @override
  Channel lastMessageId(String? lastMessageId) =>
      this(lastMessageId: lastMessageId);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Channel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Channel(...).copyWith(id: 12, name: "My name")
  /// ````
  Channel call({
    Object? channelType = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? active = const $CopyWithPlaceholder(),
    Object? recipients = const $CopyWithPlaceholder(),
    Object? lastMessageId = const $CopyWithPlaceholder(),
  }) {
    return Channel(
      channelType:
          channelType == const $CopyWithPlaceholder() || channelType == null
              ? _value.channelType
              // ignore: cast_nullable_to_non_nullable
              : channelType as ChannelType,
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      active: active == const $CopyWithPlaceholder() || active == null
          ? _value.active
          // ignore: cast_nullable_to_non_nullable
          : active as bool,
      recipients:
          recipients == const $CopyWithPlaceholder() || recipients == null
              ? _value.recipients
              // ignore: cast_nullable_to_non_nullable
              : recipients as List<String>,
      lastMessageId: lastMessageId == const $CopyWithPlaceholder()
          ? _value.lastMessageId
          // ignore: cast_nullable_to_non_nullable
          : lastMessageId as String?,
    );
  }
}

extension $ChannelCopyWith on Channel {
  /// Returns a callable class that can be used as follows: `instanceOfChannel.copyWith(...)` or like so:`instanceOfChannel.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ChannelCWProxy get copyWith => _$ChannelCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Channel _$ChannelFromJson(Map<String, dynamic> json) => Channel(
      channelType: $enumDecode(_$ChannelTypeEnumMap, json['channel_type'],
          unknownValue: ChannelType.unknown),
      id: json['_id'] as String,
      active: json['active'] as bool,
      recipients: (json['recipients'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      lastMessageId: json['last_message_id'] as String?,
    );

Map<String, dynamic> _$ChannelToJson(Channel instance) => <String, dynamic>{
      'channel_type': _$ChannelTypeEnumMap[instance.channelType]!,
      '_id': instance.id,
      'active': instance.active,
      'recipients': instance.recipients,
      'last_message_id': instance.lastMessageId,
    };

const _$ChannelTypeEnumMap = {
  ChannelType.directMessage: 'DirectMessage',
  ChannelType.unknown: 'unknown',
};

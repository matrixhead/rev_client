// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$RelationUserCWProxy {
  RelationUser id(String id);

  RelationUser username(String username);

  RelationUser discriminator(String discriminator);

  RelationUser online(bool online);

  RelationUser relationStatus(RelationStatus relationStatus);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RelationUser(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RelationUser(...).copyWith(id: 12, name: "My name")
  /// ````
  RelationUser call({
    String? id,
    String? username,
    String? discriminator,
    bool? online,
    RelationStatus? relationStatus,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfRelationUser.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfRelationUser.copyWith.fieldName(...)`
class _$RelationUserCWProxyImpl implements _$RelationUserCWProxy {
  const _$RelationUserCWProxyImpl(this._value);

  final RelationUser _value;

  @override
  RelationUser id(String id) => this(id: id);

  @override
  RelationUser username(String username) => this(username: username);

  @override
  RelationUser discriminator(String discriminator) =>
      this(discriminator: discriminator);

  @override
  RelationUser online(bool online) => this(online: online);

  @override
  RelationUser relationStatus(RelationStatus relationStatus) =>
      this(relationStatus: relationStatus);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RelationUser(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RelationUser(...).copyWith(id: 12, name: "My name")
  /// ````
  RelationUser call({
    Object? id = const $CopyWithPlaceholder(),
    Object? username = const $CopyWithPlaceholder(),
    Object? discriminator = const $CopyWithPlaceholder(),
    Object? online = const $CopyWithPlaceholder(),
    Object? relationStatus = const $CopyWithPlaceholder(),
  }) {
    return RelationUser(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      username: username == const $CopyWithPlaceholder() || username == null
          ? _value.username
          // ignore: cast_nullable_to_non_nullable
          : username as String,
      discriminator:
          discriminator == const $CopyWithPlaceholder() || discriminator == null
              ? _value.discriminator
              // ignore: cast_nullable_to_non_nullable
              : discriminator as String,
      online: online == const $CopyWithPlaceholder() || online == null
          ? _value.online
          // ignore: cast_nullable_to_non_nullable
          : online as bool,
      relationStatus: relationStatus == const $CopyWithPlaceholder() ||
              relationStatus == null
          ? _value.relationStatus
          // ignore: cast_nullable_to_non_nullable
          : relationStatus as RelationStatus,
    );
  }
}

extension $RelationUserCopyWith on RelationUser {
  /// Returns a callable class that can be used as follows: `instanceOfRelationUser.copyWith(...)` or like so:`instanceOfRelationUser.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RelationUserCWProxy get copyWith => _$RelationUserCWProxyImpl(this);
}

abstract class _$CurrentUserCWProxy {
  CurrentUser id(String id);

  CurrentUser username(String username);

  CurrentUser discriminator(String discriminator);

  CurrentUser online(bool online);

  CurrentUser relations(List<Relation>? relations);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CurrentUser(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CurrentUser(...).copyWith(id: 12, name: "My name")
  /// ````
  CurrentUser call({
    String? id,
    String? username,
    String? discriminator,
    bool? online,
    List<Relation>? relations,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCurrentUser.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCurrentUser.copyWith.fieldName(...)`
class _$CurrentUserCWProxyImpl implements _$CurrentUserCWProxy {
  const _$CurrentUserCWProxyImpl(this._value);

  final CurrentUser _value;

  @override
  CurrentUser id(String id) => this(id: id);

  @override
  CurrentUser username(String username) => this(username: username);

  @override
  CurrentUser discriminator(String discriminator) =>
      this(discriminator: discriminator);

  @override
  CurrentUser online(bool online) => this(online: online);

  @override
  CurrentUser relations(List<Relation>? relations) =>
      this(relations: relations);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CurrentUser(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CurrentUser(...).copyWith(id: 12, name: "My name")
  /// ````
  CurrentUser call({
    Object? id = const $CopyWithPlaceholder(),
    Object? username = const $CopyWithPlaceholder(),
    Object? discriminator = const $CopyWithPlaceholder(),
    Object? online = const $CopyWithPlaceholder(),
    Object? relations = const $CopyWithPlaceholder(),
  }) {
    return CurrentUser(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      username: username == const $CopyWithPlaceholder() || username == null
          ? _value.username
          // ignore: cast_nullable_to_non_nullable
          : username as String,
      discriminator:
          discriminator == const $CopyWithPlaceholder() || discriminator == null
              ? _value.discriminator
              // ignore: cast_nullable_to_non_nullable
              : discriminator as String,
      online: online == const $CopyWithPlaceholder() || online == null
          ? _value.online
          // ignore: cast_nullable_to_non_nullable
          : online as bool,
      relations: relations == const $CopyWithPlaceholder()
          ? _value.relations
          // ignore: cast_nullable_to_non_nullable
          : relations as List<Relation>?,
    );
  }
}

extension $CurrentUserCopyWith on CurrentUser {
  /// Returns a callable class that can be used as follows: `instanceOfCurrentUser.copyWith(...)` or like so:`instanceOfCurrentUser.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CurrentUserCWProxy get copyWith => _$CurrentUserCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Relation _$RelationFromJson(Map<String, dynamic> json) => Relation(
      id: json['_id'] as String,
      relationStatus: $enumDecode(_$RelationStatusEnumMap, json['status']),
    );

Map<String, dynamic> _$RelationToJson(Relation instance) => <String, dynamic>{
      '_id': instance.id,
      'status': _$RelationStatusEnumMap[instance.relationStatus]!,
    };

const _$RelationStatusEnumMap = {
  RelationStatus.friend: 'Friend',
  RelationStatus.outgoing: 'Outgoing',
  RelationStatus.incoming: 'Incoming',
  RelationStatus.user: 'User',
  RelationStatus.none: 'None',
};

RelationUser _$RelationUserFromJson(Map<String, dynamic> json) => RelationUser(
      id: json['_id'] as String,
      username: json['username'] as String,
      discriminator: json['discriminator'] as String,
      online: json['online'] as bool,
      relationStatus:
          $enumDecode(_$RelationStatusEnumMap, json['relationship']),
    );

Map<String, dynamic> _$RelationUserToJson(RelationUser instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'username': instance.username,
      'discriminator': instance.discriminator,
      'online': instance.online,
      'relationship': _$RelationStatusEnumMap[instance.relationStatus]!,
    };

CurrentUser _$CurrentUserFromJson(Map<String, dynamic> json) => CurrentUser(
      id: json['_id'] as String,
      username: json['username'] as String,
      discriminator: json['discriminator'] as String,
      online: json['online'] as bool,
      relations: (json['relations'] as List<dynamic>?)
              ?.map((e) => Relation.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$CurrentUserToJson(CurrentUser instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'username': instance.username,
      'discriminator': instance.discriminator,
      'online': instance.online,
      'relations': instance.relations,
    };

// ignore_for_file: use_super_parameters

import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.g.dart';

@immutable
abstract class BaseUser {
  const BaseUser({required this.id});
  @JsonKey(name: '_id')
  final String id;
}

abstract class User extends BaseUser {
  const User({
    required super.id,
    required this.username,
    required this.discriminator,
    required this.online,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    if (json case {'relationship': 'User'}) {
      return CurrentUser.fromJson(json);
    }
    return RelationUser.fromJson(json);
  }

  final String username;
  final String discriminator;
  final bool online;

  Map<String, dynamic> toJson();
}

@JsonEnum()
enum RelationStatus {
  @JsonValue('Friend')
  friend,
  @JsonValue('Outgoing')
  outgoing,
  @JsonValue('Incoming')
  incoming,
  @JsonValue('User')
  user,
  @JsonValue('None')
  none
}

@JsonSerializable()
class Relation extends BaseUser {
  const Relation({required String id, required this.relationStatus})
      : super(id: id);

  factory Relation.fromJson(Map<String, dynamic> json) =>
      _$RelationFromJson(json);

  @JsonKey(name: 'status')
  final RelationStatus relationStatus;

  Map<String, dynamic> toJson() => _$RelationToJson(this);
}

@JsonSerializable()
@CopyWith()
class RelationUser extends User {
  const RelationUser({
    required super.id,
    required super.username,
    required super.discriminator,
    required super.online,
    required this.relationStatus,
  });

  factory RelationUser.fromJson(Map<String, dynamic> json) =>
      _$RelationUserFromJson(json);

  //
  @JsonKey(name: 'relationship')
  final RelationStatus relationStatus;

  @override
  Map<String, dynamic> toJson() => _$RelationUserToJson(this);
}

@JsonSerializable()
@CopyWith()
class CurrentUser extends User {
  const CurrentUser({
    required super.id,
    required super.username,
    required super.discriminator,
    required super.online,
    required this.relations,
  });

  factory CurrentUser.fromJson(Map<String, dynamic> json) =>
      _$CurrentUserFromJson(json);

  @JsonKey(defaultValue: [])
  final List<Relation>? relations;

  @override
  Map<String, dynamic> toJson() => _$CurrentUserToJson(this);
}

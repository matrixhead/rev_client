import 'package:freezed_annotation/freezed_annotation.dart';
part 'session_details.g.dart';

@JsonSerializable()
class SessionDetails {
  const SessionDetails({
    required this.id,
    required this.userId,
    required this.sessionToken,
    required this.deviceName,
    this.webPushSubscription,
  });

  factory SessionDetails.fromJson(Map<String, dynamic> json) =>
      _$SessionDetailsFromJson(json);

  @JsonKey(name: '_id')
  final String id;

  @JsonKey(name: 'user_id')
  final String userId;

  @JsonKey(name: 'token')
  final String sessionToken;

  @JsonKey(name: 'name')
  final String deviceName;

  @JsonKey(name: 'subscription')
  final String? webPushSubscription;

  Map<String, dynamic> toJson() => _$SessionDetailsToJson(this);
}

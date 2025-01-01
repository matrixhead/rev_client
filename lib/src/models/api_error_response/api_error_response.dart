import 'package:freezed_annotation/freezed_annotation.dart';
part 'api_error_response.g.dart';

@JsonEnum()
enum ErrorType {
  @JsonValue('UnverifiedAccount')
  unverifiedAccount,
  @JsonValue('InvalidToken')
  invalidToken,
  @JsonValue('ShortPassword')
  shortPassword,
  @JsonValue('AlreadyOnboarded')
  alreadyOnboarded,
  @JsonValue('MissingPermission')
  missingPermission,
  @JsonValue('AlreadyFriends')
  alreadyFriends,
  unknown,
}

@JsonSerializable()
class ApiErrorResponse {
  const ApiErrorResponse({
    required this.errortype,
  });

  factory ApiErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorResponseFromJson(json);

  @JsonKey(name: 'type', unknownEnumValue: ErrorType.unknown)
  final ErrorType errortype;

  Map<String, dynamic> toJson() => _$ApiErrorResponseToJson(this);
}

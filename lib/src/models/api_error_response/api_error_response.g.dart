// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_error_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiErrorResponse _$ApiErrorResponseFromJson(Map<String, dynamic> json) =>
    ApiErrorResponse(
      errortype: $enumDecode(_$ErrorTypeEnumMap, json['type'],
          unknownValue: ErrorType.unknown),
    );

Map<String, dynamic> _$ApiErrorResponseToJson(ApiErrorResponse instance) =>
    <String, dynamic>{
      'type': _$ErrorTypeEnumMap[instance.errortype]!,
    };

const _$ErrorTypeEnumMap = {
  ErrorType.unverifiedAccount: 'UnverifiedAccount',
  ErrorType.invalidToken: 'InvalidToken',
  ErrorType.shortPassword: 'ShortPassword',
  ErrorType.alreadyOnboarded: 'AlreadyOnboarded',
  ErrorType.missingPermission: 'MissingPermission',
  ErrorType.alreadyFriends: 'AlreadyFriends',
  ErrorType.unknown: 'unknown',
};

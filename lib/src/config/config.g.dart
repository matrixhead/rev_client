// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$RevConfigCWProxy {
  RevConfig baseUrl(String baseUrl);

  RevConfig wsPort(int wsPort);

  RevConfig httpPort(int httpPort);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RevConfig(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RevConfig(...).copyWith(id: 12, name: "My name")
  /// ````
  RevConfig call({
    String? baseUrl,
    int? wsPort,
    int? httpPort,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfRevConfig.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfRevConfig.copyWith.fieldName(...)`
class _$RevConfigCWProxyImpl implements _$RevConfigCWProxy {
  const _$RevConfigCWProxyImpl(this._value);

  final RevConfig _value;

  @override
  RevConfig baseUrl(String baseUrl) => this(baseUrl: baseUrl);

  @override
  RevConfig wsPort(int wsPort) => this(wsPort: wsPort);

  @override
  RevConfig httpPort(int httpPort) => this(httpPort: httpPort);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RevConfig(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RevConfig(...).copyWith(id: 12, name: "My name")
  /// ````
  RevConfig call({
    Object? baseUrl = const $CopyWithPlaceholder(),
    Object? wsPort = const $CopyWithPlaceholder(),
    Object? httpPort = const $CopyWithPlaceholder(),
  }) {
    return RevConfig(
      baseUrl: baseUrl == const $CopyWithPlaceholder() || baseUrl == null
          ? _value.baseUrl
          // ignore: cast_nullable_to_non_nullable
          : baseUrl as String,
      wsPort: wsPort == const $CopyWithPlaceholder() || wsPort == null
          ? _value.wsPort
          // ignore: cast_nullable_to_non_nullable
          : wsPort as int,
      httpPort: httpPort == const $CopyWithPlaceholder() || httpPort == null
          ? _value.httpPort
          // ignore: cast_nullable_to_non_nullable
          : httpPort as int,
    );
  }
}

extension $RevConfigCopyWith on RevConfig {
  /// Returns a callable class that can be used as follows: `instanceOfRevConfig.copyWith(...)` or like so:`instanceOfRevConfig.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RevConfigCWProxy get copyWith => _$RevConfigCWProxyImpl(this);
}

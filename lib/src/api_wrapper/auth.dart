import 'dart:convert';
import 'package:revolt_client/src/api_wrapper/helpers.dart';
import 'package:revolt_client/src/exceptions/exceptions.dart';
import 'package:revolt_client/src/models/models.dart';

Future<SessionDetails> login(
  RevHttpClient clientConfig, {
  required String email,
  String? password,
  String? challenge,
  String? friendlyName,
  String? captcha,
}) async {
  //
  final body = json.encode(
    {
      'email': email,
      'password': password,
      'challenge': challenge,
      'friendly_name': friendlyName,
      'captcha': captcha,
    }..removeWhere((key, value) => value == null),
  );

  try {
    final response = await clientConfig.post(
      path: '/auth/session/login',
      body: body,
    );

    return SessionDetails.fromJson(
      jsonDecode(response.body) as Map<String, dynamic>,
    );
  } on NetworkRevError catch (e) {
    throw RevApiError.fromNetworkError(e);
  }
}

Future<void> verifyAccount(
  RevHttpClient clientConfig,
  String verificationCode,
) async {
  try {
    await clientConfig.post(
      path: 'auth/account/verify/$verificationCode',
    );
    return;
  } on NetworkRevError catch (e) {
    throw RevApiError.fromNetworkError(e);
  }
}

Future<bool> checkOnboardingStatus(
  RevHttpClient clientConfig,
) async {
  try {
  final res =   await clientConfig.get(
      path: '/onboard/hello',
    );
  final json = parseJsonToMap(res.body);
    return json['onboarding'] as bool;
  } on NetworkRevError catch (e) {
    throw RevApiError.fromNetworkError(e);
  }
}

Future<void> signUp(
  RevHttpClient clientConfig, {
  required String email,
  String? password,
  String? invite,
  String? captcha,
}) async {
  final body = json.encode(
    {
      'email': email,
      'password': password,
      'captcha': captcha,
    }..removeWhere((key, value) => value == null),
  );

  try {
    await clientConfig.post(
      path: '/auth/account/create',
      body: body,
    );
    return;
  } on NetworkRevError catch (e) {
    throw RevApiError.fromNetworkError(e);
  }
}

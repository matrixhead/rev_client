import 'package:revolt_client/src/api_wrapper/api_wrapper.dart' as api;
import 'package:revolt_client/src/exceptions/exceptions.dart';
import 'package:revolt_client/src/models/api_error_response/api_error_response.dart';
import 'package:revolt_client/src/models/models.dart';
import 'package:revolt_client/src/state/rev_state.dart';

class RevAuth {
  RevAuth({required RevState state, required RevHttpClient revHttpClient})
    : _state = state,
      _revHttpClient = revHttpClient;

  final RevState _state;
  final RevHttpClient _revHttpClient;


  Future<bool> checkOnboardingStatus() {
    try {
      return api.checkOnboardingStatus(_revHttpClient);
    } on RevApiError catch (e) {
      throw RevAuthError(e.toString());
    }
  }

  Future<CurrentUser> completeOnboarding(String username) async {
    try {
      final currentUser = await api.completeOnboarding(
        _revHttpClient,
        username,
      );
      return currentUser;
    } on RevApiError catch (e) {
      throw RevAuthError(e.toString());
    }
  }

  Future<SessionDetails> login({
    required String email,
    String? password,
    String? challenge,
    String? friendlyName,
    String? captcha,
  }) async {
    try {
      return await api.login(
        _revHttpClient,
        email: email,
        password: password,
        challenge: challenge,
        friendlyName: friendlyName,
        captcha: captcha,
      );
    } on RevApiError catch (e) {
      switch (e) {
        case RevApiErrorWithResponse(
              errorResponse: final ApiErrorResponse error,
            )
            when error.errortype == ErrorType.unverifiedAccount:
          throw AccountNotVeifiedError();
        default:
          throw RevAuthError(e.toString());
      }
    }
  }

  void setSession(SessionDetails session) {
    _state.authRepoState.session = session;
  }

  Future<void> verifyAccount(String verificationCode) async {
    try {
      return await api.verifyAccount(_revHttpClient, verificationCode);
    } on RevApiError catch (e) {
      throw VerificationException(e.toString());
    }
  }

  Future<void> signUp({
    required String email,
    required String password,
    String? invite,
    String? captcha,
  }) async {
    try {
      await api.signUp(
        _revHttpClient,
        email: email,
        password: password,
        invite: invite,
        captcha: captcha,
      );
    } on RevApiError catch (e) {
      throw SignUpException(e.toString());
    }
  }
}

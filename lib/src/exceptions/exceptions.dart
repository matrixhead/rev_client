import 'package:http/http.dart';
import 'package:revolt_client/src/api_wrapper/helpers.dart';
import 'package:revolt_client/src/models/api_error_response/api_error_response.dart';

class RevError implements Exception {
  RevError(this.message);

  /// Error message
  final String message;

  @override
  String toString() => 'RevError(message: $message)';
}

class NetworkRevError extends RevError {
  NetworkRevError(super.message, this.response);

  factory NetworkRevError.fromRespone({required Response response}) {
    return NetworkRevError(response.body, response);
  }

  final Response response;
}

class RevApiError extends RevError {
  RevApiError(super.message, this.statuscode);

  factory RevApiError.fromNetworkError(NetworkRevError error) {
    try {
      return RevApiErrorWithResponse(
        error.message,
        errorResponse:
            ApiErrorResponse.fromJson(parseJsonToMap(error.response.body)),
        statuscode: error.response.statusCode,
      );
    } on Exception {
      return RevApiError(error.response.body, error.response.statusCode);
    }
  }

  final int statuscode;
}

class RevApiErrorWithResponse extends RevApiError {
  RevApiErrorWithResponse(
    String message, {
    required this.errorResponse,
    required int statuscode,
  }) : super(message, statuscode);

  factory RevApiErrorWithResponse.fromNetworkError(NetworkRevError error) {
    return RevApiErrorWithResponse(
      error.message,
      errorResponse:
          ApiErrorResponse.fromJson(parseJsonToMap(error.response.body)),
      statuscode: error.response.statusCode,
    );
  }

  final ApiErrorResponse errorResponse;
}

class RevAuthError extends RevError {
  RevAuthError(super.message);
}

class AccountNotVeifiedError extends RevAuthError {
  AccountNotVeifiedError() : super('account not verified');
}

//signUp Exception
class SignUpException extends RevAuthError {
  SignUpException(super.message);
}

class VerificationException extends RevAuthError {
  VerificationException(super.message);
}

class DataError extends RevError {
  DataError({required this.apiError}) : super(apiError.message);

  factory DataError.fromApiError(RevApiError error) {
    return DataError(apiError: error);
  }

  final RevApiError apiError;
}

class RevDataUnauthorizedAccess extends RevError {
  RevDataUnauthorizedAccess()
      : super(
          'RevData accessed before initialization '
          'possibly because authentication has not '
          'been completed',
        );
}

class RevWebsocketNotInitialized extends RevError {
  RevWebsocketNotInitialized()
      : super(
          'Websocket accessed before initialization '
        );
}
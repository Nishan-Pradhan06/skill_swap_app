import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'failure.dart';

class ErrorHandler {
  /// Handles exceptions and converts them to appropriate Failure types
  static Failure handleException(dynamic exception) {
    if (exception is DioException) {
      return _handleDioException(exception);
    } else if (exception is SocketException || exception is HttpException) {
      return NetworkFailure(
        message:
            'Network connection error. Please check your internet connection.',
        exception: exception,
      );
    } else if (exception is TimeoutException) {
      return TimeoutFailure(
        message: 'Request timed out. Please try again.',
        exception: exception,
      );
    } else if (exception is FormatException) {
      return ServerFailure(
        message: 'Invalid data format received from server.',
        exception: exception,
      );
    } else {
      return UnexpectedFailure(
        message: exception?.toString() ?? 'An unexpected error occurred.',
        exception: exception,
      );
    }
  }

  /// Handles Dio specific exceptions
  static Failure _handleDioException(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return TimeoutFailure(
          message: 'Connection timed out. Please try again.',
          exception: exception,
        );

      case DioExceptionType.badResponse:
        final statusCode = exception.response?.statusCode;
        final responseData = exception.response?.data;

        // Handle different status codes
        if (statusCode == 401 || statusCode == 403) {
          return AuthFailure(
            message:
                _extractErrorMessage(responseData) ??
                'Authentication failed. Please login again.',
            statusCode: statusCode,
            exception: exception,
          );
        } else if (statusCode == 404) {
          return ServerFailure(
            message: 'Resource not found.',
            statusCode: statusCode,
            exception: exception,
          );
        } else if (statusCode == 409) {
          return ServerFailure(
            message: _extractErrorMessage(responseData) ?? 'Conflict.',
            statusCode: statusCode,
            exception: exception,
          );
        } else if (statusCode == 405) {
          return MethodNotAllowedFailure(
            message: 'Method not allowed',
            statusCode: statusCode,
            exception: exception,
          );
        } else if (statusCode == 422) {
          return ValidationFailure(
            message: 'Validation failed.',
            fieldErrors: _extractFieldErrors(responseData),
            exception: exception,
          );
        } else if (statusCode == 500 || statusCode == 503) {
          return ServerFailure(
            message: 'Server error. Please try again later.',
            statusCode: statusCode,
            exception: exception,
          );
        } else {
          return ServerFailure(
            message:
                _extractErrorMessage(responseData) ?? 'Server error occurred.',
            statusCode: statusCode,
            exception: exception,
          );
        }

      case DioExceptionType.cancel:
        return NetworkFailure(
          message: 'Request was cancelled.',
          exception: exception,
        );

      case DioExceptionType.connectionError:
        return NetworkFailure(
          message: 'Connection error. Please check your internet connection.',
          exception: exception,
        );

      case DioExceptionType.badCertificate:
        return NetworkFailure(
          message:
              'Invalid SSL certificate. Cannot establish secure connection.',
          exception: exception,
        );

      case DioExceptionType.unknown:
        return UnexpectedFailure(
          message: exception.message ?? 'An unexpected error occurred.',
          exception: exception,
        );
    }
  }

  /// Extracts error message from response data
  static String? _extractErrorMessage(dynamic responseData) {
    if (responseData == null) return null;

    try {
      if (responseData is Map) {
        // Try common error message fields
        return responseData['message'] ??
            responseData['error'] ??
            responseData['error_message'] ??
            responseData['error_description'];
      } else if (responseData is String) {
        return responseData;
      }
    } catch (_) {
      // If parsing fails, return null
    }

    return null;
  }

  /// Extracts field-specific validation errors
  static Map<String, String>? _extractFieldErrors(dynamic responseData) {
    if (responseData == null) return null;

    try {
      if (responseData is Map && responseData.containsKey('errors')) {
        final errors = responseData['errors'];
        if (errors is Map) {
          return errors.map((key, value) {
            final errorMessage = value is List
                ? value.first.toString()
                : value.toString();
            return MapEntry(key.toString(), errorMessage);
          });
        }
      }
    } catch (_) {
      // If parsing fails, return null
    }

    return null;
  }
}

import 'package:dio/dio.dart';

class ApiErrorHandler {
  static String getErrorMessage(dynamic error) {
    if (error is DioException) {
      if (error.response != null) {
        return _handleStatusCode(error.response!.statusCode);
      } else {
        return "No internet connection or server not reachable.";
      }
    }
    return "Unexpected error occurred.";
  }

  static String _handleStatusCode(int? statusCode) {
    switch (statusCode) {
      case 400:
        return "Bad Request – The request was invalid.";
      case 401:
        return "Unauthorized – Please log in again.";
      case 403:
        return "Forbidden – You do not have permission.";
      case 404:
        return "Not Found – The requested resource does not exist.";
      case 500:
        return "Internal Server Error – Please try again later.";
      case 503:
        return "Service Unavailable – Server is temporarily down.";
      default:
        return "HTTP Error: $statusCode";
    }
  }
}

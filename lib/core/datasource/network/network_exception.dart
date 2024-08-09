// Export from [network.provider.dart]
//
import 'package:dio/dio.dart';

import '../../service/localization/localization.dart';

class NetworkException extends DioException {
  String title;
  bool isUnauthorized;
  bool skipLogging;

  bool get isCanceled => type == DioExceptionType.cancel;

  NetworkException({
    required super.requestOptions,
    super.error,
    super.message,
    super.response,
    super.stackTrace,
    super.type = DioExceptionType.unknown,
    String? title,
    this.isUnauthorized = false,
    this.skipLogging = false,
  }) : title = title ?? Localization.error;

  factory NetworkException.fromDioException({
    required DioException error,
    required bool isUnauthorized,
    required bool skipLogging,
    String? title,
    String? message,
  }) =>
      NetworkException(
        requestOptions: error.requestOptions,
        error: error,
        message: message,
        response: error.response,
        stackTrace: error.stackTrace,
        type: error.type,
        title: title ?? Localization.error,
        isUnauthorized: isUnauthorized,
        skipLogging: skipLogging,
      );

  @override
  String toString() => 'NetworkException('
      'title: $title,'
      'message: $message,'
      'code: ${response?.statusCode ?? ''},'
      'type: ${type.name},'
      'isUnauthorized: $isUnauthorized,'
      'path: ${requestOptions.path},'
      '${requestOptions.data != null ? 'data: ${requestOptions.data},' : ''}'
      '${requestOptions.extra.isNotEmpty ? 'extra: ${requestOptions.extra},' : ''}'
      '${requestOptions.queryParameters.isNotEmpty ? 'queryParameters: ${requestOptions.queryParameters},' : ''}'
      ')';
}

class InternetException implements Exception {
  @override
  String toString() => Localization.noInternet;
}

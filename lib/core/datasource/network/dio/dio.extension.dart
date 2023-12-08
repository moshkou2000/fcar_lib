import 'package:dio/dio.dart';

import '../../../service/localization/localization.dart';
import '../../../../config/extension/string.extension.dart';
import '../network.extension.dart';
import '../network_exception.dart';

extension DioExceptionExtension on DioException {
  /// TODO: set the logic based on your backend config
  /// the logic when [isUnauthorized]
  /// true: unauthorized
  /// false: authorized

  NetworkException get networkException {
    final isUnath = response?.statusCode?.isValid == true;
    final skipLogging = response?.statusCode?.skipLogging == true;
    final title = isUnath ? Localization.unauthorized.titleCase : null;

    // TODO: spesify the message
    // set by [response?.statusCode] or use from [localization]
    final m = message?.isNotEmpty == true ? message : '';

    return NetworkException.fromDioException(
      error: this,
      title: title,
      message: m,
      isUnauthorized: isUnath,
      skipLogging: skipLogging,
    );
  }
}

extension ResponseExtension on Response {
  bool get isNotModified => statusCode?.isNotModified == true;
  bool get isOk => statusCode?.isValid == true;

  NetworkException get networkException {
    final isUnath = statusCode?.isUnauthorized == true;
    final title = isUnath ? Localization.unauthorized.titleCase : null;

    // TODO: spesify the message
    // set by [data] or use from [localization]
    final m = data != null ? data.toString() : 'Error In response';

    // TODO: specify [error] & [message]
    throw NetworkException(
      error: null,
      message: m,
      response: this,
      stackTrace: null,
      title: title,
      isUnauthorized: isUnath,
      requestOptions: requestOptions,
      type: DioExceptionType.unknown,
    );
  }
}

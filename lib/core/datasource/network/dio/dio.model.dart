import 'package:dio/dio.dart' as dio;

import '../network.model.dart';
import '../network_canceltoken.dart';

class DioResponse<T> extends dio.Response<T> implements NetworkResponse<T> {
  DioResponse({
    required DioRequestOptions super.requestOptions,
    super.data,
    super.statusCode,
    super.statusMessage,
    super.extra,
    Map<String, List<String>>? header,
  }) : super(
          headers: header != null ? dio.Headers.fromMap(header) : null,
        );

  @override
  DioRequestOptions get requestOptions =>
      super.requestOptions as DioRequestOptions;

  @override
  // TODO: implement header
  Map<String, dynamic> get header => headers.map;
}

class DioRequestOptions extends dio.RequestOptions
    implements NetworkRequestOptions {
  DioRequestOptions({
    required super.path,
    required super.baseUrl,
    required super.method,
    super.data,
    super.headers,
    super.queryParameters,
    super.extra,
    super.onSendProgress,
    super.onReceiveProgress,
    super.sendTimeout,
    super.receiveTimeout,
    super.connectTimeout,
    super.contentType,
    super.sourceStackTrace,
  });
}

class DioCancelToken extends dio.CancelToken implements NetworkCancelToken {
  DioCancelToken();
}

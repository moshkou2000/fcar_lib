// import 'package:dio/dio.dart';

// import '../dio.extension.dart';

// class DioCredentialsInterceptor extends Interceptor {
//   @override
//   void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
//     // _checkResponse(options);
//     super.onRequest(options, handler);
//   }

//   void _checkResponse(RequestOptions requestOptions) {
//     if (!response.isOk) { 
//       if (credentials.isExpired) {
//         if (!credentials.canRefresh) throw ExpirationException(credentials);
//         await refreshCredentials();
//       }
//     }
//   }

// }

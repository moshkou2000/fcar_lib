// import 'package:flutter/foundation.dart';

// /// RemoteAuthConfigModel is to keep the necessary data for establish Oauth client.
// ///
// /// [clientId] and [redirectUrl] are required.
// ///
// /// [clientId] or Application ID
// /// - interactive.public
// /// - `Azure` ab123053-1111-bbbb-aaaa-1234567890f2
// ///
// /// [redirectUrl] <Bundle ID>://<oauth2 client method>
// /// - com.duendesoftware.demo:/oauthredirect
// ///
// /// [scopes]
// /// - ['openid', 'profile', 'email', 'offline_access', 'api']
// /// - `Azure` ['openid', 'profile', 'email', 'offline_access']
// ///
// /// [authorizationEndpoint] and [tokenEndpoint] are required to create [serviceConfiguration]
// /// when there is endSession/logout.
// ///
// /// [authorizationEndpoint]
// /// - https://demo.duendesoftware.com/connect/authorize
// /// - `Azure` https://login.microsoftonline.com/{tenant}/oauth2/v2.0/authorize
// ///
// /// [tokenEndpoint]
// /// - https://demo.duendesoftware.com/connect/token
// /// - `Azure` https://login.microsoftonline.com/{tenant}/oauth2/v2.0/token
// ///
// /// [endSessionEndpoint]
// /// - `Azure` https://demo.duendesoftware.com/connect/endsession
// @immutable
// final class RemoteAuthConfigModel {
//   final String clientId;
//   final Uri redirectUrl;
//   final String? secret;
//   final List<String>? scopes;
//   final Uri? authorizationEndpoint;
//   final Uri? tokenEndpoint;
//   final Uri? endSessionEndpoint;
//   final Uri? profileEndpoint;

//   const RemoteAuthConfigModel({
//     required this.clientId,
//     required this.redirectUrl,
//     this.secret,
//     this.scopes,
//     this.authorizationEndpoint,
//     this.tokenEndpoint,
//     this.endSessionEndpoint,
//     this.profileEndpoint,
//   });
// }

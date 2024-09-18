// import 'dart:async';

// import 'package:flutter/foundation.dart';
// import 'package:flutter_appauth/flutter_appauth.dart';

// import '../../../utility/logger.dart';
// import 'remote_auth.model.dart';
// import 'remote_auth_config.model.dart';

// /// namespace: com.company.product
// /// Example: com.moshkou.fcar
// ///
// /// - Android:
// /// Configure Dependencies and Callback URL
// /// Update the android/app/build.gradle
// ///
// /// It overrides [AndroidManifest.xml] placeholder substitution.
// /// Suggested to use += to keep the current data in [manifestPlaceholders];
// ///
// /// ```
// ///   defaultConfig {
// ///     ...
// ///     manifestPlaceholders += ['appAuthRedirectScheme': 'com.company.product:/oauthredirect']
// ///   }
// /// ```
// ///
// /// Alternatively, the redirect URI can be directly configured
// /// by adding an intent-filter for AppAuth's RedirectUriReceiverActivity to your AndroidManifest.xml
// ///
// /// ```
// ///   <manifest xmlns:android="http://schemas.android.com/apk/res/android"
// ///    xmlns:tools="http://schemas.android.com/tools"
// ///    package="com.example.my_app">
// ///     ...<activity
// ///       android:name="net.openid.appauth.RedirectUriReceiverActivity"
// ///       android:exported="true"
// ///       tools:node="replace">
// ///       <intent-filter>
// ///         <action android:name="android.intent.action.VIEW"/>
// ///         <category android:name="android.intent.category.DEFAULT"/>
// ///         <category android:name="android.intent.category.BROWSABLE"/>
// ///         <data android:scheme="<your_custom_scheme>" android:host="<your_custom_host>"/>
// ///       </intent-filter>
// ///     </activity>...
// /// ```
// ///
// /// - iOS:
// /// Update the ios/Runner/Info.plist
// ///
// /// ```
// ///     <dict>
// ///       <key>CFBundleURLTypes</key>
// ///       <array>
// ///         <dict>
// ///           <key>CFBundleTypeRole</key>
// ///           <string>Editor</string>
// ///           <key>CFBundleURLSchemes</key>
// ///           <array>
// ///             <string>com.company.product:/oauthredirect</string>
// ///           </array>
// ///         </dict>
// ///       </array>
// ///     </dict>
// /// ```
// ///
// ///
// /// The example demonstrates how to sign into the demo IdentityServer instance
// ///   (https://demo.duendesoftware.com).
// ///
// @immutable
// abstract final class RemoteAuth {
//   static FlutterAppAuth appAuth = const FlutterAppAuth();

//   /// It will be set after [auth] | [authWithNoCodeExchange] | [refreshToken]
//   static final RemoteAuthModel data = RemoteAuthModel();

//   /// It will be populated after [setup]
//   static RemoteAuthConfigModel? config;

//   /// call in [App.setup]
//   ///
//   /// - [clientId] is known as application ID as well.
//   ///
//   /// Have to provide one of the following
//   ///   - [issuer]
//   ///   - [discoveryUrl]
//   ///   - [authorizationEndpoint] & [tokenEndpoint]
//   ///
//   /// The authorization server will redirect the resource owner to [redirectUrl] once they've authorized the client.
//   /// The redirection will include the authorization code in the query parameters.
//   ///
//   /// [discoveryUrl], [authorizationEndpoint] and [tokenEndpoint] URLs are endpoints that are provided by the authorization server.
//   ///
//   /// Examples available in [RemoteAuthConfigModel]
//   ///
//   static Future<void> setup({
//     required String clientId,
//     required String redirectUrl,
//     String? issuer,
//     String? discoveryUrl,
//     List<String>? scopes,
//     String? postLogoutRedirectUrl,
//     String? authorizationEndpoint,
//     String? tokenEndpoint,
//     String? endSessionEndpoint,
//   }) async {
//     assert(issuer?.trim().isNotEmpty == true ||
//         discoveryUrl?.trim().isNotEmpty == true ||
//         (authorizationEndpoint?.trim().isNotEmpty == true &&
//             tokenEndpoint?.trim().isNotEmpty == true));

//     config = RemoteAuthConfigModel(
//       clientId: clientId,
//       redirectUrl: redirectUrl,
//       issuer: issuer,
//       discoveryUrl: discoveryUrl,
//       scopes: scopes,
//       postLogoutRedirectUrl: postLogoutRedirectUrl,
//       authorizationEndpoint: authorizationEndpoint,
//       tokenEndpoint: tokenEndpoint,
//       endSessionEndpoint: endSessionEndpoint,
//     );
//   }

//   /// For the future ref, the successfull response is available in [RemoteAuth.data]
//   ///
//   /// Required [setup]
//   static Future<AuthorizationTokenResponse?> auth() async {
//     _guard();
//     try {
//       final serviceConfiguration =
//           config!.authorizationEndpoint != null && config!.tokenEndpoint != null
//               ? AuthorizationServiceConfiguration(
//                   authorizationEndpoint: config!.authorizationEndpoint!,
//                   tokenEndpoint: config!.tokenEndpoint!,
//                   endSessionEndpoint: config!.endSessionEndpoint,
//                 )
//               : null;
//       final result = await appAuth.authorizeAndExchangeCode(
//         AuthorizationTokenRequest(
//           config!.clientId,
//           config!.redirectUrl,
//           scopes: config!.scopes,
//           discoveryUrl: config!.discoveryUrl,
//           issuer: config!.issuer,
//           serviceConfiguration: serviceConfiguration,
//         ),
//       );
//       _processAuthResponse(result);
//       return result;
//     } catch (e, s) {
//       logger.error('RemoteAuth.auth', e: e, s: s);
//     }
//     return null;
//   }

//   /// [loginHint] can be user name/username/...
//   ///
//   /// For the future ref, the successfull response is available in [RemoteAuth.data]
//   ///
//   /// Required [setup]
//   static Future<AuthorizationResponse?> authWithNoCodeExchange({
//     String? loginHint,
//   }) async {
//     _guard();
//     try {
//       final result = await appAuth.authorize(
//         AuthorizationRequest(
//           config!.clientId,
//           config!.redirectUrl,
//           discoveryUrl: config!.discoveryUrl,
//           scopes: config!.scopes,
//           loginHint: loginHint,
//         ),
//       );
//       _processAuthWithNoCodeExchangeResponse(result);
//       return result;
//     } catch (e, s) {
//       logger.error('RemoteAuth.authWithNoCodeExchange', e: e, s: s);
//     }
//     return null;
//   }

//   /// Some providers may return a refresh token that could be used to refresh short-lived access tokens.
//   ///
//   /// For the future ref, the successfull response is available in [RemoteAuth.data]
//   ///
//   /// Required [setup]
//   static Future<TokenResponse?> refreshToken({
//     required String refreshToken,
//   }) async {
//     _guard();
//     try {
//       final result = await appAuth.token(
//         TokenRequest(
//           config!.clientId,
//           config!.redirectUrl,
//           discoveryUrl: config!.discoveryUrl,
//           refreshToken: refreshToken,
//           scopes: config!.scopes,
//         ),
//       );
//       _processRefreshTokenResponse(result);
//       return result;
//     } catch (e, s) {
//       logger.error('RemoteAuth.refreshToken', e: e, s: s);
//     }
//     return null;
//   }

//   /// If the provider has an end session endpoint, you can trigger it.
//   /// It is typically used for logging out of the built-in browser.
//   ///
//   /// Required [setup]
//   static Future<EndSessionResponse?> logout({
//     String? idTokenHint,
//   }) async {
//     _guard();
//     try {
//       final serviceConfiguration =
//           config!.authorizationEndpoint != null && config!.tokenEndpoint != null
//               ? AuthorizationServiceConfiguration(
//                   authorizationEndpoint: config!.authorizationEndpoint!,
//                   tokenEndpoint: config!.tokenEndpoint!,
//                   endSessionEndpoint: config!.endSessionEndpoint,
//                 )
//               : null;
//       return await appAuth.endSession(
//         EndSessionRequest(
//           idTokenHint: idTokenHint,
//           postLogoutRedirectUrl: config!.postLogoutRedirectUrl,
//           serviceConfiguration: serviceConfiguration,
//         ),
//       );
//     } catch (e, s) {
//       logger.error('RemoteAuth.logout', e: e, s: s);
//     }
//     return null;
//   }

//   static void _guard() {
//     if (config == null) {
//       throw '[config] must not be null. Make sure to call [setup].';
//     }
//   }

//   /// Save the code verifier and nonce as it must be used when exchanging the token.
//   static void _processAuthWithNoCodeExchangeResponse(
//       AuthorizationResponse response) {
//     data.codeVerifier = response.codeVerifier;
//     data.nonce = response.nonce;
//     data.authorizationCode = response.authorizationCode;
//     data.authorizationAdditionalParameters =
//         response.authorizationAdditionalParameters;
//   }

//   static void _processAuthResponse(AuthorizationTokenResponse response) {
//     data.accessToken = response.accessToken;
//     data.idToken = response.idToken;
//     data.refreshToken = response.refreshToken;
//     data.accessTokenExpirationDateTime = response.accessTokenExpirationDateTime;
//     data.tokenAdditionalParameters = response.tokenAdditionalParameters;
//     data.authorizationAdditionalParameters =
//         response.authorizationAdditionalParameters;
//   }

//   static void _processRefreshTokenResponse(TokenResponse response) {
//     data.accessToken = response.accessToken;
//     data.idToken = response.idToken;
//     data.refreshToken = response.refreshToken;
//     data.accessTokenExpirationDateTime = response.accessTokenExpirationDateTime;
//     data.tokenAdditionalParameters = response.tokenAdditionalParameters;
//   }
// }

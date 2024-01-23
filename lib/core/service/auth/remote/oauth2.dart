import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:oauth2/oauth2.dart' as oauth2;

/// namespace: com.company.product
/// Example: com.moshkou.fcar
///
/// Android:
/// Configure Dependencies and Callback URL
/// Update the android/app/build.gradle
///   defaultConfig {
///     ...
///     manifestPlaceholders = ['appAuthRedirectScheme': 'com.company.product']
///   }
///
/// iOS:
/// Update the ios/Runner/Info.plist
///   <dict>
///     ...
///     <key>CFBundleURLTypes</key>
///     <array>
///       <dict>
///         <key>CFBundleTypeRole</key>
///         <string>Editor</string>
///         <key>CFBundleURLSchemes</key>
///         <array>
///           <string>com.company.product</string>
///         </array>
///       </dict>
///     </array>
///   </dict>
///
@immutable
abstract final class Oauth2 {
  static oauth2.Client? _client;

  /// call in [App.setup]
  ///
  /// These URLs are endpoints that are provided by the authorization server.
  /// [authorizationEndpoint]: Uri.parse('http://example.com/oauth2/authorization')
  /// [tokenEndpoint]: Uri.parse('http://example.com/oauth2/token')
  ///
  /// The authorization server will redirect the resource owner
  /// here once they've authorized the client.
  /// The redirection will include the authorization code in the query parameters.
  /// [redirectUrl]
  ///   `mobile only`
  ///   Uri.parse('com.company.product://auth')
  ///   or
  ///   Uri get redirectUrl {
  ///     if (kIsWeb) {
  ///       if (kDebugMode) {
  ///         return Uri.parse('http://localhost:8080/callback.html');
  ///       } else {
  ///         return Uri.parse('https://xxx.com/callback.html');
  ///       }
  ///     } else {
  ///       return Uri.parse('com.company.product://auth');
  ///     }
  ///   }
  ///
  /// [redirect(url)]
  /// Client implementation detail
  ///
  /// [listen(url)]
  /// Client implementation detail
  static Future<void> setup({
    required Uri authorizationEndpoint,
    required Uri tokenEndpoint,
    required Uri redirectUrl,
    required String identifier,
    required Future<void> Function(Uri url) redirect,
    required Future<Uri> Function(Uri url) listen,
    String? secret,
    String? jsonCredentials,
  }) async {
    // If the OAuth2 credentials have already been saved from a previous run, we
    // just want to reload them.
    if (jsonCredentials?.isNotEmpty == true) {
      var credentials = oauth2.Credentials.fromJson(jsonCredentials!);
      _client =
          oauth2.Client(credentials, identifier: identifier, secret: secret);
    } else {
      // If we don't have OAuth2 credentials yet, we need to get the resource owner
      // to authorize us. We're assuming here that we're a command-line application.
      var grant = oauth2.AuthorizationCodeGrant(
          identifier, authorizationEndpoint, tokenEndpoint,
          secret: secret);

      // A URL on the authorization server (authorizationEndpoint with some
      // additional query parameters). Scopes and state can optionally be passed
      // into this method.
      var authorizationUrl = grant.getAuthorizationUrl(redirectUrl);

      // Redirect the resource owner to the authorization URL. Once the resource
      // owner has authorized, they'll be redirected to `redirectUrl` with an
      // authorization code. The `redirect` should cause the browser to redirect to
      // another URL which should also have a listener.
      //
      // `redirect` and `listen` are not shown implemented here.
      await redirect(authorizationUrl);
      var responseUrl = await listen(redirectUrl);

      // Once the user is redirected to `redirectUrl`, pass the query parameters to
      // the AuthorizationCodeGrant. It will validate them and extract the
      // authorization code to create a new Client.
      _client =
          await grant.handleAuthorizationResponse(responseUrl.queryParameters);
    }
  }

  /// Authentication
  ///
  /// May need to call [Close()] after uses the oauth2.Client.
  /// Keep the credentials safe in the keystore/file/database.
  static Future<String?> auth() async {
    await _client?.read(Uri.http('example.com', 'protected-resources.txt'));
    return _client?.credentials.toJson();
  }

  /// Close the oauth2.Client and its underlying HTTP client.
  static void close() {
    _client?.close();
  }
}

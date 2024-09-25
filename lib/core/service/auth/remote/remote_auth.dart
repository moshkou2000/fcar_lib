import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:oauth2/oauth2.dart';

import '../../../../feature/webview/webview.argument.dart';
import '../../../../feature/webview/webview.view.dart';
import '../../../core.module.dart';

/// namespace: com.company.product
/// Example: com.moshkou.fcar
///
/// - Android:
/// Configure Dependencies and Callback URL
/// Update the android/app/build.gradle
///
/// It overrides [AndroidManifest.xml] placeholder substitution.
/// Suggested to use += to keep the current data in [manifestPlaceholders];
///
/// ```
///   defaultConfig {
///     ...
///     manifestPlaceholders += ['appAuthRedirectScheme': 'com.company.product:/oauthredirect']
///   }
/// ```
///
/// Alternatively, the redirect URI can be directly configured
/// by adding an intent-filter for AppAuth's RedirectUriReceiverActivity to your AndroidManifest.xml
///
/// ```
///   <manifest xmlns:android="http://schemas.android.com/apk/res/android"
///    xmlns:tools="http://schemas.android.com/tools"
///    package="com.example.my_app">
///     ...<activity
///       android:name="net.openid.appauth.RedirectUriReceiverActivity"
///       android:exported="true"
///       tools:node="replace">
///       <intent-filter>
///         <action android:name="android.intent.action.VIEW"/>
///         <category android:name="android.intent.category.DEFAULT"/>
///         <category android:name="android.intent.category.BROWSABLE"/>
///         <data android:scheme="<your_custom_scheme>" android:host="<your_custom_host>"/>
///       </intent-filter>
///     </activity>...
/// ```
///
/// Make sure to add the following queries in the AndroidManifest.xml
/// ```
///   <queries>
///        ...
///        <intent>
///            <action android:name="android.intent.action.VIEW" />
///            <category android:name="android.intent.category.BROWSABLE" />
///            <data android:scheme="https" />
///        </intent>
///        <intent>
///            <action android:name="android.intent.action.VIEW" />
///            <category android:name="android.intent.category.APP_BROWSER" />
///            <data android:scheme="https" />
///        </intent>
///   </queries>
/// ```
///
/// - iOS:
/// Update the ios/Runner/Info.plist
///
/// ```
///     <dict>
///       <key>CFBundleURLTypes</key>
///       <array>
///         <dict>
///           <key>CFBundleTypeRole</key>
///           <string>Editor</string>
///           <key>CFBundleURLSchemes</key>
///           <array>
///             <string>com.company.product:/oauthredirect</string>
///           </array>
///         </dict>
///       </array>
///     </dict>
/// ```
///
///
/// The example demonstrates how to sign into the demo IdentityServer instance (https://demo.duendesoftware.com).
///
@immutable
abstract final class RemoteAuth {
  /// authorizationEndpoint & tokenEndpoint must have correct value
  ///   based on the autherization server.
  ///
  /// it's better to use [Localization.authentication] for [title]
  ///
  /// It returns [RemoteAuthModel?]
  ///
  static Future<RemoteAuthModel?> authentication(
    RemoteAuthConfigModel remoteAuthConfig,
    BuildContext context,
    String title,
  ) {
    assert(remoteAuthConfig.authorizationEndpoint != null &&
        remoteAuthConfig.tokenEndpoint != null);

    // Create an authorization grant
    var grant = AuthorizationCodeGrant(
      remoteAuthConfig.clientId,
      remoteAuthConfig.authorizationEndpoint!,
      remoteAuthConfig.tokenEndpoint!,
    );

    // Build the authorization URL
    var authorizationUrl = grant.getAuthorizationUrl(
      remoteAuthConfig.redirectUrl,
      scopes: remoteAuthConfig.scopes,
    );

    return _navigateToAuth(
      remoteAuthConfig,
      context,
      title,
      authorizationUrl,
      grant,
    );
  }

  static Future<RemoteAuthModel?> _navigateToAuth(
    RemoteAuthConfigModel remoteAuthConfig,
    BuildContext context,
    String title,
    Uri authorizationUrl,
    AuthorizationCodeGrant grant,
  ) async {
    return await Navigator.push<RemoteAuthModel?>(
      context,
      MaterialPageRoute(
        builder: (context) => Webview(
          arguments: WebviewArgument(
            title: title,
            url: authorizationUrl,
            onUrlChange: (url) async {
              if (url != null) {
                await _handleAuth(remoteAuthConfig, url, grant);
              }
            },
            onError: () {},
            hasCloseButton: false,
          ),
        ),
      ),
    );
  }

  static Future<void> _handleAuth(
    RemoteAuthConfigModel remoteAuthConfig,
    String url,
    AuthorizationCodeGrant grant,
  ) async {
    if (url.contains(remoteAuthConfig.redirectUrl.toString()) == true) {
      // Extract the authorization code from the URL
      final uri = Uri.parse(url);
      final code = uri.queryParameters['code'];

      if (code != null) {
        try {
          // Exchange the authorization code for tokens
          final client =
              await grant.handleAuthorizationResponse({'code': code});

          if (remoteAuthConfig.profileEndpoint != null) {
            var response = await client.get(remoteAuthConfig.profileEndpoint!);

            if (response.statusCode == 200) {
              final Map<String, dynamic> parameters = jsonDecode(response.body);

              late final RemoteAuthModel data;
              switch (remoteAuthConfig.authorizationType) {
                case AuthorizationType.azure:
                  data = RemoteAuthModel(
                    id: parameters['id'],
                    displayname: parameters['displayName'],
                    username: parameters['mail'],
                    accessToken: client.credentials.accessToken,
                    refreshToken: client.credentials.refreshToken,
                    expiration: client.credentials.expiration,
                    additionalParameters: parameters,
                  );
                  break;
                default:
                  data = RemoteAuthModel.credentials(
                    accessToken: client.credentials.accessToken,
                    refreshToken: client.credentials.refreshToken,
                    expiration: client.credentials.expiration,
                    additionalParameters: parameters,
                  );
              }

              // Return syccess
              Navigation.pop(result: data);
              return;
            } else {
              // log the error in crashlytics
              // DataDogErrorTracking.recordError(
              //   response.body,
              //   null,
              //   reason: 'Could not get user data.',
              // );

              // Return failure
              Navigation.pop(result: null);
              return;
            }
          }

          var data = RemoteAuthModel.credentials(
            accessToken: client.credentials.accessToken,
            refreshToken: client.credentials.refreshToken,
            expiration: client.credentials.expiration,
          );

          // Return syccess
          Navigation.pop(result: data);
          return;
        } catch (e, s) {
          // log the error in crashlytics
          // DataDogErrorTracking.recordError(e, s);

          // Return failure
          Navigation.pop(result: null);
          return;
        }
      }

      // log the error in crashlytics
      // DataDogErrorTracking.recordError(
      //   'Authorization code is null',
      //   null,
      //   reason:
      //       'Could not proceed your request. Please contact customer service.',
      // );

      // Return failure
      Navigation.pop(result: null);
    }
  }
}

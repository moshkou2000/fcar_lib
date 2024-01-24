import 'package:flutter/foundation.dart';

/// RemoteAuthConfigModel is to keep the necessary data for establish Oauth client.
///
/// [clientId] and [redirectUrl] are required.
///
/// [clientId] or Application ID
/// - interactive.public
/// - `Azure` ab123053-1111-bbbb-aaaa-1234567890f2
///
/// [redirectUrl] <Bundle ID>://<oauth2 client method>
/// - com.duendesoftware.demo:/oauthredirect
///
/// [issuer]
/// - https://demo.duendesoftware.com
/// - `Azure` https://login.microsoftonline.com/{tenant}/wsfed
///
/// [discoveryUrl]
/// - https://demo.duendesoftware.com/.well-known/openid-configuration
/// - `Azure` https://login.microsoftonline.com/{tenant}/discovery/v2.0/keys
///
/// [postLogoutRedirectUrl]
/// - com.duendesoftware.demo
///
/// [scopes]
/// - ['openid', 'profile', 'email', 'offline_access', 'api']
/// - `Azure` ['openid', 'profile', 'email', 'offline_access']
///
/// [authorizationEndpoint] and [tokenEndpoint] are required to create [serviceConfiguration]
/// when there is endSession/logout.
///
/// [authorizationEndpoint]
/// - https://demo.duendesoftware.com/connect/authorize
/// - `Azure` https://login.microsoftonline.com/{tenant}/oauth2/v2.0/authorize
///
/// [tokenEndpoint]
/// - https://demo.duendesoftware.com/connect/token
/// - `Azure` https://login.microsoftonline.com/{tenant}/oauth2/v2.0/token
///
/// [endSessionEndpoint]
/// - `Azure` https://demo.duendesoftware.com/connect/endsession
@immutable
final class RemoteAuthConfigModel {
  final String clientId;
  final String redirectUrl;
  final String? issuer;
  final String? discoveryUrl;
  final List<String>? scopes;
  final String? postLogoutRedirectUrl;
  final String? authorizationEndpoint;
  final String? tokenEndpoint;
  final String? endSessionEndpoint;

  const RemoteAuthConfigModel({
    required this.clientId,
    required this.redirectUrl,
    this.issuer,
    this.discoveryUrl,
    this.scopes,
    this.postLogoutRedirectUrl,
    this.authorizationEndpoint,
    this.tokenEndpoint,
    this.endSessionEndpoint,
  });
}

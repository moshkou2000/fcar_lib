import 'package:flutter/foundation.dart';

import 'remote_auth.enum.dart';

/// RemoteAuthConfigModel is to keep the necessary data for establish Oauth client.
///
/// This class sets for Microsoft Entra ID (Azure Active Directory)
///
/// Change it for other OAuth2.0 services
///
/// [authorizationType] implement for the respective service provider.
///
/// [tenantId], [clientId], [secret] and [redirectUrl] are required.
///
/// secret
///
/// [clientId] or Application ID
/// - interactive.public
/// - `Azure` ab123053-1111-bbbb-aaaa-1234567890f2
///
/// [redirectUrl] <Bundle ID>://<oauth2 client method>
/// - com.duendesoftware.demo:/oauthredirect
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
/// - https://demo.duendesoftware.com/connect/logout
/// - `Azure` https://login.microsoftonline.com/{tenant}/oauth2/v2.0/logout
@immutable
final class RemoteAuthConfigModel {
  final AuthorizationType authorizationType;
  final String tenantId;
  final String clientId;
  final String? secret;
  final Uri redirectUrl;
  final List<String>? scopes;
  final Uri? authorizationEndpoint;
  final Uri? tokenEndpoint;
  final Uri? profileEndpoint;
  final Uri? endSessionEndpoint;

  const RemoteAuthConfigModel._({
    required this.authorizationType,
    required this.tenantId,
    required this.clientId,
    required this.redirectUrl,
    this.secret,
    this.scopes,
    this.authorizationEndpoint,
    this.tokenEndpoint,
    this.profileEndpoint,
    this.endSessionEndpoint,
  });

  factory RemoteAuthConfigModel.azure({
    required String tenantId,
    required String clientId,
    required Uri redirectUrl,
  }) {
    return RemoteAuthConfigModel._(
      authorizationType: AuthorizationType.azure,
      tenantId: tenantId,
      clientId: clientId,
      redirectUrl: redirectUrl,
      secret: null,
      scopes: const [
        'user.read',
        'profile',
        'openid',
        'email',
        'offline_access'
      ],
      authorizationEndpoint: Uri.parse(
          'https://login.microsoftonline.com/$tenantId/oauth2/v2.0/authorize'),
      tokenEndpoint: Uri.parse(
          'https://login.microsoftonline.com/$tenantId/oauth2/v2.0/token'),
      profileEndpoint: Uri.parse('https://graph.microsoft.com/v1.0/me'),
      endSessionEndpoint: Uri.parse(
          'https://login.microsoftonline.com/$tenantId/oauth2/v2.0/logout'),
    );
  }
}

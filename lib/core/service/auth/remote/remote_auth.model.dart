final class RemoteAuthModel {
  String? codeVerifier;
  String? nonce;
  String? idToken;
  String? authorizationCode;
  String? refreshToken;
  String? accessToken;
  DateTime? accessTokenExpirationDateTime;
  Map<String, dynamic>? tokenAdditionalParameters;
  Map<String, dynamic>? authorizationAdditionalParameters;
}

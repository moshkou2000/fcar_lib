// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

/// RemoteAuthModel is to keep the responses from Oauth server.
/// It's based on the scopes.
///
@immutable
class RemoteAuthModel {
  final String? id;
  final String? displayname;
  final String? username;
  final String? accessToken;
  final String? refreshToken;

  /// The date at which these credentials will expire.
  ///
  /// This is likely to be a few seconds earlier than the server's idea of the
  /// expiration date.
  final DateTime? expiration;

  /// The URL of the authorization server endpoint that's used to refresh the
  /// credentials.
  ///
  /// This may be `null`, indicating that the credentials can't be refreshed.
  final Uri? tokenEndpoint;

  final Map<String, dynamic>? additionalParameters;

  const RemoteAuthModel({
    this.id,
    this.displayname,
    this.username,
    this.accessToken,
    this.refreshToken,
    this.expiration,
    this.tokenEndpoint,
    this.additionalParameters,
  });

  factory RemoteAuthModel.credentials({
    String? accessToken,
    String? refreshToken,
    DateTime? expiration,
    Map<String, dynamic>? additionalParameters,
  }) {
    return RemoteAuthModel(
      accessToken: accessToken,
      refreshToken: refreshToken,
      expiration: expiration,
      additionalParameters: additionalParameters,
    );
  }

  bool get hasToken => accessToken != null && accessToken!.trim().isNotEmpty;

  /// Whether or not these credentials have expired.
  ///
  /// Note that it's possible the credentials will expire shortly after this is
  /// called. However, since the client's expiration date is kept a few seconds
  /// earlier than the server's, there should be enough leeway to rely on this.
  bool get isExpired {
    var expiration = this.expiration;
    return expiration != null && DateTime.now().isAfter(expiration);
  }

  /// Whether it's possible to refresh these credentials.
  bool get canRefresh => refreshToken != null && tokenEndpoint != null;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'displayname': displayname,
      'username': username,
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'expiration': expiration,
      'additionalParameters': additionalParameters,
    };
  }

  factory RemoteAuthModel.fromMap(Map<String, dynamic> map) {
    return RemoteAuthModel(
      id: map['id'] != null ? map['id'] as String : null,
      displayname:
          map['displayname'] != null ? map['displayname'] as String : null,
      username: map['username'] != null ? map['username'] as String : null,
      accessToken:
          map['accessToken'] != null ? map['accessToken'] as String : null,
      refreshToken:
          map['refreshToken'] != null ? map['refreshToken'] as String : null,
      expiration:
          map['expiration'] != null ? map['expiration'] as DateTime : null,
      additionalParameters: map['additionalParameters'] != null
          ? Map<String, dynamic>.from(
              (map['additionalParameters'] as Map<String, dynamic>))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RemoteAuthModel.fromJson(String source) =>
      RemoteAuthModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

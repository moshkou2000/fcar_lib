import 'dart:math';

import 'package:firebase_remote_config/firebase_remote_config.dart' as package;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../config/enum/app_env.enum.dart';
import '../monitoring/firebase.dart';

@immutable
abstract final class FirebaseRemoteConfig {
  static const String _lVersion = 'lowest_version';
  static const String _dUrl = 'download_url';

  static String get _lowestVersion =>
      package.FirebaseRemoteConfig.instance.getString(_lVersion);
  static String get _downloadUrl =>
      package.FirebaseRemoteConfig.instance.getString(_dUrl);

  static String getRemoteConfigValue({required String key}) =>
      package.FirebaseRemoteConfig.instance.getString(key);

  /// call in [App.setup]
  static Future<void> setup({
    required AppEnvironment env,
    Map<String, dynamic>? defaultParameters,
  }) async {
    try {
      Firebase.init(env: env);
      final params = defaultParameters ??
          <String, dynamic>{
            _lVersion: '',
            _dUrl: '',
          };
      await package.FirebaseRemoteConfig.instance.setDefaults(params);
      await package.FirebaseRemoteConfig.instance.fetchAndActivate();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  /// It returns TRUE when a biger version is available
  /// Mostly used for controling force update.
  static Future<bool> versionControl({
    required BuildContext context,
    required AppEnvironment env,
    required String currentVersion,
    required String title,
    required String message,
    required String buttonText,
  }) async {
    if (context.mounted) {
      if (_isBiggerVersion(currentVersion)) {
        return true;
      }
    }
    return false;
  }

  static bool _isBiggerVersion(String currentVersion) {
    if (_lowestVersion.isEmpty == true || currentVersion.isEmpty == true) {
      return false;
    }
    try {
      var lowestVersions = _lowestVersion.split('.');
      if (lowestVersions.isEmpty == true) {
        lowestVersions = [_lowestVersion];
      }
      var currentVersions = currentVersion.split('.');
      if (currentVersions.isEmpty == true) {
        currentVersions = [currentVersion];
      }
      final int count = min(lowestVersions.length, currentVersions.length);
      for (var i = 0; i < count; i++) {
        final lowVersion = int.parse(lowestVersions[i]);
        final currVersion = int.parse(currentVersions[i]);
        if (lowVersion != currVersion) {
          return lowVersion > currVersion;
        } else if (i == count - 1 &&
            lowestVersions.length > currentVersions.length &&
            int.parse(lowestVersions[i + 1]) > 0) {
          return true;
        }
      }
      return false;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return false;
  }

  static Future<void> _launchUrl(String url) async {
    final uri = Uri.tryParse(Uri.encodeFull(url));
    if (uri != null) {
      if (await canLaunchUrl(uri)) {
        try {
          await launchUrl(uri);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
        }
      }
    }
  }
}

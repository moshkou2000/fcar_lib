import 'package:firebase_core/firebase_core.dart' as package;
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

import '../../../../config/enum/app_env.enum.dart';

@immutable
abstract final class Firebase {
  static bool _isInitialized = false;

  static bool get isInitialized => _isInitialized;

  static Future<void> init({required AppEnvironment env}) async {
    try {
      await package.Firebase.initializeApp();
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
      _isInitialized = true;
    } catch (_) {}
  }
}

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

import '../../../../config/enum/app_env.enum.dart';
import '../../../datasource/network/network_exception.dart';
import '../monitoring/firebase.dart';

@immutable
abstract final class FirebaseErrorTracking {
  /// call in [App.setup]
  static Future<void> setup({required AppEnvironment env}) async {
    Firebase.init(env: env);
    if (Firebase.isInitialized) {
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    }
  }

  static void recordError(
    dynamic exception,
    StackTrace? stackTrace, {
    dynamic reason,
    Map<String, dynamic> information = const {},
    bool printDetails = true,
    bool fatal = false,
    bool filter = true,
  }) {
    if (!Firebase.isInitialized) return;

    if (filter) {
      if (exception is NetworkException) {
        if (exception.skipLogging) {
          return;
        }
      }
    }

    if (exception is FlutterErrorDetails) {
      if (fatal) {
        FirebaseCrashlytics.instance.recordFlutterFatalError(exception);
      } else {
        FirebaseCrashlytics.instance.recordFlutterError(exception);
      }
    } else {
      FirebaseCrashlytics.instance.recordError(
        exception,
        stackTrace,
        reason: reason,
        information: information.keys.map((e) => '$e:${information[e]}'),
        printDetails: printDetails,
        fatal: fatal,
      );
    }
  }
}

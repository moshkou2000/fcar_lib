import 'package:flutter/foundation.dart';
import 'package:sentry_flutter/sentry_flutter.dart' as package;

import '../../../../config/enum/app_env.enum.dart';
import '../../../datasource/network/network_exception.dart';
import '../monitoring/sentry.dart';

// error tracking and performance monitoring

@immutable
abstract final class SentryErrorTracking {
  /// call in [App.setup]
  static Future<void> setup({required AppEnvironment env}) async {
    Sentry.init(env: env);
  }

  static void recordError(
    dynamic exception,
    StackTrace? stackTrace, {
    dynamic reason,
    Map<String, dynamic> information = const {}, //Iterable<Object>
    bool printDetails = true,
    bool fatal = false,
    bool filter = true,
  }) {
    if (!Sentry.isInitialized) return;

    if (filter) {
      if (exception is NetworkException) {
        if (exception.skipLogging) {
          return;
        }
      }
    }

    package.Sentry.captureException(
      exception,
      stackTrace: stackTrace,
      hint: package.Hint.withMap(Map<String, Object>.from(information)),
    );
  }
}

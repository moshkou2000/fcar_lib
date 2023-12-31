import 'package:datadog_flutter_plugin/datadog_flutter_plugin.dart';
import 'package:flutter/foundation.dart';

import '../../../../config/enum/app_env.enum.dart';
import '../../../datasource/network/network_exception.dart';
import '../monitoring/datadog.dart';

@immutable
abstract final class DataDogErrorTracking {
  /// call in [App.setup]
  static Future<void> setup({required AppEnvironment env}) async {
    Datadog.init(env: env);
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
    if (!Datadog.isInitialized) return;

    if (filter) {
      if (exception is NetworkException) {
        if (exception.skipLogging) {
          return;
        }
      }
    }

    if (exception is FlutterErrorDetails) {
      DatadogSdk.instance.rum?.handleFlutterError(exception);
    } else {
      DatadogSdk.instance.rum?.addError(
        exception,
        RumErrorSource.source,
        stackTrace: stackTrace,
        errorType: exception.runtimeType.toString(),
        attributes: information,
      );
    }
  }
}

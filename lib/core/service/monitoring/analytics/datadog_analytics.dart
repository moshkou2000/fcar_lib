import 'package:datadog_flutter_plugin/datadog_flutter_plugin.dart' as package;
import 'package:datadog_flutter_plugin/datadog_flutter_plugin.dart';
import 'package:flutter/material.dart';

import '../../../../config/enum/app_env.enum.dart';
import '../monitoring.enum.dart';
import '../monitoring/datadog.dart';

@immutable
abstract final class DatadogAnalytics {
  /// call in [App.setup]
  static setup({required AppEnvironment env}) => Datadog.init(env: env);

  static Future<void> clear() async {
    await setUser(userId: null);
  }

  static DatadogLogger? _logger;
  static Future<void> logEvent<T>({
    required AnalyticsEvent event,
    Map<String, dynamic>? data,
  }) async {
    // logEvent(eventName: eventName, data: data);

    _logger ??= package.DatadogSdk.instance.logs?.createLogger(
      DatadogLoggerConfiguration(
        remoteLogThreshold: LogLevel.info,
      ),
    );

    _logger?.info(
      event.name,
      attributes: data != null ? Map<String, Object?>.from(data) : {},
    );
  }

  static Future<void> setUser({String? userId}) async {
    package.DatadogSdk.instance.setUserInfo(id: userId);
  }
}

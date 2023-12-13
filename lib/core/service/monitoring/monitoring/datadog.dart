import 'package:datadog_flutter_plugin/datadog_flutter_plugin.dart';
import 'package:flutter/foundation.dart';

import '../../../../config/constant/env.constant.dart';
import '../../../../config/enum/app_env.enum.dart';
import '../../../utility/logger.dart';

@immutable
abstract final class Datadog {
  static bool _isInitialized = false;

  static bool get isInitialized => _isInitialized;

  // When the app is in the background and
  //  opened directly from the push notification.
  static Future<void> init({required AppEnvironment env}) async {
    try {
      DatadogSdk.instance.sdkVerbosity = Verbosity.verbose;
      await DatadogSdk.instance.initialize(DdSdkConfiguration(
        clientToken: EnvConstant.datadogClientToken,
        env: env.name,
        site: DatadogSite.us1,
        trackingConsent: TrackingConsent.granted,
        nativeCrashReportEnabled: true,
        loggingConfiguration: LoggingConfiguration(),
        rumConfiguration: RumConfiguration(
          applicationId: EnvConstant.datadogApplicationId,
        ),
      ));
      _isInitialized = true;
    } catch (e, s) {
      logger.error('Datadog', e: e, s: s);
    }
  }
}

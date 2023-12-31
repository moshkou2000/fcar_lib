import 'package:flutter/foundation.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../../../config/constant/env.constant.dart';
import '../../../../config/enum/app_env.enum.dart';
import '../../../utility/logger.dart';

@immutable
abstract final class Sentry {
  static bool _isInitialized = false;

  static bool get isInitialized => _isInitialized;

  // When the app is in the background and opened directly from the push notification.
  static Future<void> init({required AppEnvironment env}) async {
    try {
      await SentryFlutter.init((options) {
        // options.addInAppInclude('sentry_flutter_example');
        options.attachScreenshot = false;
        options.attachThreads = true;
        options.attachViewHierarchy = true;
        options.considerInAppFramesByDefault = false;
        options.debug = false;
        // options.diagnosticLevel = SentryLevel.error;
        options.dsn = EnvConstant.sentryDsn;
        options.enableWindowMetricBreadcrumbs = true;
        options.environment = env.name;
        options.maxRequestBodySize = MaxRequestBodySize.always;
        options.maxResponseBodySize = MaxResponseBodySize.always;
        options.reportPackages = false;
        options.reportSilentFlutterErrors = true;
        options.screenshotQuality = SentryScreenshotQuality.low;
        options.sendDefaultPii = false;
        options.tracesSampleRate = 1.0;
      });
      _isInitialized = true;
    } catch (e, s) {
      logger.error('Sentry', e: e, s: s);
    }
  }
}

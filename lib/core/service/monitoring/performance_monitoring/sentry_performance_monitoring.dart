import 'package:flutter/foundation.dart';

import '../../../../config/enum/app_env.enum.dart';
import '../monitoring/sentry.dart';

@immutable
abstract final class SentryPerformanceMonitoring {
  /// call in [App.setup]
  static setup({required AppEnvironment env}) => Sentry.init(env: env);
}

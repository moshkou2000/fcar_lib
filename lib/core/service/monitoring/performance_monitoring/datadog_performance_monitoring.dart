import 'package:flutter/foundation.dart';

import '../../../../config/enum/app_env.enum.dart';
import '../monitoring/datadog.dart';

@immutable
abstract final class DatadogPerformanceMonitoring {
  /// call in [App.setup]
  static setup({required AppEnvironment env}) => Datadog.init(env: env);
}

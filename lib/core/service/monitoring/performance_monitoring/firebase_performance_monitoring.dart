import 'package:flutter/foundation.dart';

import '../../../../config/enum/app_env.enum.dart';
import '../monitoring/firebase.dart';

@immutable
abstract final class FirebasePerformanceMonitoring {
  /// call in [App.setup]
  static setup({required AppEnvironment env}) => Firebase.init(env: env);
}

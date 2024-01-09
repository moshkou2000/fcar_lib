import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

/// Follow the instructions,
/// [Android & iOS integration](https://pub.dev/packages/permission_handler)
///
@immutable
abstract final class Permissions {
  /// To request a [permission].
  /// Call [request] in a try/catch block.
  /// If it has already been granted before, nothing happens.
  /// Returns the new [PermissionStatus].
  ///
  /// - Call [callIfDenied] when permission is denied.
  /// - Call [callIfGranted] when permission is granted.
  /// - Call [calltIfPermanentlyDenied] when permission is permanentlyDenied.
  ///   - [openAppSettings] will be called when [calltIfPermanentlyDenied] is null and [calltIfPermanentlyDenied] is true.
  static Future<PermissionStatus> request<T>(
    Permission permission, {
    Function()? callIfDenied,
    Function()? callIfGranted,
    Function()? callIfPermanentlyDenied,
    bool openAppSettingsIfpermanentlyDenied = true,
  }) async {
    final value = await permission.request();
    if (value == PermissionStatus.granted) {
      callIfGranted?.call();
    } else if (value == PermissionStatus.denied) {
      callIfDenied?.call();
    } else if (value == PermissionStatus.permanentlyDenied) {
      if (callIfPermanentlyDenied != null) {
        callIfPermanentlyDenied.call();
      } else if (openAppSettingsIfpermanentlyDenied == true) {
        openAppSettings();
      }
    }
    // else if (value == PermissionStatus.limited) {
    // } else if (value == PermissionStatus.provisional) {
    // } else if (value == PermissionStatus.restricted) {
    // } else {}
    return value;
  }

  /// It returns TRUE when
  /// - [serviceStatus] is null
  /// - [serviceStatus] is not null and [permission] is [PermissionWithService]
  ///   - phone: Android only
  ///   - bluetooth:
  ///   - location: Android: Fine and Coarse Location, iOS: CoreLocation (Always and WhenInUse)
  ///   - locationWhenInUse: Android: Fine and Coarse Location, iOS: CoreLocation (Always and WhenInUse)
  static bool withService(
    Permission permission, {
    required ServiceStatus? serviceStatus,
  }) =>
      serviceStatus == null || permission is PermissionWithService;
}

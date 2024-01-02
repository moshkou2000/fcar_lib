import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:local_auth/local_auth.dart';

import '../../../utility/logger.dart';

/// Authenticates the user with biometrics, pin, pattern, passcode
/// if available on the device.
@immutable
abstract final class LocalAuth {
  static final _auth = LocalAuthentication();

  /// It's true if device is capable of checking biometrics.
  static bool? isSupported;

  /// List of enrolled biometrics.
  static List<BiometricType>? availableBiometrics;

  /// call in [App.init]
  static Future<void> init() async {
    try {
      isSupported = await _auth.canCheckBiometrics;
      availableBiometrics = await _auth.getAvailableBiometrics();
    } catch (_) {}

    logger.debug(
        'LocalAuth isSupported: ${LocalAuth.isSupported}\n availableBiometrics: ${LocalAuth.availableBiometrics}');
  }

  /// [biometricOnly] Prevent authentications from using non-biometric
  /// such as pin, passcode, or pattern.
  ///
  /// [title] is the message to show to user while prompting them
  /// for authentication.
  static Future<bool> authenticate({
    bool biometricOnly = false,
    String title = 'Let OS determine authentication method',
  }) async {
    try {
      return await _auth.authenticate(
        localizedReason: title,
        options: AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: biometricOnly,
        ),
      );
    } catch (_) {
      return false;
    }
  }

  /// Cancels any in-progress authentication.
  /// Returns true if auth was cancelled successfully.
  static Future<void> cancelAuthentication() async {
    await _auth.stopAuthentication();
  }
}

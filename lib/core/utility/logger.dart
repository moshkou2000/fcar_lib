import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

/// Example
///
/// logger.trace(data);         static configuration messages
/// logger.info(message);       informational messages
/// logger.warning(message);    potential problems
///
/// logger.error(message, e: e, s: s);      serious failures + error & StackTrace
/// logger.debug(message, e: e, s: s);      debug info + error & StackTrace
final logger = _Log();

@immutable
final class _Log {
  final _logger = Logger(printer: PrettyPrinter());
  final _loggerNoStack = Logger(printer: PrettyPrinter(methodCount: 0));

  /// static configuration messages
  void trace(dynamic message) {
    if (kDebugMode) _loggerNoStack.t(message);
  }

  /// informational messages
  void info(dynamic message) {
    if (kDebugMode) _loggerNoStack.i(message);
  }

  /// potential problems
  void warning(dynamic message) {
    if (kDebugMode) _loggerNoStack.i(message);
  }

  /// serious failures + error & StackTrace
  void error(
    dynamic message, {
    DateTime? t,
    Object? e,
    StackTrace? s,
  }) {
    if (kDebugMode) _logger.i(message, time: t, error: e, stackTrace: s);
  }

  /// debug info + error & StackTrace
  void debug(
    dynamic message, {
    DateTime? t,
    Object? e,
    StackTrace? s,
  }) {
    if (kDebugMode) _logger.d(message, time: t, error: e, stackTrace: s);
  }
}

import 'package:flutter/material.dart';

@immutable
abstract final class EnvConstant {
  static const String datadogClientToken =
      String.fromEnvironment('ANALYTICS_API_KEY');
  static const String datadogApplicationId =
      String.fromEnvironment('ANALYTICS_API_KEY');
  static const String sentryDsn = String.fromEnvironment('ABC_API_KEY');
}

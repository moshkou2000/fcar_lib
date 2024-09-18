import 'package:flutter/material.dart';

@immutable
abstract final class RobotoFont {
  static const fontFamily = 'Roboto';
  static const textStyle = TextStyle(fontFamily: fontFamily);

  static final titleStyle = titleMedium;
  static final subtitleStyle = titleSmall;
  static final buttonTextStyle = labelLarge;

  static final displayLarge =
      textStyle.copyWith(fontSize: 96, fontWeight: FontWeight.w300);
  static final displayMedium =
      textStyle.copyWith(fontSize: 60, fontWeight: FontWeight.w300);
  static final displaySmall =
      textStyle.copyWith(fontSize: 48, fontWeight: FontWeight.w400);
  static final headlineLarge =
      textStyle.copyWith(fontSize: 34, fontWeight: FontWeight.w400);
  static final headlineMedium =
      textStyle.copyWith(fontSize: 34, fontWeight: FontWeight.w400);
  static final headlineSmall =
      textStyle.copyWith(fontSize: 24, fontWeight: FontWeight.w400);
  static final titleLarge =
      textStyle.copyWith(fontSize: 32, fontWeight: FontWeight.w500);
  static final titleMedium =
      textStyle.copyWith(fontSize: 28, fontWeight: FontWeight.w400);
  static final titleSmall =
      textStyle.copyWith(fontSize: 24, fontWeight: FontWeight.w500);
  static final bodyLarge =
      textStyle.copyWith(fontSize: 20, fontWeight: FontWeight.w400);
  static final bodyMedium =
      textStyle.copyWith(fontSize: 18, fontWeight: FontWeight.w400);
  static final bodySmall =
      textStyle.copyWith(fontSize: 16, fontWeight: FontWeight.w400);
  static final labelLarge =
      textStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w500);
  static final labelMedium =
      textStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w400);
  static final labelSmall =
      textStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400);
}

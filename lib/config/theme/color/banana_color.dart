/// Reference in color.dart
///
import 'package:flutter/material.dart';

@immutable
abstract class BananaColor {
  final primary = Colors.yellow;
  final onPrimary = const Color(0xFF3D82C3);
  final primaryContainer = const Color(0xFF173559);
  final onPrimaryContainer = const Color(0xFF998F01);

  final secondary = const Color(0xffac3306);
  final onSecondary = const Color(0xFFB6AA01);
  final secondaryContainer = const Color(0xffffdbcf);
  final onSecondaryContainer = const Color(0xFF8C3D0E);

  final tertiary = const Color(0xff006875);
  final onTertiary = const Color(0xFFE9D900);
  final tertiaryContainer = const Color(0xFF7DD6B0);
  final onTertiaryContainer = const Color(0xFFFFEE00);

  final error = const Color(0xFF92192C);
  final onError = const Color(0xFFBB2020);
  final errorContainer = const Color(0xFFECF3F9);

  final background = const Color(0xffffffff);
  final onBackground = const Color(0xffffffff);

  final surface = const Color(0xff141617);
  final onSurface = const Color(0xff141617);
  final surfaceVariant = const Color(0xff181b1e);
  final onSurfaceVariant = const Color(0xff181b1e);

  final inverseSurface = const Color(0xfffcfdff);
  final inversePrimary = const Color(0xff506273);
  final outline = const Color(0xff959999);
  final shadow = const Color(0xff000000);
  final overlay = const Color.fromRGBO(0, 0, 0, 0.6);

  final statusBarColor = Colors.yellow;
  final navigationBarColor = Colors.yellow;

  final button = Colors.blue[300];
  final onButton = Colors.blue[600];
  final buttonContainer = Colors.black38;
  final onButtonContainer = Colors.black54;
}

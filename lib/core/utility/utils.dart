import 'package:flutter/material.dart';

import '../../config/extension/context.extension.dart';

DateTime currentBackPressTime =
    DateTime.now().subtract(const Duration(seconds: 20));

Future<bool> onWillPopExit({required BuildContext context}) {
  var now = DateTime.now();
  if (now.difference(currentBackPressTime) > const Duration(seconds: 2)) {
    currentBackPressTime = now;

    context.showSnackBar('Press again the button to exit');
    return Future.value(false);
  }
  context.hideSnackBar();
  return Future.value(true);
}

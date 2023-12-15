import 'package:flutter/material.dart';

import '../../config/extension/context.extension.dart';

/// It's about dismissing a widget in Flutter.
/// Set [attemptToPop] true or pass condition [canPop]
class WillPop extends StatefulWidget {
  /// Creates a widget that registers a callback to veto attempts by the user to
  /// dismiss the enclosing [ModalRoute].
  /// The widget will skip the pop when [canPop] is [null] and [attemptToPop] is [false]
  const WillPop({
    required this.child,
    this.canPop,
    this.attemptToPop = false,
    super.key,
  });

  /// It will confirm to pop when attempt less than 3 seconds.
  /// It will avoid [canPop] when [attemptToPop] is true
  final bool attemptToPop;

  /// The condition to confirm veto attempts by the user to
  /// dismiss the enclosing [ModalRoute].
  final bool Function()? canPop;

  /// The widget below this widget in the tree.
  final Widget child;

  @override
  State<WillPop> createState() => _WillPopState();
}

class _WillPopState extends State<WillPop> implements PopEntry {
  ModalRoute<dynamic>? _route;
  DateTime? _backPressTime =
      DateTime.now().subtract(const Duration(seconds: 20));

  @override
  PopInvokedCallback? onPopInvoked;

  @override
  ValueNotifier<bool> canPopNotifier = ValueNotifier<bool>(false);

  @override
  void initState() {
    onPopInvoked = (bool didPop) {
      final canPop = widget.attemptToPop
          ? _attemptToPop(context)
          : widget.canPop?.call() ?? false;
      if (canPop) canPopNotifier.value = true;
    };
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final nextRoute = ModalRoute.of(context);
    if (nextRoute != _route) {
      _route?.unregisterPopEntry(this);
      _route = nextRoute;
      _route?.registerPopEntry(this);
    }
  }

  @override
  Widget build(BuildContext context) => widget.child;

  @override
  void dispose() {
    _route?.unregisterPopEntry(this);
    canPopNotifier.dispose();
    super.dispose();
  }

  bool _attemptToPop(BuildContext context) {
    var now = DateTime.now();
    if (_backPressTime != null &&
        now.difference(_backPressTime!) > const Duration(seconds: 2)) {
      _backPressTime = now;

      context.showSnackBar('Press again the button to exit');
      return false;
    }
    context.hideSnackBar();
    return true;
  }
}

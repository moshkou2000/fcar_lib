import 'package:flutter/material.dart';

@immutable
abstract final class Navigation {
  static final GlobalKey<NavigatorState> navigationKey =
      GlobalKey<NavigatorState>();

  static BuildContext? get context =>
      navigationKey.currentState?.overlay?.context;

  static Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    return navigationKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  static void pop({dynamic result}) {
    return navigationKey.currentState?.pop(result);
  }

  static Future<dynamic> popAndPushTo(String routeName, {dynamic arguments}) {
    return navigationKey.currentState!
        .popAndPushNamed(routeName, arguments: arguments);
  }

  static void popUntil({String? popUntilNamed}) {
    if (popUntilNamed != null) {
      Future.microtask(() => navigationKey.currentState!
          .popUntil(ModalRoute.withName(popUntilNamed)));
    } else {
      Future.microtask(
          () => navigationKey.currentState!.popUntil((route) => route.isFirst));
    }
  }

  /// if removeUntilNamed is null,
  /// remove all screen and make [pushNamed] screen become root
  static Future<dynamic> pushAndRemoveUntil(
    String pushNamed, {
    String? removeUntilNamed,
    Object? arguments,
  }) async {
    if (removeUntilNamed != null) {
      return navigationKey.currentState!.pushNamedAndRemoveUntil(
        pushNamed,
        ModalRoute.withName(removeUntilNamed),
        arguments: arguments,
      );
    } else {
      return navigationKey.currentState!.pushNamedAndRemoveUntil(
        pushNamed,
        (route) => false,
        arguments: arguments,
      );
    }
  }

  static Future<T?> openPage<T extends Object?>(Widget page) {
    return navigationKey.currentState!
        .push<T>(TagRoute(builder: (_) => page, tag: page.runtimeType));
  }
}

class TagRoute<T> extends MaterialPageRoute<T> {
  final dynamic tag;

  TagRoute({
    required WidgetBuilder builder,
    this.tag,
    RouteSettings? settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
  }) : super(
          builder: builder,
          settings: settings,
          maintainState: maintainState,
          fullscreenDialog: fullscreenDialog,
        );
}

import 'package:sentry_flutter/sentry_flutter.dart';

final class SentryNavigatorObservers extends SentryNavigatorObserver {
  SentryNavigatorObservers() : super(setRouteNameAsTransaction: true);
}

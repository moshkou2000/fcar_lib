import 'package:firebase_analytics/firebase_analytics.dart';

final class FirebaseNavigatorObservers extends FirebaseAnalyticsObserver {
  FirebaseNavigatorObservers() : super(analytics: FirebaseAnalytics.instance);
}

import 'package:datadog_flutter_plugin/datadog_flutter_plugin.dart';

class DatadogNavigatorObservers extends DatadogNavigationObserver {
  DatadogNavigatorObservers() : super(datadogSdk: DatadogSdk.instance);
}

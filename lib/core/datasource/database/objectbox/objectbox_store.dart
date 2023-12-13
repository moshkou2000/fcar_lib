import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../../../objectbox.g.dart';
import '../../../utility/logger.dart';
import '../collection.dart';
import '../database.dart';
import '../database.enum.dart';
import 'objectbox.dart';

class ObjectboxStore extends IDatabase {
  static ObjectboxStore? _singleton;
  factory ObjectboxStore({
    required DatabaseName databaseName,
  }) {
    _singleton ??= ObjectboxStore._internal(databaseName: databaseName);
    return _singleton!;
  }
  ObjectboxStore._internal({
    required DatabaseName databaseName,
  }) : super(databaseType: DatabaseType.objectbox, databaseName: databaseName);

  Store? _objectboxStore;

  /// The best time to initialize ObjectBox is when your app starts.
  /// call in [App.setup]
  @override
  Future<void> setup() async {
    final store = await _createStore();
    if (store != null) {
      _objectboxStore = store;
      logger.info('ObjectboxStore created [$databaseName] store');
    }
  }

  @override
  void closeDatabase() {
    _objectboxStore?.close();
  }

  @override
  ICollection<T>? getCollection<T>() =>
      _objectboxStore != null ? Objectbox<T>(store: _objectboxStore!) : null;

  /// Create an instance of ObjectBox to use throughout the app.
  Future<Store?> _createStore() async {
    try {
      final directory = await getDatabasePath();
      // openStore() is defined in the generated objectbox.g.dart
      return await openStore(directory: directory);
    } catch (e, s) {
      logger.error('database [${databaseName.name}]', e: e, s: s);
      // ErrorTracking.recordError(
      //   e,
      //   s,
      //   reason: 'ObjectboxStore._createStore database(${databaseName.name})',
      // );
    }
    return null;
  }
}

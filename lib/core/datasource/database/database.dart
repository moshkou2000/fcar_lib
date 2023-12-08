import 'dart:io';

import 'package:path_provider/path_provider.dart';

import 'collection.dart';
import 'database.enum.dart';

/// Use it internally
/// All databases that used as provider must implement [IDatabase].
/// modify [IDatabase] based on your need.
abstract class IDatabase {
  final DatabaseType databaseType;
  final DatabaseName databaseName;
  IDatabase({required this.databaseType, required this.databaseName});

  Future<void> setup();
  void closeDatabase();
  ICollection<T>? getCollection<T>();

  Future<bool> deleteDatabaseFile() async {
    final directory = await getDatabasePath();
    final f = File(directory);
    if (f.existsSync()) {
      f.deleteSync();
      return true;
    }
    return false;
  }

  Future<String> getDatabasePath() async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/db/${databaseType.name}/${databaseName.name}';
  }
}

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../keystore.dart';
import '../keystore.enum.dart';

/// The base methods
/// to _read & write bool, int, double & string
/// and also remove data or clear the storage
/// All the derived classes use the same storage [_storage]
class SecureStorage implements IKeystore {
  SecureStorage({required this.keystoreName});

  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  @override
  String keystoreName;

  @override
  Future<void> clear() async => await _deleteAll();

  @override
  Future<dynamic> read<T>({required KeystoreKey key}) async {
    if (T is bool) {
      return await _readBool(key.name);
    } else if (T is String) {
      return await _readString(key.name);
    } else if (T is int) {
      return await _readInt(key.name);
    } else if (T is double) {
      return await _readDouble(key.name);
    }

    return await _readString(key.name);
  }

  @override
  Future<void> remove({required KeystoreKey key}) async =>
      await _delete(key.name);

  @override
  Future<void> save({required KeystoreKey key, required String value}) async =>
      await _write(key.name, value);

  Future<bool?> _readBool(String key, {bool useOriginalKey = false}) async {
    final value = await _storage.read(key: _fixKey(key, useOriginalKey));
    return value == null ? null : bool.tryParse(value, caseSensitive: false);
  }

  Future<int?> _readInt(String key, {bool useOriginalKey = false}) async {
    final value = await _storage.read(key: _fixKey(key, useOriginalKey));
    return value == null ? null : int.tryParse(value);
  }

  Future<double?> _readDouble(String key, {bool useOriginalKey = false}) async {
    final value = await _storage.read(key: _fixKey(key, useOriginalKey));
    return value == null ? null : double.tryParse(value);
  }

  Future<String?> _readString(String key,
          {bool useOriginalKey = false}) async =>
      await _storage.read(key: _fixKey(key, useOriginalKey));

  Future<void> _write(
    String key,
    String value, {
    bool useOriginalKey = false,
  }) async =>
      await _storage.write(key: _fixKey(key, useOriginalKey), value: value);

  Future<void> _delete(String key, {bool useOriginalKey = false}) async =>
      await _storage.delete(key: _fixKey(key, useOriginalKey));

  Future<void> _deleteAll() async => await _storage.deleteAll();

  String _fixKey(key, bool useOriginalKey) =>
      useOriginalKey ? key : '${keystoreName}_$key';
}

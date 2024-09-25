import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../keystore.dart';

/// The base methods
/// to _read & write bool, int, double & string
/// and also remove data or clear the storage
/// All the derived classes use the same storage [_storage]
class SecureStorage implements IKeystore {
  SecureStorage({required this.keystoreName});

  static const FlutterSecureStorage _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock,
    ),
  );

  @override
  String keystoreName;

  @override
  Future<void> clear() async => await _deleteAll();

  @override
  Future<dynamic> read<T>({required String key}) async {
    if (T is bool) {
      return await _readBool(key);
    } else if (T is String) {
      return await _readString(key);
    } else if (T is int) {
      return await _readInt(key);
    } else if (T is double) {
      return await _readDouble(key);
    }

    return await _readString(key);
  }

  @override
  Future<void> remove({required String key}) async => await _delete(key);

  @override
  Future<void> save({required String key, required String value}) async =>
      await _write(key, value);

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

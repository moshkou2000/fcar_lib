/// All Keystore datasources that used as provider must implement [IKeystore]
/// modify [IDatabase] based on your need.
abstract class IKeystore {
  final String keystoreName;

  // ex: keystoreName = KeystoreName.appKeystore.name
  IKeystore({required this.keystoreName});

  Future<void> clear();

  /// return type is bool, String, int, double
  ///
  /// Use json decoded to convert to your model.
  ///
  /// [key] can be KeystoreKey.abc.name
  ///
  /// Implement [fromJson] in your model
  ///   PlayerModel.fromJson(String source)
  Future<dynamic> read<T>({required String key});

  /// [key] can be KeystoreKey.abc.name
  Future<void> remove({required String key});

  /// Use json encoded to convert your model to String.
  ///
  /// [key] can be KeystoreKey.abc.name
  ///
  /// Implement [toJson] in your model
  ///   String toJson() => json.encode(toMap());
  Future<void> save({required String key, required String value});
}

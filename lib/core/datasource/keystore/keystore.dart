import 'keystore.enum.dart';

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
  /// Implement [fromJson] in your model 
  ///   PlayerModel.fromJson(String source)
  Future<dynamic> read<T>({required KeystoreKey key});
  Future<void> remove({required KeystoreKey key});

  /// Use json encoded to convert your model to String.
  /// 
  /// Implement [toJson] in your model
  ///   String toJson() => json.encode(toMap());
  Future<void> save({required KeystoreKey key, required String value});
}

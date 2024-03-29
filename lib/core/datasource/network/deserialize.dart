/// Export from [network.provider.dart]
///
class Deserialize<T> {
  final List<T> items = [];
  T? item;

  /// [items] when json[key] is List.
  ///
  /// [item] when json[key] is not a list.
  ///
  /// [json] is the serialized data.
  ///
  /// [key] is 'data' by default (can be changed if needed).
  ///
  /// [requiredFields] to make sure that the response contains the required keys.
  /// Example -> requiredFields: ['token', 'refreshToken', 'username', 'displayname'],
  ///
  /// [fromMap] is required when json[key] is List<Map<String, dynamic>> or Map<String, dynamic>.
  /// Use it this way -> fromMap: (e, {callback}) => AuthModel.fromMap(e),
  ///
  /// [callback] is to return the missing keys based on [requiredFields].
  /// Use it this way -> callback: (missingKeys) => throw Exception(missingKeys),
  Deserialize(
    dynamic json, {
    String key = 'data',
    T Function(
      Map<String, dynamic>, {
      Function(Map<String, List<String>>)? callback,
    })? fromMap,
    List<String> requiredFields = const [],
    Function(Map<String, List<String>>)? callback,
  }) {
    final missingKeys = <String>[];
    final dynamic j = json[key];
    if (j == null) {
      missingKeys.add(key);
    } else if (j is Map<String, dynamic>) {
      assert(fromMap != null);
      if (_isValid(j, requiredFields, missingKeys)) {
        item = fromMap!(j, callback: callback);
      }
    } else if (j is List<dynamic>) {
      for (final e in j) {
        if (e != null) {
          if (e is Map<String, dynamic>) {
            assert(fromMap != null);
            if (_isValid(e, requiredFields, missingKeys)) {
              items.add(fromMap!(e, callback: callback));
            }
          } else if (e is T) {
            items.add(e);
          } else {
            if (!missingKeys.contains(key)) missingKeys.add(key);
          }
        }
      }
    } else if (j is T) {
      item = j;
    }

    if (missingKeys.isNotEmpty) {
      if (callback != null) callback({key: missingKeys});
    }
  }

  bool _isValid(
    dynamic json,
    List<String> requiredFields,
    List<String> missingKeys,
  ) {
    if (json == null) return false;
    if (requiredFields.isEmpty) return true;
    final invalid = requiredFields
        .where((e) => e.trim().isNotEmpty && json[e] == null)
        .toList();
    if (invalid.isNotEmpty) {
      for (final s in invalid) {
        if (!missingKeys.contains(s)) {
          missingKeys.add(s);
        }
      }
    }

    return invalid.isEmpty;
  }
}

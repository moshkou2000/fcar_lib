import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

import '../../../../../objectbox.g.dart';
import '../../../database/collection.dart';
import '../../../database/database.dart';
import 'dio_cache.model.dart.dart';

/// The database must exist
/// Use it in the Dio Interceptor
///
/// databaseType: DatabaseType.objectbox
/// databaseName: DatabaseName.networkCache
class DioCache extends CacheStore {
  static DioCache? _singleton;
  factory DioCache({required IDatabase database}) {
    if (_singleton == null) {
      _singleton = DioCache._internal(database: database);
      _singleton!._database = database;
      _singleton!._cache = database.getCollection<CacheResponseModel>();
      _singleton!.clean(staleOnly: true);
    }
    return _singleton!;
  }
  DioCache._internal({required IDatabase database});

  late ICollection<CacheResponseModel>? _cache;
  late IDatabase _database;

  @override
  Future<void> clean({
    CachePriority priorityOrBelow = CachePriority.high,
    bool staleOnly = false,
  }) async {
    await _cache?.removeAll();
  }

  @override
  Future<void> close() async {
    _database.closeDatabase();
  }

  @override
  Future<void> delete(String key, {bool staleOnly = false}) async {
    await _cache?.removeMany(condition: CacheResponseModel_.key.equals(key));
  }

  @override
  Future<void> deleteFromPath(
    RegExp pathPattern, {
    Map<String, String?>? queryParams,
  }) async {
    _getFromPath(
      pathPattern,
      queryParams: queryParams,
      onResponseMatch: (r) => _cache?.removeById(r.id),
    );
  }

  @override
  Future<bool> exists(String key) async {
    return await _cache?.loadOne(
            condition: CacheResponseModel_.key.equals(key)) !=
        null;
  }

  @override
  Future<CacheResponse?> get(String key) async {
    //CacheResponseModel
    final reeult =
        await _cache?.loadOne(condition: CacheResponseModel_.key.equals(key));
    return reeult?.toObject();
  }

  @override
  Future<List<CacheResponse>> getFromPath(
    RegExp pathPattern, {
    Map<String, String?>? queryParams,
  }) async {
    final responses = <CacheResponse>[];

    await _getFromPath(
      pathPattern,
      queryParams: queryParams,
      onResponseMatch: (r) => responses.add(r.toObject()),
    );

    return responses;
  }

  @override
  Future<void> set(CacheResponse response) async {
    await delete(response.key);
    _cache?.saveOne(CacheResponseModel.fromObject(response));
  }

  Future<void> _getFromPath(
    RegExp pathPattern, {
    required void Function(CacheResponseModel) onResponseMatch,
    Map<String, String?>? queryParams,
  }) async {
    final results = <CacheResponseModel>[];
    const limit = 10;
    var offset = 0;

    do {
      final c =
          await _cache?.loadMany(condition: null, limit: limit, offset: offset);
      if (c != null) {
        results.addAll(c);

        for (final result in results) {
          if (pathExists(result.url, pathPattern, queryParams: queryParams)) {
            onResponseMatch.call(result);
          }
        }

        offset += limit;
      }
    } while (results.isNotEmpty);
  }
}

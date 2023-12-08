// GENERATED CODE - DO NOT MODIFY BY HAND
// This code was generated by ObjectBox. To update it run the generator again:
// With a Flutter package, run `flutter pub run build_runner build`.
// With a Dart package, run `dart run build_runner build`.
// See also https://docs.objectbox.io/getting-started#generate-objectbox-code

// ignore_for_file: camel_case_types, depend_on_referenced_packages
// coverage:ignore-file

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import 'core/datasource/network/dio/cache/dio_cache.model.dart.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(1, 8664683768033854703),
      name: 'CacheControlModel',
      lastPropertyId: const IdUid(17, 7656315151250230401),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 3297420068208542037),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(10, 6330258075200319495),
            name: 'maxAge',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(11, 5970389401713999105),
            name: 'privacy',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(12, 2668054403094859480),
            name: 'noCache',
            type: 1,
            flags: 0),
        ModelProperty(
            id: const IdUid(13, 4027432476080357248),
            name: 'noStore',
            type: 1,
            flags: 0),
        ModelProperty(
            id: const IdUid(14, 6646321955115321896),
            name: 'other',
            type: 30,
            flags: 0),
        ModelProperty(
            id: const IdUid(15, 8714912528830973379),
            name: 'maxStale',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(16, 1727332978743205770),
            name: 'minFresh',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(17, 7656315151250230401),
            name: 'mustRevalidate',
            type: 1,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(2, 1985224559232822902),
      name: 'CacheResponseModel',
      lastPropertyId: const IdUid(24, 8417590285244966023),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 3057539949658184639),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(8, 404049124804983934),
            name: 'data',
            type: 23,
            flags: 0),
        ModelProperty(
            id: const IdUid(14, 4942699779215742082),
            name: 'key',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(15, 7544173203681451253),
            name: 'url',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(16, 3878590240988197668),
            name: 'eTag',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(17, 6689038165101560248),
            name: 'lastModified',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(18, 2866023695724199395),
            name: 'headers',
            type: 23,
            flags: 0),
        ModelProperty(
            id: const IdUid(19, 3411613860087392224),
            name: 'content',
            type: 27,
            flags: 0),
        ModelProperty(
            id: const IdUid(20, 2577852731522089511),
            name: 'date',
            type: 10,
            flags: 0),
        ModelProperty(
            id: const IdUid(21, 7219379816616753381),
            name: 'expires',
            type: 10,
            flags: 0),
        ModelProperty(
            id: const IdUid(22, 1669317146070183453),
            name: 'maxStale',
            type: 10,
            flags: 0),
        ModelProperty(
            id: const IdUid(23, 3660722790955198604),
            name: 'responseDate',
            type: 10,
            flags: 0),
        ModelProperty(
            id: const IdUid(24, 8417590285244966023),
            name: 'requestDate',
            type: 10,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[])
];

/// Shortcut for [Store.new] that passes [getObjectBoxModel] and for Flutter
/// apps by default a [directory] using `defaultStoreDirectory()` from the
/// ObjectBox Flutter library.
///
/// Note: for desktop apps it is recommended to specify a unique [directory].
///
/// See [Store.new] for an explanation of all parameters.
Future<Store> openStore(
        {String? directory,
        int? maxDBSizeInKB,
        int? fileMode,
        int? maxReaders,
        bool queriesCaseSensitiveDefault = true,
        String? macosApplicationGroup}) async =>
    Store(getObjectBoxModel(),
        directory: directory ?? (await defaultStoreDirectory()).path,
        maxDBSizeInKB: maxDBSizeInKB,
        fileMode: fileMode,
        maxReaders: maxReaders,
        queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
        macosApplicationGroup: macosApplicationGroup);

/// Returns the ObjectBox model definition for this project for use with
/// [Store.new].
ModelDefinition getObjectBoxModel() {
  final model = ModelInfo(
      entities: _entities,
      lastEntityId: const IdUid(2, 1985224559232822902),
      lastIndexId: const IdUid(0, 0),
      lastRelationId: const IdUid(0, 0),
      lastSequenceId: const IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [],
      retiredPropertyUids: const [
        3078470433324194335,
        1204192575710174043,
        1722665559135320630,
        4700251110201221023,
        8853951652129845827,
        5043652711684489438,
        6442187466038397838,
        9155438344603019014,
        279074078424168085,
        4399122621212609387,
        2783671652962721763,
        5149189156985861262,
        1913743764605655104,
        6129531024742211410,
        3247796034807509794,
        3170962386902782484,
        8106282719586990404,
        4983678701048550576,
        860647273497819931
      ],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, EntityDefinition>{
    CacheControlModel: EntityDefinition<CacheControlModel>(
        model: _entities[0],
        toOneRelations: (CacheControlModel object) => [],
        toManyRelations: (CacheControlModel object) => {},
        getId: (CacheControlModel object) => object.id,
        setId: (CacheControlModel object, int id) {
          object.id = id;
        },
        objectToFB: (CacheControlModel object, fb.Builder fbb) {
          final privacyOffset =
              object.privacy == null ? null : fbb.writeString(object.privacy!);
          final otherOffset = object.other == null
              ? null
              : fbb.writeList(
                  object.other!.map(fbb.writeString).toList(growable: false));
          fbb.startTable(18);
          fbb.addInt64(0, object.id);
          fbb.addInt64(9, object.maxAge);
          fbb.addOffset(10, privacyOffset);
          fbb.addBool(11, object.noCache);
          fbb.addBool(12, object.noStore);
          fbb.addOffset(13, otherOffset);
          fbb.addInt64(14, object.maxStale);
          fbb.addInt64(15, object.minFresh);
          fbb.addBool(16, object.mustRevalidate);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = CacheControlModel()
            ..id = const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0)
            ..maxAge =
                const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 22)
            ..privacy = const fb.StringReader(asciiOptimization: true)
                .vTableGetNullable(buffer, rootOffset, 24)
            ..noCache =
                const fb.BoolReader().vTableGetNullable(buffer, rootOffset, 26)
            ..noStore =
                const fb.BoolReader().vTableGetNullable(buffer, rootOffset, 28)
            ..other = const fb.ListReader<String>(
                    fb.StringReader(asciiOptimization: true),
                    lazy: false)
                .vTableGetNullable(buffer, rootOffset, 30)
            ..maxStale =
                const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 32)
            ..minFresh =
                const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 34)
            ..mustRevalidate =
                const fb.BoolReader().vTableGetNullable(buffer, rootOffset, 36);

          return object;
        }),
    CacheResponseModel: EntityDefinition<CacheResponseModel>(
        model: _entities[1],
        toOneRelations: (CacheResponseModel object) => [],
        toManyRelations: (CacheResponseModel object) => {},
        getId: (CacheResponseModel object) => object.id,
        setId: (CacheResponseModel object, int id) {
          object.id = id;
        },
        objectToFB: (CacheResponseModel object, fb.Builder fbb) {
          final dataOffset =
              object.data == null ? null : fbb.writeListInt8(object.data!);
          final keyOffset = fbb.writeString(object.key);
          final urlOffset = fbb.writeString(object.url);
          final eTagOffset =
              object.eTag == null ? null : fbb.writeString(object.eTag!);
          final lastModifiedOffset = object.lastModified == null
              ? null
              : fbb.writeString(object.lastModified!);
          final headersOffset = object.headers == null
              ? null
              : fbb.writeListInt8(object.headers!);
          final contentOffset = object.content == null
              ? null
              : fbb.writeListInt64(object.content!);
          fbb.startTable(25);
          fbb.addInt64(0, object.id);
          fbb.addOffset(7, dataOffset);
          fbb.addOffset(13, keyOffset);
          fbb.addOffset(14, urlOffset);
          fbb.addOffset(15, eTagOffset);
          fbb.addOffset(16, lastModifiedOffset);
          fbb.addOffset(17, headersOffset);
          fbb.addOffset(18, contentOffset);
          fbb.addInt64(19, object.date?.millisecondsSinceEpoch);
          fbb.addInt64(20, object.expires?.millisecondsSinceEpoch);
          fbb.addInt64(21, object.maxStale?.millisecondsSinceEpoch);
          fbb.addInt64(22, object.responseDate.millisecondsSinceEpoch);
          fbb.addInt64(23, object.requestDate.millisecondsSinceEpoch);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final dateValue =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 42);
          final expiresValue =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 44);
          final maxStaleValue =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 46);
          final object = CacheResponseModel()
            ..id = const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0)
            ..data = const fb.ListReader<int>(fb.Int8Reader(), lazy: false)
                .vTableGetNullable(buffer, rootOffset, 18)
            ..key = const fb.StringReader(asciiOptimization: true)
                .vTableGet(buffer, rootOffset, 30, '')
            ..url = const fb.StringReader(asciiOptimization: true)
                .vTableGet(buffer, rootOffset, 32, '')
            ..eTag = const fb.StringReader(asciiOptimization: true)
                .vTableGetNullable(buffer, rootOffset, 34)
            ..lastModified = const fb.StringReader(asciiOptimization: true)
                .vTableGetNullable(buffer, rootOffset, 36)
            ..headers = const fb.ListReader<int>(fb.Int8Reader(), lazy: false)
                .vTableGetNullable(buffer, rootOffset, 38)
            ..content = const fb.ListReader<int>(fb.Int64Reader(), lazy: false)
                .vTableGetNullable(buffer, rootOffset, 40)
            ..date = dateValue == null
                ? null
                : DateTime.fromMillisecondsSinceEpoch(dateValue)
            ..expires = expiresValue == null
                ? null
                : DateTime.fromMillisecondsSinceEpoch(expiresValue)
            ..maxStale = maxStaleValue == null
                ? null
                : DateTime.fromMillisecondsSinceEpoch(maxStaleValue)
            ..responseDate = DateTime.fromMillisecondsSinceEpoch(
                const fb.Int64Reader().vTableGet(buffer, rootOffset, 48, 0))
            ..requestDate = DateTime.fromMillisecondsSinceEpoch(
                const fb.Int64Reader().vTableGet(buffer, rootOffset, 50, 0));

          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [CacheControlModel] entity fields to define ObjectBox queries.
class CacheControlModel_ {
  /// see [CacheControlModel.id]
  static final id =
      QueryIntegerProperty<CacheControlModel>(_entities[0].properties[0]);

  /// see [CacheControlModel.maxAge]
  static final maxAge =
      QueryIntegerProperty<CacheControlModel>(_entities[0].properties[1]);

  /// see [CacheControlModel.privacy]
  static final privacy =
      QueryStringProperty<CacheControlModel>(_entities[0].properties[2]);

  /// see [CacheControlModel.noCache]
  static final noCache =
      QueryBooleanProperty<CacheControlModel>(_entities[0].properties[3]);

  /// see [CacheControlModel.noStore]
  static final noStore =
      QueryBooleanProperty<CacheControlModel>(_entities[0].properties[4]);

  /// see [CacheControlModel.other]
  static final other =
      QueryStringVectorProperty<CacheControlModel>(_entities[0].properties[5]);

  /// see [CacheControlModel.maxStale]
  static final maxStale =
      QueryIntegerProperty<CacheControlModel>(_entities[0].properties[6]);

  /// see [CacheControlModel.minFresh]
  static final minFresh =
      QueryIntegerProperty<CacheControlModel>(_entities[0].properties[7]);

  /// see [CacheControlModel.mustRevalidate]
  static final mustRevalidate =
      QueryBooleanProperty<CacheControlModel>(_entities[0].properties[8]);
}

/// [CacheResponseModel] entity fields to define ObjectBox queries.
class CacheResponseModel_ {
  /// see [CacheResponseModel.id]
  static final id =
      QueryIntegerProperty<CacheResponseModel>(_entities[1].properties[0]);

  /// see [CacheResponseModel.data]
  static final data =
      QueryByteVectorProperty<CacheResponseModel>(_entities[1].properties[1]);

  /// see [CacheResponseModel.key]
  static final key =
      QueryStringProperty<CacheResponseModel>(_entities[1].properties[2]);

  /// see [CacheResponseModel.url]
  static final url =
      QueryStringProperty<CacheResponseModel>(_entities[1].properties[3]);

  /// see [CacheResponseModel.eTag]
  static final eTag =
      QueryStringProperty<CacheResponseModel>(_entities[1].properties[4]);

  /// see [CacheResponseModel.lastModified]
  static final lastModified =
      QueryStringProperty<CacheResponseModel>(_entities[1].properties[5]);

  /// see [CacheResponseModel.headers]
  static final headers =
      QueryByteVectorProperty<CacheResponseModel>(_entities[1].properties[6]);

  /// see [CacheResponseModel.content]
  static final content = QueryIntegerVectorProperty<CacheResponseModel>(
      _entities[1].properties[7]);

  /// see [CacheResponseModel.date]
  static final date =
      QueryIntegerProperty<CacheResponseModel>(_entities[1].properties[8]);

  /// see [CacheResponseModel.expires]
  static final expires =
      QueryIntegerProperty<CacheResponseModel>(_entities[1].properties[9]);

  /// see [CacheResponseModel.maxStale]
  static final maxStale =
      QueryIntegerProperty<CacheResponseModel>(_entities[1].properties[10]);

  /// see [CacheResponseModel.responseDate]
  static final responseDate =
      QueryIntegerProperty<CacheResponseModel>(_entities[1].properties[11]);

  /// see [CacheResponseModel.requestDate]
  static final requestDate =
      QueryIntegerProperty<CacheResponseModel>(_entities[1].properties[12]);
}

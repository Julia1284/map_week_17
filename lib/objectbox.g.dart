// GENERATED CODE - DO NOT MODIFY BY HAND
// This code was generated by ObjectBox. To update it run the generator again:
// With a Flutter package, run `flutter pub run build_runner build`.
// With a Dart package, run `dart run build_runner build`.
// See also https://docs.objectbox.io/getting-started#generate-objectbox-code

// ignore_for_file: camel_case_types
// coverage:ignore-file

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import 'models/position.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(1, 746926193159738834),
      name: 'Position',
      lastPropertyId: const IdUid(3, 3633853476831312419),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 4689781259794568624),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 3752013480731206640),
            name: 'latitude',
            type: 8,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 3633853476831312419),
            name: 'longitude',
            type: 8,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[])
];

/// Open an ObjectBox store with the model declared in this file.
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

/// ObjectBox model definition, pass it to [Store] - Store(getObjectBoxModel())
ModelDefinition getObjectBoxModel() {
  final model = ModelInfo(
      entities: _entities,
      lastEntityId: const IdUid(1, 746926193159738834),
      lastIndexId: const IdUid(0, 0),
      lastRelationId: const IdUid(0, 0),
      lastSequenceId: const IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [],
      retiredPropertyUids: const [],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, EntityDefinition>{
    Position: EntityDefinition<Position>(
        model: _entities[0],
        toOneRelations: (Position object) => [],
        toManyRelations: (Position object) => {},
        getId: (Position object) => object.id,
        setId: (Position object, int id) {
          object.id = id;
        },
        objectToFB: (Position object, fb.Builder fbb) {
          fbb.startTable(4);
          fbb.addInt64(0, object.id);
          fbb.addFloat64(1, object.latitude);
          fbb.addFloat64(2, object.longitude);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = Position(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              latitude:
                  const fb.Float64Reader().vTableGet(buffer, rootOffset, 6, 0),
              longitude:
                  const fb.Float64Reader().vTableGet(buffer, rootOffset, 8, 0));

          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [Position] entity fields to define ObjectBox queries.
class Position_ {
  /// see [Position.id]
  static final id = QueryIntegerProperty<Position>(_entities[0].properties[0]);

  /// see [Position.latitude]
  static final latitude =
      QueryDoubleProperty<Position>(_entities[0].properties[1]);

  /// see [Position.longitude]
  static final longitude =
      QueryDoubleProperty<Position>(_entities[0].properties[2]);
}

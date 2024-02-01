import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive/hive.dart';
import 'package:telestat_test_assignment/features/object_list/data/data_sources/interfaces/object_data_source.dart';
import 'package:telestat_test_assignment/features/object_list/data/exceptions/exceptions.dart';
import 'package:telestat_test_assignment/features/object_list/data/models/object_model.dart';

class HiveConst {
  static const String dbName = 'app_db';
  static const String objectsBox = 'objects';
}

class HiveLocalObjectDataSource implements ObjectDataSource {
  static HiveLocalObjectDataSource? _dataSource;
  final BoxCollection collection;

  HiveLocalObjectDataSource(this.collection);

  static Future<HiveLocalObjectDataSource> getInstance() async {
    _dataSource ??= await _init();
    return _dataSource!;
  }

  static Future<HiveLocalObjectDataSource> _init() async {
    String path = '';
    if (!kIsWeb) {
      final directory = await getApplicationDocumentsDirectory();
      path = directory.path;
    }

    BoxCollection collection = await BoxCollection.open(
      HiveConst.dbName,
      {
        HiveConst.objectsBox,
      },
      path: path,
    );
    return HiveLocalObjectDataSource(collection);
  }

  Future<CollectionBox<Map>> _openObjectBox() async {
    return await collection.openBox<Map>(HiveConst.objectsBox);
  }

  @override
  Future<ObjectModel> createObject(ObjectModel objectModel) async {
    final objectBox = await _openObjectBox();

    await objectBox.put(objectModel.id, objectModel.toJson());
    return objectModel;
  }

  @override
  Future<bool> deleteObjectById(String id) async {
    final objectBox = await _openObjectBox();

    if (await objectBox.get(id) == null) {
      throw ObjectModelNotFoundException(id: id);
    }

    await objectBox.delete(id);
    return true;
  }

  @override
  Future<List<ObjectModel>> readObjects() async {
    final objectBox = await _openObjectBox();

    final maps = await objectBox.getAllValues();

    List<ObjectModel> objects = maps.values
        .map((jsonValue) =>
            ObjectModel.fromJson(jsonValue.cast<String, dynamic>()))
        .toList();
    return objects;
  }

  @override
  Future<ObjectModel> updateObject(ObjectModel objectModel) async {
    final objectBox = await _openObjectBox();
    final String id = objectModel.id;

    if (await objectBox.get(id) == null) {
      throw ObjectModelNotFoundException(id: id);
    }

    await objectBox.put(id, objectModel.toJson());
    return objectModel;
  }
}

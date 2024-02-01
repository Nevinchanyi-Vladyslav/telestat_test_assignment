import 'package:telestat_test_assignment/features/object_list/data/models/object_model.dart';

abstract class ObjectDataSource{
  Future<List<ObjectModel>> readObjects();

  Future<ObjectModel> createObject(ObjectModel objectModel);

  Future<ObjectModel> updateObject(ObjectModel objectModel);

  Future<bool> deleteObjectById(String id);
}
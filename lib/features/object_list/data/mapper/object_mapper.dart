import 'package:telestat_test_assignment/features/object_list/data/models/object_model.dart';
import 'package:telestat_test_assignment/features/object_list/domain/entities/object_entity.dart';

mixin ObjectMapper {
  ObjectEntity fromObjectModel(ObjectModel objectModel) {
    return ObjectEntity(
      id: objectModel.id,
      title: objectModel.title,
      description: objectModel.description,
    );
  }

  ObjectModel fromObjectEntity(ObjectEntity objectEntity) {
    return ObjectModel(
      id: objectEntity.id,
      title: objectEntity.title,
      description: objectEntity.description,
    );
  }
}

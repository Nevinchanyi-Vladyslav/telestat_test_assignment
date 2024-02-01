import 'package:flutter/material.dart';
import 'package:telestat_test_assignment/features/object_list/domain/entities/object_entity.dart';

class ObjectListItem extends StatelessWidget {
  const ObjectListItem({
    super.key,
    required this.object,
    required this.navigateToEdit,
    required this.deleteObject,
  });

  final ObjectEntity object;
  final void Function() navigateToEdit;
  final void Function() deleteObject;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 8,
      ),
      child: ListTile(
        trailing: IconButton(
          onPressed: navigateToEdit,
          icon: const Icon(Icons.edit),
        ),
        title: Text(
          object.title,
        ),
        subtitle: Text(
          object.description,
        ),
        leading: IconButton(
          onPressed: deleteObject,
          icon: const Icon(Icons.delete),
        ),
      ),
    );
  }
}

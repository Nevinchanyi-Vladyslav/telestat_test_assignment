import 'package:uuid/uuid.dart';
import 'package:equatable/equatable.dart';

const Uuid _uuid = Uuid();

class ObjectEntity extends Equatable {
  final String id;
  final String title;
  final String description;

  const ObjectEntity({
    required this.id,
    required this.title,
    required this.description,
  });

  factory ObjectEntity.create({
    required String title,
    required String description,
  }) {
    return ObjectEntity(
      id: _uuid.v4(),
      title: title,
      description: description,
    );
  }

  @override
  List<Object?> get props => [id, title, description];

  ObjectEntity copyWith({
    String? title,
    String? description,
  }) {
    return ObjectEntity(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }
}

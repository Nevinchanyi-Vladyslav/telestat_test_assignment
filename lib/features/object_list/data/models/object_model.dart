import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'object_model.g.dart';

@JsonSerializable()
class ObjectModel extends Equatable{
  final String id;
  final String title;
  final String description;

  const ObjectModel({
    required this.id,
    required this.title,
    required this.description,
  });
  
  @override
  List<Object?> get props => [id, title, description];

  factory ObjectModel.fromJson(Map<String, dynamic> json) => _$ObjectModelFromJson(json);

  Map<String, dynamic> toJson() => _$ObjectModelToJson(this);
}
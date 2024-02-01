import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:telestat_test_assignment/features/object_list/data/data_sources/interfaces/object_data_source.dart';
import 'package:telestat_test_assignment/features/object_list/data/mapper/object_mapper.dart';
import 'package:telestat_test_assignment/features/object_list/domain/entities/object_entity.dart';
import 'package:telestat_test_assignment/core/domain/failures/failures.dart';
import 'package:telestat_test_assignment/features/object_list/domain/repositories/object_repository.dart';

class ObjectRepositoryImpl with ObjectMapper implements ObjectRepository {
  final ObjectDataSource dataSource;
  final StreamController<Future<Either<Failure, List<ObjectEntity>>>>
      _controller = StreamController();

  @override
  Stream<FutureEither<Failure, List<ObjectEntity>>> get objects =>
      _controller.stream;

  ObjectRepositoryImpl(this.dataSource) {
    _addToStream(readObjects());
  }

  void _addToStream(Future<Either<Failure, List<ObjectEntity>>> objects) =>
      _controller.sink.add(objects);

  @override
  FutureEither<Failure, ObjectEntity> createObject(
      ObjectEntity objectEntity) async {
    try {
      final result =
          await dataSource.createObject(fromObjectEntity(objectEntity));

      _addToStream(readObjects());
      return Right(fromObjectModel(result));
    } on Exception catch (e) {
      return Left(CacheFailure(stackTrace: e.toString()));
    }
  }

  @override
  FutureEither<Failure, bool> deleteObjectById(String id) async {
    try {
      final result = await dataSource.deleteObjectById(id);

      _addToStream(readObjects());
      return Right(result);
    } on Exception catch (e) {
      return Left(CacheFailure(stackTrace: e.toString()));
    }
  }

  @override
  FutureEither<Failure, List<ObjectEntity>> readObjects() async {
    try {
      final result = await dataSource.readObjects();

      List<ObjectEntity> entities =
          result.map((model) => fromObjectModel(model)).toList();

      return Right(entities);
    } on Exception catch (e) {
      return Left(CacheFailure(stackTrace: e.toString()));
    }
  }

  @override
  FutureEither<Failure, ObjectEntity> updateObject(
      ObjectEntity objectEntity) async {
    try {
      final result =
          await dataSource.createObject(fromObjectEntity(objectEntity));

      _addToStream(readObjects());
      return Right(fromObjectModel(result));
    } on Exception catch (e) {
      return Left(CacheFailure(stackTrace: e.toString()));
    }
  }
}

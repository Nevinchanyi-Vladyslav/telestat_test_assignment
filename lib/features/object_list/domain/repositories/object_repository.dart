import 'package:dartz/dartz.dart';
import 'package:telestat_test_assignment/features/object_list/domain/entities/object_entity.dart';
import 'package:telestat_test_assignment/core/domain/failures/failures.dart';

typedef FutureEither<L, R> = Future<Either<L, R>>;

abstract class ObjectRepository {

  Stream<FutureEither<Failure, List<ObjectEntity>>> get objects;

  FutureEither<Failure, List<ObjectEntity>> readObjects();

  FutureEither<Failure, ObjectEntity> createObject(ObjectEntity objectEntity);

  FutureEither<Failure, ObjectEntity> updateObject(ObjectEntity objectEntity);

  FutureEither<Failure, bool> deleteObjectById(String id);

}

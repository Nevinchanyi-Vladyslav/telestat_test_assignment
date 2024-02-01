import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:telestat_test_assignment/features/object_list/presentation/utils/failure_message_mapper.dart';
import 'package:telestat_test_assignment/features/object_list/domain/entities/object_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telestat_test_assignment/core/domain/failures/failures.dart';
import 'package:telestat_test_assignment/features/object_list/domain/repositories/object_repository.dart';

part 'object_list_state.dart';

class ObjectListCubit extends Cubit<ObjectListState>
    with FailureToMessageMapper {
  ObjectListCubit(this.repository) : super(ObjectListStateInitial()) {
    _subscription = repository.objects.listen((futureFailureOrObjects) async =>
        _listenObjects(futureFailureOrObjects));
  }

  final ObjectRepository repository;
  late final StreamSubscription<FutureEither<Failure, List<ObjectEntity>>>
      _subscription;

  void _listenObjects(
      FutureEither<Failure, List<ObjectEntity>> futureFailureOrObjects) async {
    emit(ObjectListStateLoading());

    (await futureFailureOrObjects).fold(
      (failure) => emit(
        ObjectListStateError(
          message: mapFailureToMessage(failure),
        ),
      ),
      (objects) => emit(
        ObjectListStateLoaded(
          objects: objects,
        ),
      ),
    );
  }

  void deleteObject(String id) async {
    final failureOrBool = await repository.deleteObjectById(id);

    failureOrBool.fold(
      (failure) => emit(
        ObjectListStateError(
          message: mapFailureToMessage(failure),
        ),
      ),
      (isSuccess) {},
    );
  }

  @override
  Future<void> close() async {
    await _subscription.cancel();
    return super.close();
  }
}

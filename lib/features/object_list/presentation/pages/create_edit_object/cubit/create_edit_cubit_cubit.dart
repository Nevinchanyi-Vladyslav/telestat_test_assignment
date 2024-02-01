import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:telestat_test_assignment/features/object_list/presentation/utils/failure_message_mapper.dart';
import 'package:telestat_test_assignment/features/object_list/domain/entities/object_entity.dart';
import 'package:telestat_test_assignment/features/object_list/domain/repositories/object_repository.dart';

part 'create_edit_cubit_state.dart';

class CreateEditCubit extends Cubit<CreateEditState>
    with FailureToMessageMapper {
  CreateEditCubit(this.repository) : super(CreateEditStateInitial());

  final ObjectRepository repository;

  void updateObject({
    required String id,
    required String title,
    required String description,
  }) async {
    emit(CreateEditStateLoading());

    final failureOrEntity = await repository.updateObject(
        ObjectEntity(id: id, title: title, description: description));

    failureOrEntity.fold(
      (failure) => emit(
        CreateEditStateError(
          message: mapFailureToMessage(failure),
        ),
      ),
      (entity) => emit(
        CreateEditStateSuccess(),
      ),
    );
  }

  void createObject({
    required String title,
    required String description,
  }) async {
    emit(CreateEditStateLoading());

    final failureOrEntity = await repository.updateObject(
        ObjectEntity.create(title: title, description: description));

    failureOrEntity.fold(
      (failure) => emit(
        CreateEditStateError(
          message: mapFailureToMessage(failure),
        ),
      ),
      (entity) => emit(
        CreateEditStateSuccess(),
      ),
    );
  }
}

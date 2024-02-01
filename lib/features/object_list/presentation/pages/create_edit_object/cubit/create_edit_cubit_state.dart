part of 'create_edit_cubit_cubit.dart';

sealed class CreateEditState extends Equatable {
  const CreateEditState();

  @override
  List<Object> get props => [];
}

final class CreateEditStateInitial extends CreateEditState {}

final class CreateEditStateError extends CreateEditState {
  final String message;

  const CreateEditStateError({required this.message});

  @override
  List<Object> get props => [message];
}

final class CreateEditStateSuccess extends CreateEditState {}

final class CreateEditStateLoading extends CreateEditState {}

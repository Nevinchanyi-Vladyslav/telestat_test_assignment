part of 'object_list_cubit.dart';

sealed class ObjectListState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class ObjectListStateInitial extends ObjectListState {}

final class ObjectListStateError extends ObjectListState {
  ObjectListStateError({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}

final class ObjectListStateLoaded extends ObjectListState {
  ObjectListStateLoaded({required this.objects});

  final List<ObjectEntity> objects;

  @override
  List<Object?> get props => [objects];
}

final class ObjectListStateLoading extends ObjectListState {}

import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class CacheFailure extends Failure {
  final String? stackTrace;

  CacheFailure({this.stackTrace});

  @override
  List<Object?> get props => [stackTrace];
}

class ServerFailure extends Failure {
  final String? stackTrace;

  ServerFailure({this.stackTrace});

  @override
  List<Object?> get props => [stackTrace];
}

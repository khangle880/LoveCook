import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final Exception? exception;

  Failure({this.exception});

  @override
  List<Object?> get props => [exception];
}

// General failures
class ServerFailure extends Failure {
  ServerFailure({Exception? exception}) : super(exception: exception);
}

class CacheFailure extends Failure {
  CacheFailure({Exception? exception}) : super(exception: exception);
}

class UnknownFailure extends Failure {
  UnknownFailure({Exception? exception}) : super(exception: exception);
}

import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure([this.message = 'An unexpected error occurred']);

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure([String message = 'Server Error']) : super(message);
}

class NetworkFailure extends Failure {
  const NetworkFailure([String message = 'Network Error. Please check your internet connection.']) : super(message);
}

class AuthFailure extends Failure {
  const AuthFailure([String message = 'Authentication Failed']) : super(message);
}

import 'package:dartz/dartz.dart';
import 'package:lo2ta/core/error/failures.dart';
import 'package:lo2ta/core/usecases/usecase.dart';
import 'package:lo2ta/modules/auth_module/domain/entities/user_entity.dart';
import 'package:lo2ta/modules/auth_module/domain/repositories/auth_repository.dart';

class LoginParams {
  final String email;
  final String password;
  LoginParams({required this.email, required this.password});
}

class LoginUseCase implements UseCase<UserEntity, LoginParams> {
  final AuthRepository repository;
  LoginUseCase(this.repository);
  @override
  Future<Either<Failure, UserEntity>> call(LoginParams params) async {
    return await repository.login(params.email, params.password);
  }
}

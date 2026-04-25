import 'package:dartz/dartz.dart';
import 'package:lo2ta/core/error/failures.dart';
import 'package:lo2ta/core/usecases/usecase.dart';
import 'package:lo2ta/features/auth_module/domain/entities/user_entity.dart';
import 'package:lo2ta/features/auth_module/domain/repositories/auth_repository.dart';

class RegisterParams {
  final String email;
  final String password;
  final String name;
  final UserRole role;

  RegisterParams({required this.email, required this.password, required this.name, required this.role});
}

class RegisterUseCase implements UseCase<UserEntity, RegisterParams> {
  final AuthRepository repository;
  RegisterUseCase(this.repository);
  @override
  Future<Either<Failure, UserEntity>> call(RegisterParams params) async {
    return await repository.register(params.email, params.password, params.name, params.role);
  }
}

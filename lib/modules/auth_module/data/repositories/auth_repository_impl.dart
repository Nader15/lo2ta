import 'package:dartz/dartz.dart';
import 'package:lo2ta/core/error/failures.dart';
import 'package:lo2ta/modules/auth_module/data/datasources/auth_remote_data_source.dart';
import 'package:lo2ta/modules/auth_module/domain/entities/user_entity.dart';
import 'package:lo2ta/modules/auth_module/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, UserEntity>> login(String email, String password) async {
    try {
      final user = await remoteDataSource.login(email, password);
      return Right(user);
    } catch (e) {
      return Left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> register(String email, String password, String name, UserRole role) async {
    try {
      final user = await remoteDataSource.register(email, password, name, role);
      return Right(user);
    } catch (e) {
      return Left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getCurrentUser() async {
    try {
      final user = await remoteDataSource.getCurrentUser();
      if (user != null) {
        return Right(user);
      } else {
        return const Left(AuthFailure('No user found'));
      }
    } catch (e) {
      return Left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<void> logout() async {
    await remoteDataSource.logout();
  }
}

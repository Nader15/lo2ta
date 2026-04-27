import 'package:dartz/dartz.dart';
import 'package:lo2ta/core/error/failures.dart';
import 'package:lo2ta/modules/user_module/home/data/datasources/user_remote_data_source.dart';
import 'package:lo2ta/modules/user_module/home/domain/entities/offer.dart';
import 'package:lo2ta/modules/user_module/home/domain/entities/store.dart';
import 'package:lo2ta/modules/user_module/home/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Offer>>> getOffers() async {
    try {
      final remoteOffers = await remoteDataSource.getOffers();
      return Right(remoteOffers);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Store>>> getStores() async {
    try {
      final remoteStores = await remoteDataSource.getStores();
      return Right(remoteStores);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

import 'package:dartz/dartz.dart';
import 'package:lo2ta/core/error/failures.dart';
import 'package:lo2ta/modules/user_module/home/domain/entities/offer.dart';
import 'package:lo2ta/modules/user_module/home/domain/entities/store.dart';

abstract class UserRepository {
  Future<Either<Failure, List<Offer>>> getOffers();
  Future<Either<Failure, List<Store>>> getStores();
}

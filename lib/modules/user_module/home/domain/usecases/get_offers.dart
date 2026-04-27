import 'package:dartz/dartz.dart';
import 'package:lo2ta/core/error/failures.dart';
import 'package:lo2ta/core/usecases/usecase.dart';
import 'package:lo2ta/modules/user_module/home/domain/entities/offer.dart';
import 'package:lo2ta/modules/user_module/home/domain/repositories/user_repository.dart';

class GetOffers implements UseCase<List<Offer>, NoParams> {
  final UserRepository repository;

  GetOffers(this.repository);

  @override
  Future<Either<Failure, List<Offer>>> call(NoParams params) async {
    return await repository.getOffers();
  }
}

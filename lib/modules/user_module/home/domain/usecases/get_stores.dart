import 'package:dartz/dartz.dart';
import 'package:lo2ta/core/error/failures.dart';
import 'package:lo2ta/core/usecases/usecase.dart';
import 'package:lo2ta/modules/user_module/home/domain/entities/store.dart';
import 'package:lo2ta/modules/user_module/home/domain/repositories/user_repository.dart';

class GetStores implements UseCase<List<Store>, NoParams> {
  final UserRepository repository;

  GetStores(this.repository);

  @override
  Future<Either<Failure, List<Store>>> call(NoParams params) async {
    return await repository.getStores();
  }
}

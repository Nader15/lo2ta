import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lo2ta/core/usecases/usecase.dart';
import 'package:lo2ta/modules/user_module/home/domain/usecases/get_offers.dart';
import 'package:lo2ta/modules/user_module/home/domain/usecases/get_stores.dart';
import 'package:lo2ta/modules/user_module/home/presentation/cubits/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetOffers getOffersUseCase;
  final GetStores getStoresUseCase;

  HomeCubit({
    required this.getOffersUseCase,
    required this.getStoresUseCase,
  }) : super(UserHomeInitial());

  Future<void> loadHomeData() async {
    emit(UserHomeLoading());

    final offersResult = await getOffersUseCase(NoParams());
    final storesResult = await getStoresUseCase(NoParams());

    offersResult.fold(
      (failure) => emit(UserHomeError(failure.message)),
      (offers) {
        storesResult.fold(
          (failure) => emit(UserHomeError(failure.message)),
          (stores) => emit(UserHomeLoaded(offers: offers, stores: stores)),
        );
      },
    );
  }
}

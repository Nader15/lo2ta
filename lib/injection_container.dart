import 'package:get_it/get_it.dart';
import 'package:lo2ta/modules/auth_module/data/datasources/auth_remote_data_source.dart';
import 'package:lo2ta/modules/auth_module/data/repositories/auth_repository_impl.dart';
import 'package:lo2ta/modules/auth_module/domain/usecases/login_usecase.dart';
import 'package:lo2ta/modules/auth_module/domain/usecases/register_usecase.dart';
import 'package:lo2ta/modules/auth_module/presentation/cubits/auth_cubit.dart';
import 'package:lo2ta/modules/auth_module/domain/repositories/auth_repository.dart';
import 'package:lo2ta/modules/user_module/home/data/datasources/user_remote_data_source.dart';
import 'package:lo2ta/modules/user_module/home/data/repositories/user_repository_impl.dart';
import 'package:lo2ta/modules/user_module/home/domain/repositories/user_repository.dart';
import 'package:lo2ta/modules/user_module/home/domain/usecases/get_offers.dart';
import 'package:lo2ta/modules/user_module/home/domain/usecases/get_stores.dart';
import 'package:lo2ta/modules/user_module/home/presentation/cubits/home_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Auth Module
  sl.registerFactory(() => AuthCubit(loginUseCase: sl(), registerUseCase: sl(), authRepository: sl()));
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(firebaseAuth: sl(), firestore: sl()));

  //! Features - User Module
  sl.registerFactory(() => HomeCubit(getOffersUseCase: sl(), getStoresUseCase: sl()));
  sl.registerLazySingleton(() => GetOffers(sl()));
  sl.registerLazySingleton(() => GetStores(sl()));
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<UserRemoteDataSource>(() => UserRemoteDataSourceImpl());

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
}

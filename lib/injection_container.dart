import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'features/auth_module/data/datasources/auth_remote_data_source.dart';
import 'features/auth_module/data/repositories/auth_repository_impl.dart';
import 'features/auth_module/domain/repositories/auth_repository.dart';
import 'features/auth_module/domain/usecases/login_usecase.dart';
import 'features/auth_module/domain/usecases/register_usecase.dart';
import 'features/auth_module/presentation/blocs/auth_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Auth Module
  sl.registerFactory(() => AuthCubit(loginUseCase: sl(), registerUseCase: sl(), authRepository: sl()));
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(firebaseAuth: sl(), firestore: sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
}

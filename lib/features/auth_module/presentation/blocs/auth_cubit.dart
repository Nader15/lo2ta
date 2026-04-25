import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lo2ta/features/auth_module/domain/entities/user_entity.dart';
import 'package:lo2ta/features/auth_module/domain/usecases/login_usecase.dart';
import 'package:lo2ta/features/auth_module/domain/usecases/register_usecase.dart';
import 'package:lo2ta/features/auth_module/domain/repositories/auth_repository.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}
class AuthLoading extends AuthState {}
class Authenticated extends AuthState {
  final UserEntity user;
  const Authenticated(this.user);
  @override
  List<Object?> get props => [user];
}
class Unauthenticated extends AuthState {}
class AuthError extends AuthState {
  final String message;
  const AuthError(this.message);
  @override
  List<Object?> get props => [message];
}

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final AuthRepository authRepository;

  AuthCubit({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.authRepository,
  }) : super(AuthInitial());

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    final result = await loginUseCase(LoginParams(email: email, password: password));
    result.fold((failure) => emit(AuthError(failure.message)), (user) => emit(Authenticated(user)));
  }

  Future<void> register(String email, String password, String name, UserRole role) async {
    emit(AuthLoading());
    final result = await registerUseCase(RegisterParams(email: email, password: password, name: name, role: role));
    result.fold((failure) => emit(AuthError(failure.message)), (user) => emit(Authenticated(user)));
  }

  Future<void> checkAuthStatus() async {
    emit(AuthLoading());
    final result = await authRepository.getCurrentUser();
    result.fold((failure) => emit(Unauthenticated()), (user) => emit(Authenticated(user)));
  }

  Future<void> logout() async {
    emit(AuthLoading());
    await authRepository.logout();
    emit(Unauthenticated());
  }
}

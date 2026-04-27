import 'package:lo2ta/modules/user_module/home/domain/entities/offer.dart';
import 'package:lo2ta/modules/user_module/home/domain/entities/store.dart';

sealed class HomeState {}

class UserHomeInitial extends HomeState {}

class UserHomeLoading extends HomeState {}

class UserHomeLoaded extends HomeState {
  final List<Offer> offers;
  final List<Store> stores;

  UserHomeLoaded({required this.offers, required this.stores});
}

class UserHomeError extends HomeState {
  final String message;

  UserHomeError(this.message);
}

import 'package:equatable/equatable.dart';

class OfferEntity extends Equatable {
  final String id;
  final String title;
  final String imageUrl;
  final double oldPrice;
  final double newPrice;
  final int discountPercentage;
  final DateTime startDate;
  final DateTime endDate;
  final String storeId;
  final String storeName;
  final String category;

  const OfferEntity({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.oldPrice,
    required this.newPrice,
    required this.discountPercentage,
    required this.startDate,
    required this.endDate,
    required this.storeId,
    required this.storeName,
    required this.category,
  });

  @override
  List<Object?> get props => [id, title, imageUrl, oldPrice, newPrice, discountPercentage, startDate, endDate, storeId, storeName, category];
}

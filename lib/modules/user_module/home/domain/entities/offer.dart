import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lo2ta/modules/user_module/home/domain/entities/store.dart';

class Offer extends Equatable {
  final String id;
  final String title;
  final String subtitle;
  final String description;
  final String? category;
  final double? distance; // Distance in km
  final String discount;
  final String emoji;
  final Color primaryColor;
  final Color bgStart;
  final Color bgEnd;
  final String imageUrl;
  final List<String> images;
  final String logoUrl;
  final double originalPrice;
  final double discountedPrice;
  final Store? store;

  const Offer({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    this.category,
    this.distance,
    required this.discount,
    required this.emoji,
    required this.primaryColor,
    required this.bgStart,
    required this.bgEnd,
    required this.imageUrl,
    required this.images,
    required this.logoUrl,
    required this.originalPrice,
    required this.discountedPrice,
    this.store,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        subtitle,
        description,
        category,
        distance,
        discount,
        emoji,
        primaryColor,
        bgStart,
        bgEnd,
        imageUrl,
        images,
        logoUrl,
        originalPrice,
        discountedPrice,
        store,
      ];
}

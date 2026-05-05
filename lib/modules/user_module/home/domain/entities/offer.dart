import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Offer extends Equatable {
  final String id;
  final String title;
  final String subtitle;
  final String? category;
  final double? distance; // Distance in km
  final String discount;
  final String emoji;
  final Color primaryColor;
  final Color bgStart;
  final Color bgEnd;
  final String imageUrl;
  final String logoUrl;
  final double originalPrice;
  final double discountedPrice;

  const Offer({
    required this.id,
    required this.title,
    required this.subtitle,
    this.category,
    this.distance,
    required this.discount,
    required this.emoji,
    required this.primaryColor,
    required this.bgStart,
    required this.bgEnd,
    required this.imageUrl,
    required this.logoUrl,
    required this.originalPrice,
    required this.discountedPrice,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        subtitle,
        category,
        distance,
        discount,
        emoji,
        primaryColor,
        bgStart,
        bgEnd,
        imageUrl,
        logoUrl,
        originalPrice,
        discountedPrice,
      ];
}

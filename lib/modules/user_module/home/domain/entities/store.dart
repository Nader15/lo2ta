import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Store extends Equatable {
  final String id;
  final String name;
  final String category;
  final double? distance; // Distance in km
  final String deliveryTime;
  final String deliveryFee;
  final String rating;
  final String emoji;
  final Color primaryColor;
  final String imageUrl;
  final String logoUrl;
  final String offersCount;

  const Store({
    required this.id,
    required this.name,
    required this.category,
    this.distance,
    required this.deliveryTime,
    required this.deliveryFee,
    required this.rating,
    required this.emoji,
    required this.primaryColor,
    required this.imageUrl,
    required this.logoUrl,
    required this.offersCount,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    category,
    distance,
    deliveryTime,
    deliveryFee,
    rating,
    emoji,
    primaryColor,
    imageUrl,
    logoUrl,
    offersCount,
  ];
}

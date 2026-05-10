import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Store extends Equatable {
  final String id;
  final String name;
  final String category;
  final double? distance; // Distance in km
  final String rating;
  final String emoji;
  final Color primaryColor;
  final String imageUrl;
  final String logoUrl;
  final String offersCount;
  final String address;
  final double latitude;
  final double longitude;

  const Store({
    required this.id,
    required this.name,
    required this.category,
    this.distance,
    required this.rating,
    required this.emoji,
    required this.primaryColor,
    required this.imageUrl,
    required this.logoUrl,
    required this.offersCount,
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    category,
    distance,
    rating,
    emoji,
    primaryColor,
    imageUrl,
    logoUrl,
    offersCount,
    address,
    latitude,
    longitude,
  ];
}

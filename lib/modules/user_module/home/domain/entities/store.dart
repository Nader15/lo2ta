import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Store extends Equatable {
  final String id;
  final String name;
  final String category;
  final String deliveryTime;
  final String deliveryFee;
  final String rating;
  final String emoji;
  final Color primaryColor;

  const Store({
    required this.id,
    required this.name,
    required this.category,
    required this.deliveryTime,
    required this.deliveryFee,
    required this.rating,
    required this.emoji,
    required this.primaryColor,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        category,
        deliveryTime,
        deliveryFee,
        rating,
        emoji,
        primaryColor,
      ];
}

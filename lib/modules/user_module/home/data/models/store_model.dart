import 'package:flutter/material.dart';
import 'package:lo2ta/modules/user_module/home/domain/entities/store.dart';

class StoreModel extends Store {
  const StoreModel({
    required super.id,
    required super.name,
    required super.category,
    required super.deliveryTime,
    required super.deliveryFee,
    required super.rating,
    required super.emoji,
    required super.primaryColor,
  });

  factory StoreModel.fromJson(Map<String, dynamic> json) {
    return StoreModel(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      deliveryTime: json['deliveryTime'],
      deliveryFee: json['deliveryFee'],
      rating: json['rating'],
      emoji: json['emoji'],
      primaryColor: Color(json['primaryColor']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'deliveryTime': deliveryTime,
      'deliveryFee': deliveryFee,
      'rating': rating,
      'emoji': emoji,
      'primaryColor': primaryColor.value,
    };
  }
}

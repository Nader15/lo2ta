import 'package:flutter/material.dart';
import 'package:lo2ta/modules/user_module/home/domain/entities/store.dart';

class StoreModel extends Store {
  const StoreModel({
    required super.id,
    required super.name,
    required super.category,
    super.distance,
    required super.deliveryTime,
    required super.deliveryFee,
    required super.rating,
    required super.emoji,
    required super.primaryColor,
    required super.imageUrl,
    required super.logoUrl,
    required super.offersCount,
  });

  factory StoreModel.fromJson(Map<String, dynamic> json) {
    return StoreModel(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      distance: (json['distance'] as num?)?.toDouble(),
      deliveryTime: json['deliveryTime'],
      deliveryFee: json['deliveryFee'],
      rating: json['rating'],
      emoji: json['emoji'],
      primaryColor: Color(json['primaryColor']),
      imageUrl: json['imageUrl'],
      logoUrl: json['logoUrl'],
      offersCount: json['offersCount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'distance': distance,
      'deliveryTime': deliveryTime,
      'deliveryFee': deliveryFee,
      'rating': rating,
      'emoji': emoji,
      'primaryColor': primaryColor.value,
      'imageUrl': imageUrl,
      'logoUrl': logoUrl,
      'offersCount': offersCount,
    };
  }
}

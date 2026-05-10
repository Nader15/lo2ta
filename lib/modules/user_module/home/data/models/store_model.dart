import 'package:flutter/material.dart';
import 'package:lo2ta/modules/user_module/home/domain/entities/store.dart';

class StoreModel extends Store {
  const StoreModel({
    required super.id,
    required super.name,
    required super.category,
    super.distance,
    required super.rating,
    required super.emoji,
    required super.primaryColor,
    required super.imageUrl,
    required super.logoUrl,
    required super.offersCount,
    required super.address,
    required super.latitude,
    required super.longitude,
  });

  factory StoreModel.fromJson(Map<String, dynamic> json) {
    return StoreModel(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      distance: (json['distance'] as num?)?.toDouble(),
      rating: json['rating'],
      emoji: json['emoji'],
      primaryColor: Color(json['primaryColor']),
      imageUrl: json['imageUrl'],
      logoUrl: json['logoUrl'],
      offersCount: json['offersCount'],
      address: json['address'] ?? '',
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0.0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'distance': distance,
      'rating': rating,
      'emoji': emoji,
      'primaryColor': primaryColor.value,
      'imageUrl': imageUrl,
      'logoUrl': logoUrl,
      'offersCount': offersCount,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}

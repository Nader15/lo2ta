import 'package:flutter/material.dart';
import 'package:lo2ta/modules/user_module/home/data/models/store_model.dart';
import 'package:lo2ta/modules/user_module/home/domain/entities/offer.dart';

class OfferModel extends Offer {
  const OfferModel({
    required super.id,
    required super.title,
    required super.subtitle,
    required super.description,
    super.category,
    super.distance,
    required super.discount,
    required super.emoji,
    required super.primaryColor,
    required super.bgStart,
    required super.bgEnd,
    required super.imageUrl,
    required super.images,
    required super.logoUrl,
    required super.originalPrice,
    required super.discountedPrice,
    super.store,
  });

  factory OfferModel.fromJson(Map<String, dynamic> json) {
    return OfferModel(
      id: json['id'],
      title: json['title'],
      subtitle: json['subtitle'],
      description: json['description'] ?? '',
      category: json['category'],
      distance: (json['distance'] as num?)?.toDouble(),
      discount: json['discount'],
      emoji: json['emoji'],
      primaryColor: Color(json['primaryColor']),
      bgStart: Color(json['bgStart']),
      bgEnd: Color(json['bgEnd']),
      imageUrl: json['imageUrl'],
      images: List<String>.from(json['images'] ?? []),
      logoUrl: json['logoUrl'],
      originalPrice: (json['originalPrice'] as num).toDouble(),
      discountedPrice: (json['discountedPrice'] as num).toDouble(),
      store: json['store'] != null ? StoreModel.fromJson(json['store']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'description': description,
      'category': category,
      'distance': distance,
      'discount': discount,
      'emoji': emoji,
      'primaryColor': primaryColor.value,
      'bgStart': bgStart.value,
      'bgEnd': bgEnd.value,
      'imageUrl': imageUrl,
      'images': images,
      'logoUrl': logoUrl,
      'originalPrice': originalPrice,
      'discountedPrice': discountedPrice,
      'store': store != null ? (store as StoreModel).toJson() : null,
    };
  }
}

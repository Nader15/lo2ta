import 'package:flutter/material.dart';
import 'package:lo2ta/modules/user_module/home/domain/entities/offer.dart';

class OfferModel extends Offer {
  const OfferModel({
    required super.id,
    required super.title,
    required super.subtitle,
    super.category,
    super.distance,
    required super.discount,
    required super.emoji,
    required super.primaryColor,
    required super.bgStart,
    required super.bgEnd,
    required super.imageUrl,
    required super.logoUrl,
    required super.originalPrice,
    required super.discountedPrice,
  });

  factory OfferModel.fromJson(Map<String, dynamic> json) {
    return OfferModel(
      id: json['id'],
      title: json['title'],
      subtitle: json['subtitle'],
      category: json['category'],
      distance: (json['distance'] as num?)?.toDouble(),
      discount: json['discount'],
      emoji: json['emoji'],
      primaryColor: Color(json['primaryColor']),
      bgStart: Color(json['bgStart']),
      bgEnd: Color(json['bgEnd']),
      imageUrl: json['imageUrl'],
      logoUrl: json['logoUrl'],
      originalPrice: (json['originalPrice'] as num).toDouble(),
      discountedPrice: (json['discountedPrice'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'category': category,
      'distance': distance,
      'discount': discount,
      'emoji': emoji,
      'primaryColor': primaryColor.value,
      'bgStart': bgStart.value,
      'bgEnd': bgEnd.value,
      'imageUrl': imageUrl,
      'logoUrl': logoUrl,
      'originalPrice': originalPrice,
      'discountedPrice': discountedPrice,
    };
  }
}

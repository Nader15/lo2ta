import 'package:flutter/material.dart';
import 'package:lo2ta/modules/user_module/home/data/models/offer_model.dart';
import 'package:lo2ta/modules/user_module/home/data/models/store_model.dart';

abstract class UserRemoteDataSource {
  Future<List<OfferModel>> getOffers();

  Future<List<StoreModel>> getStores();
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  @override
  Future<List<OfferModel>> getOffers() async {
    const String image1 = 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?q=80&w=1000&auto=format&fit=crop';
    const String image2 = 'https://images.unsplash.com/photo-1543353071-873f17a7a088?q=80&w=1000&auto=format&fit=crop';
    const String image3 = 'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?q=80&w=1000&auto=format&fit=crop';
    const String logo = 'https://scontent.fcai20-5.fna.fbcdn.net/v/t39.30808-6/311596277_1586593778410637_675445795878871277_n.jpg?_nc_cat=106&ccb=1-7&_nc_sid=53a332&_nc_ohc=TKxV3KskkHYQ7kNvwGFNUjw&_nc_oc=AdplVsXmdU6jLwVW1AdgT3bYoiwek2Uhny9_j2t9JUri0StpxTd4NKmcZGAeMqt9yiQ&_nc_zt=23&_nc_ht=scontent.fcai20-5.fna&_nc_gid=BlcAzgEDj3U8WvRTOymhiA&_nc_ss=7b2a8&oh=00_Af6BGLZE7FGmDGe76dhIfHYNcLjB1sZhelecGUxBDQQluw&oe=69FFCED5';

    final mockStore = StoreModel(
      id: 'store_1',
      name: 'مطعم الثورة العاشر من رمضان',
      category: 'اكل',
      distance: 0.8,
      deliveryTime: '٢٠-٣٠ دقيقة',
      deliveryFee: 'ج.م ١٠',
      rating: '٤.٨',
      emoji: '🍛',
      primaryColor: const Color(0xFF6B4FD4),
      imageUrl: image1,
      logoUrl: logo,
      offersCount: '٣',
      address: 'العاشر من رمضان، المجاورة ٣٣',
      latitude: 30.2961,
      longitude: 31.7441,
    );

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    return [
      OfferModel(
        id: 'off_1',
        title: 'عرض الترويقه العائلي',
        subtitle: 'وجبة تكفي ٤ أفراد',
        description: 'استمتع بأفضل عرض عائلي من مطعم الثورة. الوجبة تتكون من دجاجة كاملة مشوية، أرز بسمتي، سلطات، ومشروب غازي لتر ونصف. العرض ساري لفترة محدودة.',
        category: 'وجبات',
        distance: 1.2,
        discount: 'خصم ٣٦ %',
        emoji: '🍛',
        primaryColor: const Color(0xFF6B4FD4),
        bgStart: const Color(0xFFE8E0FA),
        bgEnd: const Color(0xFFD5C8F7),
        imageUrl: image1,
        images: [image1, image2, image3],
        logoUrl: logo,
        originalPrice: 200,
        discountedPrice: 170,
        store: mockStore,
      ),
      OfferModel(
        id: 'off_2',
        title: 'ساندوتش السعادة',
        subtitle: 'اشتري واحد واحصل على الثاني مجاناً',
        description: 'أفضل ساندوتش برجر في العاشر من رمضان. لحم بقري صافي ١٠٠٪ مع صوص الثورة الخاص. اطلبه الآن واحصل على الثاني مجاناً.',
        category: 'سندوتشات',
        distance: 1.2,
        discount: '١+١ مجاناً',
        emoji: '🍔',
        primaryColor: const Color(0xFFFF4B2B),
        bgStart: const Color(0xFFFFEAEA),
        bgEnd: const Color(0xFFFFD1D1),
        imageUrl: image2,
        images: [image2, image1, image3],
        logoUrl: logo,
        originalPrice: 100,
        discountedPrice: 50,
        store: mockStore,
      ),
    ];
  }

  @override
  Future<List<StoreModel>> getStores() async {
    const String image = 'https://images.unsplash.com/photo-1552566626-52f8b828add9?q=80&w=1000&auto=format&fit=crop';
    const String logo = 'https://scontent.fcai20-5.fna.fbcdn.net/v/t39.30808-6/311596277_1586593778410637_675445795878871277_n.jpg?_nc_cat=106&ccb=1-7&_nc_sid=53a332&_nc_ohc=TKxV3KskkHYQ7kNvwGFNUjw&_nc_oc=AdplVsXmdU6jLwVW1AdgT3bYoiwek2Uhny9_j2t9JUri0StpxTd4NKmcZGAeMqt9yiQ&_nc_zt=23&_nc_ht=scontent.fcai20-5.fna&_nc_gid=BlcAzgEDj3U8WvRTOymhiA&_nc_ss=7b2a8&oh=00_Af6BGLZE7FGmDGe76dhIfHYNcLjB1sZhelecGUxBDQQluw&oe=69FFCED5';

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    return [
      StoreModel(
        id: 'store_1',
        name: 'مطعم الثورة العاشر من رمضان',
        category: 'اكل',
        distance: 0.8,
        deliveryTime: '٢٠-٣٠ دقيقة',
        deliveryFee: 'ج.م ١٠',
        rating: '٤.٨',
        emoji: '🍛',
        primaryColor: const Color(0xFF6B4FD4),
        imageUrl: image,
        logoUrl: logo,
        offersCount: '٣',
        address: 'العاشر من رمضان، المجاورة ٣٣',
        latitude: 30.2961,
        longitude: 31.7441,
      ),
      StoreModel(
        id: 'store_2',
        name: 'كافيه الاندلس',
        category: 'كافيه',
        distance: 1.5,
        deliveryTime: '١٠-٢٠ دقيقة',
        deliveryFee: 'ج.م ٥',
        rating: '٤.٥',
        emoji: '☕',
        primaryColor: const Color(0xFFF27121),
        imageUrl: image,
        logoUrl: logo,
        offersCount: '٢',
        address: 'العاشر من رمضان، الاردنية',
        latitude: 30.3012,
        longitude: 31.7385,
      ),
    ];
  }
}

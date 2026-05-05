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
    const String image = 'https://scontent.fcai20-6.fna.fbcdn.net/v/t39.30808-6/558858192_1106062848408783_5715379647864773694_n.jpg?_nc_cat=103&ccb=1-7&_nc_sid=13d280&_nc_ohc=N2Ty3yJuulYQ7kNvwGyeWU3&_nc_oc=Adp0zy2LwWPTub6hTWI8pjt72m_EmbtRj9VNbwiCinHtWwif3OzCa5ktdYhpNG_n4lE&_nc_zt=23&_nc_ht=scontent.fcai20-6.fna&_nc_gid=tk6MexYY9VhcRtAxuL1rDg&_nc_ss=7b2a8&oh=00_Af5HZDvNA_7AGzsYjCLiZ_FnrCNNmpuW2lNJbGgindXIyg&oe=69FFD0DA';
    const String logo = 'https://scontent.fcai20-5.fna.fbcdn.net/v/t39.30808-6/311596277_1586593778410637_675445795878871277_n.jpg?_nc_cat=106&ccb=1-7&_nc_sid=53a332&_nc_ohc=TKxV3KskkHYQ7kNvwGFNUjw&_nc_oc=AdplVsXmdU6jLwVW1AdgT3bYoiwek2Uhny9_j2t9JUri0StpxTd4NKmcZGAeMqt9yiQ&_nc_zt=23&_nc_ht=scontent.fcai20-5.fna&_nc_gid=BlcAzgEDj3U8WvRTOymhiA&_nc_ss=7b2a8&oh=00_Af6BGLZE7FGmDGe76dhIfHYNcLjB1sZhelecGUxBDQQluw&oe=69FFCED5';

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    return [
      const OfferModel(
        id: '1',
        title: 'مطعم الثورة العاشر من رمضان',
        subtitle: 'عرض الترويقه',
        category: 'وجبات',
        distance: 1.2,
        discount: 'خصم 36 %',
        emoji: '🍛',
        primaryColor: Color(0xFF6B4FD4),
        bgStart: Color(0xFFE8E0FA),
        bgEnd: Color(0xFFD5C8F7),
        imageUrl: image,
        logoUrl: logo,
        originalPrice: 200,
        discountedPrice: 170,
      ),
      const OfferModel(
        id: '1',
        title: 'مطعم الثورة العاشر من رمضان',
        subtitle: 'عرض الترويقه',
        category: 'وجبات',
        distance: 1.2,
        discount: 'خصم 36 %',
        emoji: '🍛',
        primaryColor: Color(0xFF6B4FD4),
        bgStart: Color(0xFFE8E0FA),
        bgEnd: Color(0xFFD5C8F7),
        imageUrl: image,
        logoUrl: logo,
        originalPrice: 200,
        discountedPrice: 170,
      ),
      const OfferModel(
        id: '1',
        title: 'مطعم الثورة العاشر من رمضان',
        subtitle: 'عرض الترويقه',
        category: 'وجبات',
        distance: 1.2,
        discount: 'خصم 36 %',
        emoji: '🍛',
        primaryColor: Color(0xFF6B4FD4),
        bgStart: Color(0xFFE8E0FA),
        bgEnd: Color(0xFFD5C8F7),
        imageUrl: image,
        logoUrl: logo,
        originalPrice: 200,
        discountedPrice: 170,
      ),
      const OfferModel(
        id: '1',
        title: 'مطعم الثورة العاشر من رمضان',
        subtitle: 'عرض الترويقه',
        category: 'وجبات',
        distance: 1.2,
        discount: 'خصم 36 %',
        emoji: '🍛',
        primaryColor: Color(0xFF6B4FD4),
        bgStart: Color(0xFFE8E0FA),
        bgEnd: Color(0xFFD5C8F7),
        imageUrl: image,
        logoUrl: logo,
        originalPrice: 200,
        discountedPrice: 170,
      ),
    ];
  }

  @override
  Future<List<StoreModel>> getStores() async {

    const String image = 'https://scontent.fcai20-4.fna.fbcdn.net/v/t39.30808-6/655692864_1233279532353780_5178401812740034010_n.png?_nc_cat=107&ccb=1-7&_nc_sid=2a1932&_nc_ohc=luj5kgajnPsQ7kNvwGY--3B&_nc_oc=AdqWlIeNY-43KnuU6MLqjqej5xnqcE9_V4ztgZD5Ah6RFFDCUBkIV9cpQhlDzvAc8IM&_nc_zt=23&_nc_ht=scontent.fcai20-4.fna&_nc_gid=VKyT8lm70em6I1KdvlaOzg&_nc_ss=7b2a8&oh=00_Af6e87WQs8lrAhenWesp9CDA36Iq5QnBjKF_DYwKAii0zQ&oe=69FFAA22';
    const String logo = 'https://scontent.fcai20-5.fna.fbcdn.net/v/t39.30808-6/311596277_1586593778410637_675445795878871277_n.jpg?_nc_cat=106&ccb=1-7&_nc_sid=53a332&_nc_ohc=TKxV3KskkHYQ7kNvwGFNUjw&_nc_oc=AdplVsXmdU6jLwVW1AdgT3bYoiwek2Uhny9_j2t9JUri0StpxTd4NKmcZGAeMqt9yiQ&_nc_zt=23&_nc_ht=scontent.fcai20-5.fna&_nc_gid=BlcAzgEDj3U8WvRTOymhiA&_nc_ss=7b2a8&oh=00_Af6BGLZE7FGmDGe76dhIfHYNcLjB1sZhelecGUxBDQQluw&oe=69FFCED5';

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    return [
      const StoreModel(
        id: '1',
        name: 'مطعم الثورة العاشر من رمضان',
        category: 'اكل',
        distance: 0.8,
        deliveryTime: '٢٠-٣٠ دقيقة',
        deliveryFee: 'ج.م ١٠',
        rating: '٤.٨',
        emoji: '🍛',
        primaryColor: Color(0xFF6B4FD4),
        imageUrl: image,
        logoUrl: logo,
        offersCount: '٣',
      ),
      const StoreModel(
        id: '1',
        name: 'مطعم الثورة العاشر من رمضان',
        category: 'اكل',
        distance: 0.8,
        deliveryTime: '٢٠-٣٠ دقيقة',
        deliveryFee: 'ج.م ١٠',
        rating: '٤.٨',
        emoji: '🍛',
        primaryColor: Color(0xFF6B4FD4),
        imageUrl: image,
        logoUrl: logo,
        offersCount: '٣',
      ),
      const StoreModel(
        id: '1',
        name: 'مطعم الثورة العاشر من رمضان',
        category: 'اكل',
        distance: 0.8,
        deliveryTime: '٢٠-٣٠ دقيقة',
        deliveryFee: 'ج.م ١٠',
        rating: '٤.٨',
        emoji: '🍛',
        primaryColor: Color(0xFF6B4FD4),
        imageUrl: image,
        logoUrl: logo,
        offersCount: '٣',
      ),
      const StoreModel(
        id: '1',
        name: 'مطعم الثورة العاشر من رمضان',
        category: 'اكل',
        distance: 0.8,
        deliveryTime: '٢٠-٣٠ دقيقة',
        deliveryFee: 'ج.م ١٠',
        rating: '٤.٨',
        emoji: '🍛',
        primaryColor: Color(0xFF6B4FD4),
        imageUrl: image,
        logoUrl: logo,
        offersCount: '٣',
      ),
    ];
  }
}

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
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    return [
      const OfferModel(
        id: '1',
        title: 'كشري الخديوي',
        subtitle: 'وجبة كشري الخديوي',
        discount: 'خصم 36 %',
        emoji: '🍛',
        primaryColor: Color(0xFF6B4FD4),
        bgStart: Color(0xFFE8E0FA),
        bgEnd: Color(0xFFD5C8F7),
        imageUrl: 'https://scontent.fcai20-5.fna.fbcdn.net/v/t51.75761-15/491257270_18054925817239204_2555356597860424879_n.jpg?_nc_cat=102&ccb=1-7&_nc_sid=13d280&_nc_ohc=quahDlK-0m4Q7kNvwHPHVOE&_nc_oc=AdqGuqCJefolsD9Kb9_SnTl70Cunb2dYbfWRdiL-jGbrPm_EGPiN3okAxr9JgZtso8M&_nc_zt=23&_nc_ht=scontent.fcai20-5.fna&_nc_gid=s4Xp-kFIFpZbH8j0sOn_jA&oh=00_Af0dOoXSWtZ1U-Ke5q_9O1QL6DJWZHpIflDdX94QfN_YtQ&oe=69F1A152',
        originalPrice: 80,
        discountedPrice: 50,
      ),
      const OfferModel(
        id: '2',
        title: 'بيتزا بابا جونز',
        subtitle: 'بيتزا مارجريتا',
        discount: 'خصم 25 %',
        emoji: '🍕',
        primaryColor: Color(0xFFE53935),
        bgStart: Color(0xFFFFE5E5),
        bgEnd: Color(0xFFFFC8C8),
        imageUrl: 'https://scontent.fcai20-5.fna.fbcdn.net/v/t51.75761-15/491257270_18054925817239204_2555356597860424879_n.jpg?_nc_cat=102&ccb=1-7&_nc_sid=13d280&_nc_ohc=quahDlK-0m4Q7kNvwHPHVOE&_nc_oc=AdqGuqCJefolsD9Kb9_SnTl70Cunb2dYbfWRdiL-jGbrPm_EGPiN3okAxr9JgZtso8M&_nc_zt=23&_nc_ht=scontent.fcai20-5.fna&_nc_gid=s4Xp-kFIFpZbH8j0sOn_jA&oh=00_Af0dOoXSWtZ1U-Ke5q_9O1QL6DJWZHpIflDdX94QfN_YtQ&oe=69F1A152',
        originalPrice: 100,
        discountedPrice: 75,
      ),
      const OfferModel(
        id: '3',
        title: 'كريب ميكر',
        subtitle: 'كريب الشوكولاتة',
        discount: 'خصم 20 %',
        emoji: '🥞',
        primaryColor: Color(0xFF8E24AA),
        bgStart: Color(0xFFF3E5F5),
        bgEnd: Color(0xFFE1BEE7),
        imageUrl: 'https://scontent.fcai20-5.fna.fbcdn.net/v/t51.75761-15/491257270_18054925817239204_2555356597860424879_n.jpg?_nc_cat=102&ccb=1-7&_nc_sid=13d280&_nc_ohc=quahDlK-0m4Q7kNvwHPHVOE&_nc_oc=AdqGuqCJefolsD9Kb9_SnTl70Cunb2dYbfWRdiL-jGbrPm_EGPiN3okAxr9JgZtso8M&_nc_zt=23&_nc_ht=scontent.fcai20-5.fna&_nc_gid=s4Xp-kFIFpZbH8j0sOn_jA&oh=00_Af0dOoXSWtZ1U-Ke5q_9O1QL6DJWZHpIflDdX94QfN_YtQ&oe=69F1A152',
        originalPrice: 50,
        discountedPrice: 40,
      ),
      const OfferModel(
        id: '4',
        title: 'سندوتشات الفول',
        subtitle: 'سندوتش فول بالطحينة',
        discount: 'خصم 10 %',
        emoji: '🥙',
        primaryColor: Color(0xFF43A047),
        bgStart: Color(0xFFE8F5E9),
        bgEnd: Color(0xFFC8E6C9),
        imageUrl: 'https://scontent.fcai20-5.fna.fbcdn.net/v/t51.75761-15/491257270_18054925817239204_2555356597860424879_n.jpg?_nc_cat=102&ccb=1-7&_nc_sid=13d280&_nc_ohc=quahDlK-0m4Q7kNvwHPHVOE&_nc_oc=AdqGuqCJefolsD9Kb9_SnTl70Cunb2dYbfWRdiL-jGbrPm_EGPiN3okAxr9JgZtso8M&_nc_zt=23&_nc_ht=scontent.fcai20-5.fna&_nc_gid=s4Xp-kFIFpZbH8j0sOn_jA&oh=00_Af0dOoXSWtZ1U-Ke5q_9O1QL6DJWZHpIflDdX94QfN_YtQ&oe=69F1A152',
        originalPrice: 20,
        discountedPrice: 18,
      ),
    ];
  }

  @override
  Future<List<StoreModel>> getStores() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    return [
      const StoreModel(
        id: '1',
        name: 'كشري أبو طارق',
        category: 'مصري',
        deliveryTime: '٢٠-٣٠ دقيقة',
        deliveryFee: 'ج.م ١٠',
        rating: '٤.٨',
        emoji: '🍛',
        primaryColor: Color(0xFF6B4FD4),
      ),
      const StoreModel(
        id: '2',
        name: 'بيتزا هت',
        category: 'بيتزا',
        deliveryTime: '٢٥-٣٥ دقيقة',
        deliveryFee: 'ج.م ١٥',
        rating: '٤.٦',
        emoji: '🍕',
        primaryColor: Color(0xFFE53935),
      ),
      const StoreModel(
        id: '3',
        name: 'كريب ميكر',
        category: 'كريب',
        deliveryTime: '١٥-٢٥ دقيقة',
        deliveryFee: 'ج.م ٨',
        rating: '٤.٧',
        emoji: '🥞',
        primaryColor: Color(0xFF8E24AA),
      ),
      const StoreModel(
        id: '4',
        name: 'سندوتشات الفول',
        category: 'فول',
        deliveryTime: '١٠-٢٠ دقيقة',
        deliveryFee: 'ج.م ٥',
        rating: '٤.٩',
        emoji: '🥙',
        primaryColor: Color(0xFF43A047),
      ),
    ];
  }
}

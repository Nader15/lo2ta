import 'package:flutter/material.dart';
import 'package:lo2ta/modules/user_module/home/domain/entities/offer.dart';

class StoreLogo extends StatelessWidget {
  final Offer offer;

  const StoreLogo({super.key, required this.offer});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: CircleAvatar(
        backgroundImage: NetworkImage(offer.logoUrl),
      ),
    );
  }
}
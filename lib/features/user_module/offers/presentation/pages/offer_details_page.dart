import 'package:flutter/material.dart';
import 'package:lo2ta/core/theme/app_theme.dart';
import 'package:lo2ta/features/user_module/offers/domain/entities/offer_entity.dart';

class OfferDetailsPage extends StatelessWidget {
  final OfferEntity offer;
  const OfferDetailsPage({super.key, required this.offer});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(offer.title)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(height: 300, color: AppTheme.primaryColor.withOpacity(0.05), child: const Center(child: Icon(Icons.shopping_bag, size: 100, color: AppTheme.primaryColor))),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(offer.title, style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: 16),
                   Text(
                    '${offer.newPrice} EGP',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: AppTheme.primaryColor,
                          fontSize: 22,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

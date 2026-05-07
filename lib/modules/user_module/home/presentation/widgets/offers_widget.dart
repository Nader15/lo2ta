import 'package:flutter/material.dart';
import 'package:lo2ta/core/utils/clip_directions.dart';
import 'package:lo2ta/core/utils/slanted_clipper.dart';
import 'package:lo2ta/modules/user_module/home/domain/entities/offer.dart';
import 'package:lo2ta/modules/user_module/home/presentation/widgets/store_logo_widget.dart';
import 'package:lo2ta/modules/user_module/offers/presentation/pages/offer_details_page.dart';

class OffersWidget extends StatefulWidget {
  final List<Offer> offers;

  const OffersWidget({super.key, required this.offers});

  @override
  State<OffersWidget> createState() => _OffersWidgetState();
}

class _OffersWidgetState extends State<OffersWidget> {
  late final PageController _controller;
  double _page = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController(viewportFraction: 0.75)
      ..addListener(() {
        setState(() {
          _page = _controller.page ?? 0;
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height / 2.2,
      child: PageView.builder(
        controller: _controller,
        physics: const BouncingScrollPhysics(),
        itemCount: widget.offers.length,
        itemBuilder: (context, index) {
          final offer = widget.offers[index];
          final diff = (_page - index).abs();
          final scale = (1 - diff * 0.15).clamp(0.85, 1.0);

          return Center(
            child: Transform.scale(
              scale: scale,
              child: _HeroCardItem(
                offer: offer,
                direction: index.isEven
                    ? ClipDirection.left
                    : ClipDirection.right,
              ),
            ),
          );
        },
      ),
    );
  }
}

class _HeroCardItem extends StatelessWidget {
  final Offer offer;
  final ClipDirection direction;

  const _HeroCardItem({required this.offer, required this.direction});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => OfferDetailsPage(offer: offer)),
      ),
      child: ClipPath(
        clipper: SlantedClipper(direction: direction, radius: 40),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.network(offer.imageUrl, fit: BoxFit.fill),
            ),
            Positioned(
              right: 20,
              bottom: -30,
              child: Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.08),
                ),
              ),
            ),
            Positioned(
              top: 16,
              left: direction == ClipDirection.left ? 18 : null,
              right: direction == ClipDirection.right ? 18 : null,
              child: StoreLogo(offer: offer),
            ),
            Positioned(
              bottom: 18,
              left: 18,
              right: 18,
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.15),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '🔥 عرض محدود',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      offer.title,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      offer.subtitle,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withValues(alpha: 0.85),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          '${offer.discountedPrice.toInt()} جنية ',
                          style: Theme.of(
                            context,
                          ).textTheme.labelLarge?.copyWith(color: Colors.white),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          '${offer.originalPrice.toInt()} جنية ',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: Colors.white.withValues(alpha: 0.6),
                                decoration: TextDecoration.lineThrough,
                              ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.greenAccent.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            offer.discount,
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lo2ta/core/widgets/app_background_widget.dart';
import 'package:lo2ta/injection_container.dart';
import 'package:lo2ta/modules/user_module/home/domain/entities/offer.dart';
import 'package:lo2ta/modules/user_module/home/domain/entities/store.dart';
import 'package:lo2ta/modules/user_module/home/presentation/cubits/home_cubit.dart';
import 'package:lo2ta/modules/user_module/home/presentation/cubits/home_state.dart';
import 'package:lo2ta/modules/user_module/home/presentation/widgets/section_title_widget.dart';

class UserHomePage extends StatelessWidget {
  const UserHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<HomeCubit>()..loadHomeData(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFF6F4FF), Color(0xFFEDE7FF)],
            ),
          ),
          child: Stack(
            children: [
              const AppBackgroundWidget(),
              SafeArea(
                child: BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    if (state is UserHomeLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is UserHomeLoaded) {
                      return SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 16),
                            SectionTitle(
                              title: 'عروض لقطة متاحة حالياً',
                              badge: '🔥 كميات محدودة',
                              highlightWord: 'لقطة',
                              onTap: () {},
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              height: MediaQuery.sizeOf(context).height / 2.2,
                              child: _HeroCarousel(offers: state.offers),
                            ),
                            const SizedBox(height: 32),
                            SectionTitle(
                              title: 'متاجر عندها عروض لقطة',
                              badge: '⭐ أشهر المتاجر',
                              highlightWord: 'لقطة',
                              onTap: () {},
                            ),
                            const SizedBox(height: 16),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 16,
                                      mainAxisSpacing: 16,
                                      childAspectRatio: 0.85,
                                    ),
                                itemCount: state.stores.length,
                                itemBuilder: (context, index) {
                                  return _StoreCardItem(
                                    store: state.stores[index],
                                    direction: index.isEven
                                        ? ClipDirection.right
                                        : ClipDirection.left,
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 32),
                          ],
                        ),
                      );
                    } else if (state is UserHomeError) {
                      return Center(child: Text(state.message));
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeroCarousel extends StatefulWidget {
  final List<Offer> offers;

  const _HeroCarousel({required this.offers});

  @override
  State<_HeroCarousel> createState() => _HeroCarouselState();
}

class _HeroCarouselState extends State<_HeroCarousel> {
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
    return PageView.builder(
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
                  ? ClipDirection.right
                  : ClipDirection.left,
            ),
          ),
        );
      },
    );
  }
}

class _HeroCardItem extends StatelessWidget {
  final Offer offer;
  final ClipDirection direction;

  const _HeroCardItem({required this.offer, required this.direction});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: DiagonalCardClipper(direction: direction),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.network(offer.imageUrl, fit: BoxFit.cover),
            ),
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.05),
                      Colors.black.withValues(alpha: 0.25),
                      Colors.black.withValues(alpha: 0.65),
                    ],
                  ),
                ),
              ),
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
              left: direction == ClipDirection.right ? 18 : null,
              right: direction == ClipDirection.left ? 18 : null,
              child: _StoreLogo(offer: offer),
            ),
            Positioned(
              bottom: 18,
              left: 18,
              right: 18,
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
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
                          'EGP ${offer.discountedPrice.toInt()}',
                          style: Theme.of(
                            context,
                          ).textTheme.labelLarge?.copyWith(color: Colors.white),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'EGP ${offer.originalPrice.toInt()}',
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

class _StoreLogo extends StatelessWidget {
  final Offer offer;

  const _StoreLogo({required this.offer});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Icon(Icons.store, color: offer.primaryColor),
    );
  }
}

class _StoreCardItem extends StatelessWidget {
  final Store store;
  final ClipDirection direction;

  const _StoreCardItem({required this.store, required this.direction});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: DiagonalCardClipper(direction: direction),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                child: Stack(
                  children: [
                    Container(
                      height: 120,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            store.primaryColor,
                            store.primaryColor.withValues(alpha: 0.7),
                          ],
                        ),
                      ),
                      child: Center(
                        child: Text(
                          store.emoji,
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 16,
                      left: direction == ClipDirection.right ? 18 : null,
                      right: direction == ClipDirection.left ? 18 : null,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.9),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.star,
                              size: 12,
                              color: Color(0xFFFFB800),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              store.rating,
                              style: Theme.of(context).textTheme.labelSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF333333),
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      store.name,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1A1A1A),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 12,
                          color: Colors.grey.shade600,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          store.deliveryTime,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: store.primaryColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        store.category,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: store.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum ClipDirection { left, right }

class DiagonalCardClipper extends CustomClipper<Path> {
  final double offset;
  final double radius;
  final ClipDirection direction;

  const DiagonalCardClipper({
    this.offset = 20,
    this.radius = 40,
    this.direction = ClipDirection.left,
  });

  Path _buildLeft(Size size) {
    final r = radius;
    final cut = offset;
    final path = Path();
    path.moveTo(r, cut);
    path.lineTo(size.width - r, 0);
    path.quadraticBezierTo(size.width, 0, size.width, r);
    path.lineTo(size.width, size.height - r);
    path.quadraticBezierTo(
      size.width,
      size.height,
      size.width - r,
      size.height,
    );
    path.lineTo(r, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height - r);
    path.lineTo(0, cut + r);
    path.quadraticBezierTo(0, cut, r, cut);
    path.close();
    return path;
  }

  @override
  Path getClip(Size size) {
    final path = _buildLeft(size);
    if (direction == ClipDirection.right) {
      final matrix = Matrix4.identity()
        ..translate(size.width)
        ..scale(-1.0, 1.0);
      return path.transform(matrix.storage);
    }
    return path;
  }

  @override
  bool shouldReclip(DiagonalCardClipper old) =>
      old.offset != offset ||
      old.radius != radius ||
      old.direction != direction;
}

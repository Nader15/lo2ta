import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lo2ta/features/user_module/home/presentation/widgets/section_title_widget.dart';
import 'package:lo2ta/features/user_module/home/presentation/widgets/app_background_widget.dart';

// ─── Home Screen ─────────────────────────────────────────────────────────────

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<UserHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Make scaffold transparent
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
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),

                    // ─── Hero Section Title ─────────────────────────────────────────────
                    SectionTitle(
                      title: 'عروض لقطة متاحة حالياً',
                      badge: '🔥 كميات محدودة',
                      highlightWord: 'لقطة',
                      onTap: () {},
                    ),

                    const SizedBox(height: 16),

                    // ─── Hero Carousel ─────────────────────────────────────
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height / 2.2,
                      child: const _HeroCarousel(),
                    ),

                    const SizedBox(height: 32),

                    // ─── Stores Section Title ─────────────────────────────────────────────
                    SectionTitle(
                      title: 'متاجر عندها عروض لقطة',
                      badge: '⭐ أشهر المتاجر',
                      highlightWord: 'لقطة',
                      onTap: () {},
                    ),

                    const SizedBox(height: 16),

                    // ─── Stores Grid ─────────────────────────────────────
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
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
                        itemCount: _storeData.length,
                        itemBuilder: (context, index) {
                          return _StoreCardItem(
                            store: _storeData[index],
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Hero Carousel ──────────────────────────────────────────────────────────

class _HeroCarousel extends StatefulWidget {
  const _HeroCarousel();

  @override
  State<_HeroCarousel> createState() => _HeroCarouselState();
}

class _HeroCarouselState extends State<_HeroCarousel> {
  late final PageController _controller;

  double _page = 0;

  static const _data = [
    _HeroInfo(
      title: 'كشري الخديوي',
      subtitle: 'وجبة كشري الخديوي',
      discount: 'خصم 36 %',
      emoji: '🍛',
      primaryColor: Color(0xFF6B4FD4),
      bgStart: Color(0xFFE8E0FA),
      bgEnd: Color(0xFFD5C8F7),
    ),
    _HeroInfo(
      title: 'بيتزا بابا جونز',
      subtitle: 'بيتزا مارجريتا',
      discount: 'خصم 25 %',
      emoji: '🍕',
      primaryColor: Color(0xFFE53935),
      bgStart: Color(0xFFFFE5E5),
      bgEnd: Color(0xFFFFC8C8),
    ),
    _HeroInfo(
      title: 'سندوتشات فلافل',
      subtitle: 'سندوتشات فلافل طازجة',
      discount: 'خصم 40 %',
      emoji: '🌯',
      primaryColor: Color(0xFF43A047),
      bgStart: Color(0xFFE8F5E9),
      bgEnd: Color(0xFFC8E6C9),
    ),
    _HeroInfo(
      title: 'كريب الشوكولاتة',
      subtitle: 'كريب بالشوكولاتة اللذيذة',
      discount: 'خصم 30 %',
      emoji: '🍫',
      primaryColor: Color(0xFF8E24AA),
      bgStart: Color(0xFFF3E5F5),
      bgEnd: Color(0xFFE1BEE7),
    ),
    _HeroInfo(
      title: 'عصير الفواكه الطازجة',
      subtitle: 'عصير فواكه طازجة ومنعشة',
      discount: 'خصم 20 %',
      emoji: '🍹',
      primaryColor: Color(0xFFFB8C00),
      bgStart: Color(0xFFFFF3E0),
      bgEnd: Color(0xFFFFD180),
    ),
    _HeroInfo(
      title: 'كعكة الشوكولاتة',
      subtitle: 'كعكة شوكولاتة لذيذة',
      discount: 'خصم 35 %',
      emoji: '🍰',
      primaryColor: Color(0xFFD32F2F),
      bgStart: Color(0xFFFFE5E5),
      bgEnd: Color(0xFFFFC8C8),
    ),
  ];

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
      itemCount: _data.length,
      itemBuilder: (context, index) {
        final info = _data[index];

        final diff = (_page - index).abs();
        final scale = (1 - diff * 0.15).clamp(0.85, 1.0);

        return Center(
          child: Transform.scale(
            scale: scale,
            child: _HeroCardItem(
              info: info,
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

// ─── Hero Card ──────────────────────────────────────────────────────────────

class _HeroCardItem extends StatelessWidget {
  final _HeroInfo info;
  final ClipDirection direction;

  const _HeroCardItem({required this.info, required this.direction});

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
              color: Colors.black.withOpacity(0.15),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Stack(
          children: [
            // ───────── FULL BACKGROUND IMAGE ─────────
            Positioned.fill(
              child: Image.network(
                'https://scontent.fcai20-5.fna.fbcdn.net/v/t51.75761-15/491257270_18054925817239204_2555356597860424879_n.jpg?_nc_cat=102&ccb=1-7&_nc_sid=13d280&_nc_ohc=quahDlK-0m4Q7kNvwHPHVOE&_nc_oc=AdqGuqCJefolsD9Kb9_SnTl70Cunb2dYbfWRdiL-jGbrPm_EGPiN3okAxr9JgZtso8M&_nc_zt=23&_nc_ht=scontent.fcai20-5.fna&_nc_gid=s4Xp-kFIFpZbH8j0sOn_jA&oh=00_Af0dOoXSWtZ1U-Ke5q_9O1QL6DJWZHpIflDdX94QfN_YtQ&oe=69F1A152',
                fit: BoxFit.cover,
              ),
            ),

            // ───────── DARK GRADIENT OVERLAY ─────────
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.05),
                      Colors.black.withOpacity(0.25),
                      Colors.black.withOpacity(0.65),
                    ],
                  ),
                ),
              ),
            ),

            // ───────── BACKGROUND CIRCLE (optional accent) ─────────
            Positioned(
              right: 20,
              bottom: -30,
              child: Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.08),
                ),
              ),
            ),

            // ───────── STORE LOGO ─────────
            Positioned(
              top: 16,
              left: direction == ClipDirection.right ? 18 : null,
              right: direction == ClipDirection.left ? 18 : null,
              child: _StoreLogo(info: info),
            ),

            // ───────── CONTENT ─────────
            Positioned(
              bottom: 18,
              left: 18,
              right: 18,
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white.withOpacity(0.15)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // ───── SMALL TAG / CATEGORY ─────
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
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

                    // ───── TITLE ─────
                    Text(
                      info.title,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),

                    const SizedBox(height: 4),

                    // ───── SUBTITLE ─────
                    Text(
                      info.subtitle,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withOpacity(0.85),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // ───── PRICE ROW ─────
                    Row(
                      children: [
                        Text(
                          'EGP 50',
                          style: Theme.of(
                            context,
                          ).textTheme.labelLarge?.copyWith(color: Colors.white),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'EGP 80',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: Colors.white.withOpacity(0.6),
                                decoration: TextDecoration.lineThrough,
                              ),
                        ),

                        const Spacer(),

                        // optional discount pill
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.greenAccent.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            info.discount,
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
  final _HeroInfo info;

  const _StoreLogo({required this.info});

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
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: const Icon(Icons.store, color: Color(0xFF6B4FD4)),
    );
  }
}

// ─── Store Card Component (Smaller & Different Appearance) ─────────────────

class _StoreCardItem extends StatelessWidget {
  final _StoreInfo store;
  final ClipDirection direction;

  const _StoreCardItem({required this.store, required this.direction});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: DiagonalCardClipper(direction: direction),
      child: GestureDetector(
        onTap: () {
          // Add navigation to store details
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Store Image/Banner
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
                            store.primaryColor.withOpacity(0.7),
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
                          color: Colors.white.withOpacity(0.9),
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

              // Store Details
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            store.name,
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF1A1A1A),
                                ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
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
                        const SizedBox(width: 8),
                        Icon(
                          Icons.local_offer,
                          size: 12,
                          color: Colors.grey.shade600,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          store.deliveryFee,
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
                        color: store.primaryColor.withOpacity(0.1),
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

// ─── Store Data Model ───────────────────────────────────────────────────────

class _StoreInfo {
  final String name;
  final String category;
  final String deliveryTime;
  final String deliveryFee;
  final String rating;
  final String emoji;
  final Color primaryColor;

  const _StoreInfo({
    required this.name,
    required this.category,
    required this.deliveryTime,
    required this.deliveryFee,
    required this.rating,
    required this.emoji,
    required this.primaryColor,
  });
}

// ─── Store Data ─────────────────────────────────────────────────────────────

final List<_StoreInfo> _storeData = [
  const _StoreInfo(
    name: 'كشري أبو طارق',
    category: 'مصري',
    deliveryTime: '٢٠-٣٠ دقيقة',
    deliveryFee: 'ج.م ١٠',
    rating: '٤.٨',
    emoji: '🍛',
    primaryColor: Color(0xFF6B4FD4),
  ),
  const _StoreInfo(
    name: 'بيتزا هت',
    category: 'بيتزا',
    deliveryTime: '٢٥-٣٥ دقيقة',
    deliveryFee: 'ج.م ١٥',
    rating: '٤.٦',
    emoji: '🍕',
    primaryColor: Color(0xFFE53935),
  ),
  const _StoreInfo(
    name: 'ماكدونالدز',
    category: 'وجبات سريعة',
    deliveryTime: '١٥-٢٥ دقيقة',
    deliveryFee: 'ج.م ١٢',
    rating: '٤.٧',
    emoji: '🍔',
    primaryColor: Color(0xFFFBC02D),
  ),
  const _StoreInfo(
    name: 'ستاربكس',
    category: 'قهوة',
    deliveryTime: '٢٠-٣٠ دقيقة',
    deliveryFee: 'ج.م ١٠',
    rating: '٤.٩',
    emoji: '☕',
    primaryColor: Color(0xFF2E7D32),
  ),
];

// ─── Data Model ─────────────────────────────────────────────────────────────

class _HeroInfo {
  final String title;
  final String subtitle;
  final String discount;
  final String emoji;
  final Color primaryColor;
  final Color bgStart;
  final Color bgEnd;

  const _HeroInfo({
    required this.title,
    required this.subtitle,
    required this.discount,
    required this.emoji,
    required this.primaryColor,
    required this.bgStart,
    required this.bgEnd,
  });
}

// ─── Direction Enum ─────────────────────────────────────────────────────────

enum ClipDirection { left, right }

// ─── FIXED: Clean + consistent mirrored clipper ─────────────────────────────

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

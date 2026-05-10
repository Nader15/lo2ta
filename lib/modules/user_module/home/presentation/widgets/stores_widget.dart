import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lo2ta/core/utils/clip_directions.dart';
import 'package:lo2ta/core/utils/slanted_clipper.dart';
import 'package:lo2ta/modules/user_module/home/domain/entities/offer.dart';
import 'package:lo2ta/modules/user_module/home/domain/entities/store.dart';
import 'package:lo2ta/modules/user_module/home/presentation/cubits/home_cubit.dart';
import 'package:lo2ta/modules/user_module/stores/presentation/pages/store_details_page.dart';

class StoresWidget extends StatelessWidget {
  final List<Store> stores;
  final List<Offer> offers;

  const StoresWidget({
    super.key,
    required this.stores,
    required this.offers,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.72,
        ),
        itemCount: stores.length,
        itemBuilder: (context, index) {
          final store = stores[index];

          final storeOffers = offers
              .where((o) => o.store?.id == store.id)
              .toList();

          return StoresCardItem(
            store: store,
            storeOffers: storeOffers,
            direction:
            index.isEven ? ClipDirection.left : ClipDirection.right,
          );
        },
      ),
    );
  }
}

class StoresCardItem extends StatelessWidget {
  final Store store;
  final List<Offer> storeOffers;
  final ClipDirection direction;

  const StoresCardItem({
    super.key,
    required this.store,
    required this.storeOffers,
    required this.direction,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: SlantedClipper(direction: direction),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (childContext) => BlocProvider.value(
                value: context.read<HomeCubit>(),
                child: StoreDetailsPage(
                  store: store,
                  storeOffers: storeOffers,
                ),
              ),
            ),
          );
        },
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
            children: [
              /// IMAGE
              Expanded(
                flex: 5,
                child: Container(
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
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(store.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

              /// CONTENT
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// STORE NAME
                      Text(
                        store.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1A1A1A),
                        ),
                      ),

                      const SizedBox(height: 10),

                      /// TAGS
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            /// CATEGORY
                            Expanded(
                              child: _InfoCard(
                                color: store.primaryColor,
                                child: Text(
                                  store.category,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall
                                      ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: store.primaryColor,
                                  ),
                                ),
                              ),
                            ),

                            if (store.distance != null) ...[
                              const SizedBox(width: 5),

                              /// DISTANCE
                              Expanded(
                                child: _InfoCard(
                                  color: store.primaryColor,
                                  child: Text(
                                    "يبعد\n${store.distance}\nكم",
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall
                                        ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF333333),
                                    ),
                                  ),
                                ),
                              ),
                            ],

                            const SizedBox(width: 5),

                            /// OFFERS COUNT
                            Expanded(
                              child: _InfoCard(
                                color: store.primaryColor,
                                child: Text(
                                  "عندة\n${store.offersCount} عرض\nلقطة",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall
                                      ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF333333),
                                  ),
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
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final Widget child;
  final Color color;

  const _InfoCard({
    required this.child,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(
        horizontal: 6,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: child,
      ),
    );
  }
}
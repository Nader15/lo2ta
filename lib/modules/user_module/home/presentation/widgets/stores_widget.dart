import 'package:flutter/material.dart';
import 'package:lo2ta/core/utils/clip_directions.dart';
import 'package:lo2ta/core/utils/slanted_clipper.dart';
import 'package:lo2ta/modules/user_module/home/domain/entities/store.dart';

class StoresWidget extends StatelessWidget {
  final List<Store> stores;

  const StoresWidget({super.key, required this.stores});

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
          childAspectRatio: 0.85,
        ),
        itemCount: stores.length,
        itemBuilder: (context, index) {
          return StoresCardItem(
            store: stores[index],
            direction: index.isEven ? ClipDirection.left : ClipDirection.right,
          );
        },
      ),
    );
  }
}

class StoresCardItem extends StatelessWidget {
  final Store store;
  final ClipDirection direction;

  const StoresCardItem({required this.store, required this.direction});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: SlantedClipper(direction: direction),
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
              Expanded(
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
                      image: NetworkImage(store.imageUrl),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            store.name,
                            textAlign: TextAlign.start,
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF1A1A1A),
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            // decoration: BoxDecoration(
                            //   color: store.primaryColor.withValues(alpha: 0.1),
                            //   borderRadius: BorderRadius.circular(24),
                            // ),
                            child: Text(
                              store.category,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: store.primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: store.primaryColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "عندة\n ${store.offersCount} عرض\n لقطة ",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF333333),
                            ),
                          ),
                          const SizedBox(height: 2),
                        ],
                      ),
                    )
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

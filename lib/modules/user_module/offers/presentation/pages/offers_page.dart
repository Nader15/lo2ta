import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lo2ta/core/widgets/app_background_widget.dart';
import 'package:lo2ta/injection_container.dart';
import 'package:lo2ta/modules/user_module/home/domain/entities/offer.dart';
import 'package:lo2ta/modules/user_module/home/presentation/cubits/home_cubit.dart';
import 'package:lo2ta/modules/user_module/home/presentation/cubits/home_state.dart';
import 'package:lo2ta/modules/user_module/home/presentation/widgets/section_title_widget.dart';
import 'package:lo2ta/modules/user_module/offers/presentation/widgets/offer_card_widget.dart';
import 'package:lo2ta/modules/user_module/offers/presentation/widgets/offers_filters_widget.dart';

class OffersListPage extends StatefulWidget {
  const OffersListPage({super.key});

  @override
  State<OffersListPage> createState() => _OffersListPageState();
}

class _OffersListPageState extends State<OffersListPage> {
  String? _selectedCategory;
  bool _sortByNearest = false;

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
                      List<Offer> filteredOffers = _selectedCategory == null
                          ? List.from(state.offers)
                          : state.offers
                              .where((o) => o.category == _selectedCategory)
                              .toList();

                      if (_sortByNearest) {
                        filteredOffers.sort((a, b) => (a.distance ?? double.infinity)
                            .compareTo(b.distance ?? double.infinity));
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16),
                          SectionTitle(
                            title: 'اكتشف أقوى عروض لقطة',
                            badge: '💎 عروض حصرية',
                            highlightWord: 'لقطة',
                          ),
                          const SizedBox(height: 16),
                          OffersFiltersWidget(
                            onFilterChanged: (category) {
                              setState(() {
                                _selectedCategory = category;
                                _sortByNearest = false; // Reset sorting if category changes? Or keep it? 
                                // User usually expects category first.
                              });
                            },
                            onNearestToggled: (isNearest) {
                              setState(() {
                                _sortByNearest = isNearest;
                                if (isNearest) _selectedCategory = null;
                              });
                            },
                          ),
                          const SizedBox(height: 10),
                          Expanded(
                            child: filteredOffers.isEmpty
                                ? const Center(
                                    child: Text(
                                      'لا يوجد عروض في هذا القسم حالياً',
                                      style: TextStyle(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  )
                                : ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    padding: const EdgeInsets.only(bottom: 100),
                                    itemCount: filteredOffers.length,
                                    itemBuilder: (context, index) {
                                      return OfferCardWidget(
                                        offer: filteredOffers[index],
                                      );
                                    },
                                  ),
                          ),
                        ],
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

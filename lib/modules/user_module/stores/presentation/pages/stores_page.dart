import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lo2ta/core/widgets/app_background_widget.dart';
import 'package:lo2ta/injection_container.dart';
import 'package:lo2ta/modules/user_module/home/domain/entities/store.dart';
import 'package:lo2ta/modules/user_module/home/presentation/cubits/home_cubit.dart';
import 'package:lo2ta/modules/user_module/home/presentation/cubits/home_state.dart';
import 'package:lo2ta/modules/user_module/home/presentation/widgets/section_title_widget.dart';
import 'package:lo2ta/modules/user_module/stores/presentation/widgets/store_card_widget.dart';
import 'package:lo2ta/modules/user_module/stores/presentation/widgets/stores_filters_widget.dart';

class StoresListPage extends StatefulWidget {
  const StoresListPage({super.key});

  @override
  State<StoresListPage> createState() => _StoresListPageState();
}

class _StoresListPageState extends State<StoresListPage> {
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
                      List<Store> filteredStores = _selectedCategory == null
                          ? List.from(state.stores)
                          : state.stores
                                .where((s) => s.category == _selectedCategory)
                                .toList();

                      if (_sortByNearest) {
                        filteredStores.sort(
                          (a, b) => (a.distance ?? double.infinity).compareTo(
                            b.distance ?? double.infinity,
                          ),
                        );
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16),
                          SectionTitle(
                            title: 'أماكن فيها عروض لقطة',
                            badge: '⭐ أشهر الأماكن',
                            highlightWord: 'لقطة',
                          ),
                          const SizedBox(height: 16),
                          StoresFiltersWidget(
                            onFilterChanged: (category) {
                              setState(() {
                                _selectedCategory = category;
                                _sortByNearest = false;
                              });
                            },
                            onNearestToggled: (isNearest) {
                              setState(() {
                                _sortByNearest = isNearest;
                                if (isNearest) _selectedCategory = null;
                              });
                            },
                          ),
                          const SizedBox(height: 16),
                          Expanded(
                            child: filteredStores.isEmpty
                                ? const Center(
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 100),
                                      child: Text(
                                        'لا توجد متاجر في هذا القسم حالياً',
                                        style: TextStyle(
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  )
                                : ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: filteredStores.length,
                                    itemBuilder: (context, index) {
                                      return StoreCardWidget(
                                        store: filteredStores[index],
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

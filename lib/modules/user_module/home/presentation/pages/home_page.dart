import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lo2ta/core/widgets/app_background_widget.dart';
import 'package:lo2ta/injection_container.dart';
import 'package:lo2ta/modules/user_module/home/presentation/cubits/home_cubit.dart';
import 'package:lo2ta/modules/user_module/home/presentation/cubits/home_state.dart';
import 'package:lo2ta/modules/user_module/home/presentation/widgets/offers_widget.dart';
import 'package:lo2ta/modules/user_module/home/presentation/widgets/section_title_widget.dart';
import 'package:lo2ta/modules/user_module/home/presentation/widgets/stores_widget.dart';

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
                            OffersWidget(offers: state.offers),
                            const SizedBox(height: 32),
                            SectionTitle(
                              title: 'أماكن فيها عروض لقطة',
                              badge: '⭐ أشهر الأماكن',
                              highlightWord: 'لقطة',
                              onTap: () {},
                            ),
                            const SizedBox(height: 16),
                            StoresWidget(
                              stores: state.stores,
                              offers: state.offers,
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

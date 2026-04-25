import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lo2ta/core/theme/app_theme.dart';
import 'package:lo2ta/features/auth_module/presentation/blocs/auth_cubit.dart';
import 'package:lo2ta/features/auth_module/presentation/pages/login_page.dart';
import 'package:lo2ta/features/auth_module/presentation/pages/register_page.dart';
import 'package:lo2ta/features/auth_module/presentation/widgets/premium_button.dart';
import 'package:lo2ta/features/auth_module/presentation/pages/onboarding_details_page.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});
  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  final List<OnboardingContent> _content = [
    OnboardingContent(title: 'Find Amazing Deals', description: 'Discover the best offers near you.', icon: Icons.local_offer_rounded),
    OnboardingContent(title: 'Stay Notified', description: 'Follow stores and get alerts.', icon: Icons.notifications_active_rounded),
    OnboardingContent(title: 'Save Money', description: 'Compare prices and save.', icon: Icons.savings_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(decoration: const BoxDecoration(gradient: LinearGradient(colors: [Colors.white, Color(0xFFFDEEF0)], begin: Alignment.topCenter, end: Alignment.bottomCenter))),
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) => setState(() => _currentIndex = index),
            itemCount: _content.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(padding: const EdgeInsets.all(40), decoration: BoxDecoration(color: AppTheme.primaryColor.withOpacity(0.1), shape: BoxShape.circle), child: Icon(_content[index].icon, size: 100, color: AppTheme.primaryColor)).animate(key: ValueKey(index)).scale(duration: 600.ms, curve: Curves.elasticOut),
                  const SizedBox(height: 60),
                  Text(_content[index].title, style: Theme.of(context).textTheme.headlineSmall, textAlign: TextAlign.center).animate(key: ValueKey('t$index')).fadeIn().slideY(begin: 0.2, end: 0),
                  const SizedBox(height: 16),
                  Text(_content[index].description, style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.black54), textAlign: TextAlign.center).animate(key: ValueKey('d$index')).fadeIn(delay: 200.ms).slideY(begin: 0.2, end: 0),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 40, left: 24, right: 24,
            child: Column(
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.center, children: List.generate(_content.length, (index) => AnimatedContainer(duration: 300.ms, margin: const EdgeInsets.only(right: 8), height: 8, width: _currentIndex == index ? 24 : 8, decoration: BoxDecoration(color: _currentIndex == index ? AppTheme.primaryColor : Colors.grey[300], borderRadius: BorderRadius.circular(4))))),
                const SizedBox(height: 48),
                if (_currentIndex == _content.length - 1)
                  PremiumButton(text: 'GET STARTED', onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LocationSelectionPage()))).animate().scale().fadeIn()
                else
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(onPressed: () => _pageController.animateToPage(_content.length - 1, duration: 600.ms, curve: Curves.easeOut), child: const Text('SKIP')),
                      ElevatedButton(onPressed: () => _pageController.nextPage(duration: 300.ms, curve: Curves.easeIn), child: const Text('NEXT')).animate().fadeIn(),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingContent {
  final String title; final String description; final IconData icon;
  OnboardingContent({required this.title, required this.description, required this.icon});
}

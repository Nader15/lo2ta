import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lo2ta/core/theme/app_theme.dart';
import 'package:lo2ta/features/auth_module/presentation/blocs/auth_cubit.dart';
import 'package:lo2ta/features/auth_module/presentation/pages/onboarding_page.dart';
import 'package:lo2ta/features/auth_module/domain/entities/user_entity.dart';
import 'package:lo2ta/features/user_module/home/presentation/pages/main_wrapper.dart';
import 'package:lo2ta/features/store_module/dashboard/presentation/pages/main_wrapper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() { super.initState(); context.read<AuthCubit>().checkAuthStatus(); }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => state.user.role == UserRole.user
                  ? const UserMainWrapper()
                  : const StoreMainWrapper(),
            ),
          );
        } else if (state is Unauthenticated || state is AuthError) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const OnboardingPage()));
        }
      },
      child: Scaffold(
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(gradient: AppTheme.premiumGradient),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(padding: const EdgeInsets.all(32), decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle), child: const Icon(Icons.shopping_cart_outlined, size: 80, color: AppTheme.primaryColor)).animate().scale(duration: 800.ms, curve: Curves.elasticOut),
              const SizedBox(height: 24),
              Text(
                'LO2TA',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: Colors.white,
                      letterSpacing: 4,
                    ),
              ).animate().fadeIn(delay: 400.ms).moveY(begin: 20, end: 0),
            ],
          ),
        ),
      ),
    );
  }
}

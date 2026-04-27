import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:lo2ta/core/theme/app_theme.dart';
import 'package:lo2ta/injection_container.dart' as di;
import 'package:firebase_core/firebase_core.dart';
import 'package:lo2ta/modules/auth_module/presentation/cubits/auth_cubit.dart';
import 'package:lo2ta/modules/auth_module/presentation/pages/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  runApp(const Lo2taApp());
}

class Lo2taApp extends StatelessWidget {
  const Lo2taApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => di.sl<AuthCubit>())],
      child: MaterialApp(
        title: 'LO2TA',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const SplashScreen(),
        locale: const Locale('ar'),
        // ─── THEME ─────────────────────────────────────────────

        // ─── LOCALIZATION ──────────────────────────────────────
        supportedLocales: const [
          Locale('en'),
          Locale('ar'),
        ],

        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
      ),
    );
  }
}

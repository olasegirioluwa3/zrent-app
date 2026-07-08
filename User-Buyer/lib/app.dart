import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/presentation/screens/splash_screen.dart';
import 'features/home/presentation/screens/home_screen.dart';

/// Root widget for ZRent Buyer App.
/// Wraps MaterialApp with:
/// - App theme
/// - Splash screen (initial screen)
class ZRentBuyerApp extends ConsumerWidget {
  const ZRentBuyerApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'ZRent Buyer',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      home: const SplashScreen(),
    );
  }
}

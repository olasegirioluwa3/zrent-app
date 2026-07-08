import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/home_header.dart';
import '../widgets/promo_banner.dart';
import '../widgets/property_grid.dart';
import '../widgets/bottom_nav_bar.dart';
import '../providers/location_provider.dart';

/// Home Screen - ZRent Buyer App
///
/// Stack layout:
///   Layer 0 (back)  → SingleChildScrollView with PromoBanner + PropertyGrid
///                      starts with top padding equal to header height so the
///                      content begins below the header and scrolls up behind it.
///   Layer 1 (front) → HomeHeader pinned at top — NEVER moves.
///   Bottom          → BottomNavBar pinned at bottom — NEVER moves.
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(locationProvider.notifier).requestAndFetchLocation();
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: Column(
        children: [
          // ── Stack: scrollable feed behind the fixed header ───────────
          Expanded(
            child: Stack(
              children: [
                // ── Layer 0: Scrollable content (BEHIND the header) ────
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      // Push content below the header so it starts visible
                      SizedBox(height: HomeHeader.headerHeight + 16),
                      PromoBanner(),
                      SizedBox(height: 24),
                      PropertyGrid(),
                      SizedBox(height: 32),
                    ],
                  ),
                ),

                // ── Layer 1: Fixed HomeHeader (ON TOP, never moves) ────
                const Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: HomeHeader(),
                ),
              ],
            ),
          ),

          // ── Fixed BottomNavBar (never moves) ─────────────────────────
          const BottomNavBar(),
        ],
      ),
    );
  }
}

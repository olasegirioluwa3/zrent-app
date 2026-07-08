import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'search_bar.dart';
import 'category_chips.dart';
import '../providers/location_provider.dart';

/// Home Header Widget - ZRent Buyer App
///
/// Green background (with transparent house image overlay) +
/// floating white card at the bottom containing search bar & category chips.
/// This header is FIXED — it never scrolls.
class HomeHeader extends ConsumerWidget {
  const HomeHeader({super.key});

  /// Total visual height of this widget.
  /// Green section = 160, floating card overlap below = 100 → total = 260
  static const double headerHeight = 240;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationState = ref.watch(locationProvider);

    return SizedBox(
      height: headerHeight,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // ── Green background with transparent house image ──────────
          Container(
            height: 160,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFF064E3B),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
              image: DecorationImage(
                image: AssetImage('assets/header_house.png'),
                fit: BoxFit.cover,
                opacity: 0.15,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFF042F2C).withOpacity(0.4),
                    const Color(0xFF064E3B).withOpacity(0.85),
                  ],
                ),
              ),
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 6),
                      // ── Location row with dropdown ─────────────────
                      PopupMenuButton<String>(
                        offset: const Offset(0, 36),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        onSelected: (value) =>
                            ref.read(locationProvider.notifier).setLocation(value),
                        itemBuilder: (_) => [
                          'Lagos, Nigeria',
                          'Abuja, Nigeria',
                          'Ibadan, Nigeria',
                          'Port Harcourt, Nigeria',
                          'Kano, Nigeria',
                          'Enugu, Nigeria',
                        ]
                            .map(
                              (city) => PopupMenuItem(
                                value: city,
                                child: Text(
                                  city,
                                  style: GoogleFonts.poppins(fontSize: 14),
                                ),
                              ),
                            )
                            .toList(),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: Color(0xFFBEF264),
                              size: 22,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              locationState.isLoading
                                  ? 'Detecting...'
                                  : locationState.selectedLocation,
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 2),
                            const Icon(
                              Icons.arrow_drop_down,
                              color: Colors.white,
                              size: 22,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // ── Floating white card (search + categories) ──────────────
          Positioned(
            top: 80,
            left: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.07),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  SearchBarWidget(),
                  SizedBox(height: 14),
                  CategoryChips(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

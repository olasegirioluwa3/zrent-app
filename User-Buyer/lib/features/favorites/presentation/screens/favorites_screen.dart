import 'package:flutter/material.dart';
import '../widgets/favorites_app_bar.dart';
import '../widgets/orders_list.dart';
import '../widgets/saved_properties_grid.dart';
import '../../../home/presentation/widgets/bottom_nav_bar.dart';

/// Favorites Screen - ZRent Buyer App
///
/// Layout matching the Figma design screenshot:
/// - Clean search bar at the top (app bar)
/// - Orders List horizontal scrolling feed
/// - Saved property grid (2-column layout)
/// - Persistent bottom navigation bar (Favorites index 2)
class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // App Bar with search input & location
            const FavoritesAppBar(),
            // Scrollable Content area
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    SizedBox(height: 12),
                    OrdersList(),
                    SizedBox(height: 24),
                    SavedPropertiesGrid(),
                    SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // Persistent Bottom Navigation Bar
      bottomNavigationBar: const BottomNavBar(initialIndex: 2),
    );
  }
}

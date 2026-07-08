import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../widgets/favorites_header.dart';
import '../widgets/favorites_filter.dart';
import '../widgets/favorite_property_card.dart';

/// Favorites Screen - ZRent Buyer App
/// 
/// Saved/favorite properties with:
/// - Header with title
/// - Filter options
/// - Grid of saved properties
class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            const FavoritesHeader(),
            const SizedBox(height: 16),
            const FavoritesFilter(),
            const SizedBox(height: 24),
            // Property Grid
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return FavoritePropertyCard(
                      imageUrl: 'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?w=400',
                      title: 'Modern Apartment',
                      location: 'Lekki, Lagos',
                      price: '₦450,000',
                      rating: 4.8,
                      onRemove: () {},
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 100), // Space for bottom nav
          ],
        ),
      ),
    );
  }
}

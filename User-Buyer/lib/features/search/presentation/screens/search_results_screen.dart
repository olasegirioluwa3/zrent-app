import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../widgets/search_header.dart';
import '../widgets/search_filter_chips.dart';
import '../widgets/search_property_card.dart';

/// Search Results Screen - ZRent Buyer App
/// 
/// Shows search results with:
/// - Search bar with query
/// - Filter options
/// - Results count
/// - Property grid
class SearchResultsScreen extends StatelessWidget {
  final String searchQuery;

  const SearchResultsScreen({
    super.key,
    required this.searchQuery,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            SearchHeader(searchQuery: searchQuery),
            const SizedBox(height: 16),
            const SearchFilterChips(),
            const SizedBox(height: 24),
            // Results Grid
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
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    return SearchPropertyCard(
                      imageUrl: 'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?w=400',
                      title: 'Modern Apartment',
                      location: 'Lekki, Lagos',
                      price: '₦450,000',
                      rating: 4.8,
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

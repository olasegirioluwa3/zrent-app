import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/providers/filtered_properties_provider.dart';
import '../../../home/presentation/providers/location_provider.dart';
import '../widgets/search_header.dart';
import '../widgets/search_filter_chips.dart';
import '../widgets/search_property_card.dart';

/// Search Results Screen - ZRent Buyer App
///
/// Shows properties filtered by:
///  1. The globally-selected location (country / city) from [locationProvider].
///  2. The user-typed [searchQuery] (matches title or location text).
///
/// An empty state is shown when no results match both filters.
class SearchResultsScreen extends ConsumerWidget {
  final String searchQuery;

  const SearchResultsScreen({
    super.key,
    required this.searchQuery,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationState = ref.watch(locationProvider);

    // Start from the location-filtered list, then narrow by the search query
    final locationFiltered = ref.watch(filteredPropertiesProvider);
    final results = searchQuery.trim().isEmpty
        ? locationFiltered
        : locationFiltered.where((p) {
            final q = searchQuery.toLowerCase();
            return p.title.toLowerCase().contains(q) ||
                p.location.toLowerCase().contains(q);
          }).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            SearchHeader(searchQuery: searchQuery),
            const SizedBox(height: 16),
            const SearchFilterChips(),
            const SizedBox(height: 16),

            // ── Results count badge ────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Text(
                    '${results.length} result${results.length == 1 ? '' : 's'}',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF042F2C),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE2F9B8),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      locationState.selectedLocation,
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF042F2C),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // ── Results grid / empty state ─────────────────────────────────
            Expanded(
              child: results.isEmpty
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 64,
                              height: 64,
                              decoration: BoxDecoration(
                                color: const Color(0xFF042F2C).withOpacity(0.05),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.search_off_rounded,
                                color: Color(0xFF042F2C),
                                size: 28,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'No results found',
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF042F2C),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'No properties match "$searchQuery" in ${locationState.selectedLocation}.\nTry a different keyword or change your location.',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontSize: 12.5,
                                color: const Color(0xFF6B7280),
                                fontWeight: FontWeight.w400,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 0.75,
                        ),
                        itemCount: results.length,
                        itemBuilder: (context, index) {
                          final prop = results[index];
                          return SearchPropertyCard(
                            propertyId: prop.id,
                            imageUrl: prop.imageUrl,
                            title: prop.title,
                            location: prop.location,
                            price: prop.price,
                            rating: 4.8,
                          );
                        },
                      ),
                    ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}

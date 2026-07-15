import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../shared/providers/properties_provider.dart';
import '../../../home/presentation/widgets/property_card.dart';

/// Saved Properties Grid Widget - ZRent Buyer App
///
/// Watches the shared propertiesProvider and renders a 2-column grid of properties
/// that have been favorited by the user (isFavorite: true).
/// If no properties are favorited, it displays a premium empty state.
class SavedPropertiesGrid extends ConsumerWidget {
  const SavedPropertiesGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allProperties = ref.watch(propertiesProvider);
    final savedProperties = allProperties.where((prop) => prop.isFavorite).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header Row
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Saved',
            style: GoogleFonts.poppins(
              color: const Color(0xFF042F2C),
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(height: 12),
        // Grid Content / Empty State
        if (savedProperties.isEmpty)
          const _EmptySavedState()
        else
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.64, // Exact same aspect ratio as PropertyGrid in Home
              ),
              itemCount: savedProperties.length,
              itemBuilder: (context, index) {
                final prop = savedProperties[index];
                return PropertyCard(
                  id: prop.id,
                  imageUrl: prop.imageUrl,
                  price: prop.price,
                  title: prop.title,
                  location: prop.location,
                  agentAvatarUrl: prop.agentAvatarUrl,
                  isAgentVerified: prop.isAgentVerified,
                  isFavorite: prop.isFavorite,
                );
              },
            ),
          ),
      ],
    );
  }
}

/// Premium Empty State when there are no saved properties
class _EmptySavedState extends StatelessWidget {
  const _EmptySavedState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: const Color(0xFF042F2C).withOpacity(0.05),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.favorite_border,
                color: Color(0xFF042F2C),
                size: 32,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'No saved properties',
              style: GoogleFonts.poppins(
                color: const Color(0xFF042F2C),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Explore real estate listings and tap the heart icon to save your favorites here.',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                color: const Color(0xFF6B7280),
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

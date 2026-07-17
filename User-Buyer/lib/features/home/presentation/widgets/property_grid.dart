import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../shared/providers/filtered_properties_provider.dart';
import '../providers/location_provider.dart';
import 'property_card.dart';

/// Property Grid Widget - ZRent Buyer App
///
/// Displays a 2-column grid filtered by the globally selected location.
/// Uses [filteredPropertiesProvider] so the location picker applies app-wide.
class PropertyGrid extends ConsumerWidget {
  const PropertyGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationState = ref.watch(locationProvider);
    final filteredProperties = ref.watch(filteredPropertiesProvider);

    if (filteredProperties.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
        child: Center(
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
                  Icons.location_off_outlined,
                  color: Color(0xFF042F2C),
                  size: 28,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'No properties in this location',
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF042F2C),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'No listings in ${locationState.selectedLocation} yet.\nTry enabling "All locations within ${locationState.selectedCountry}" or pick a different region.',
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
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.64,
        ),
        itemCount: filteredProperties.length,
        itemBuilder: (context, index) {
          final prop = filteredProperties[index];
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
    );
  }
}

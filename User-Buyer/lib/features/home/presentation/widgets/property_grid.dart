import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/properties_provider.dart';
import 'property_card.dart';

/// Property Grid Widget - ZRent Buyer App
///
/// Implements the two-column property feed below the promotional banner.
/// It renders the specific properties shown in the Figma mockup:
/// 1. Sky Residence - ₦350/month (Agent Verified)
/// 2. Urban Loft - ₦280/month (Not Verified)
class PropertyGrid extends ConsumerWidget {
  const PropertyGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final properties = ref.watch(propertiesProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.64, // Adjusted ratio to perfectly fit all card content without layout overflows
        ),
        itemCount: properties.length,
        itemBuilder: (context, index) {
          final prop = properties[index];
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

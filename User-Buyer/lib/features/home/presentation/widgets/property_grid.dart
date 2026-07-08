import 'package:flutter/material.dart';
import 'property_card.dart';

/// Property Grid Widget - ZRent Buyer App
///
/// Implements the two-column property feed below the promotional banner.
/// It renders the specific properties shown in the Figma mockup:
/// 1. Sky Residence - ₦350/month (Agent Verified)
/// 2. Urban Loft - ₦280/month (Not Verified)
class PropertyGrid extends StatelessWidget {
  const PropertyGrid({super.key});

  @override
  Widget build(BuildContext context) {
    // List of properties matching the Figma design screenshot
    final List<Map<String, dynamic>> properties = [
      {
        'imageUrl': 'https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?w=500&auto=format&fit=crop&q=80',
        'price': '₦350/month',
        'title': 'Sky Residence',
        'location': 'Jakarta, Indonesia',
        'agentAvatarUrl': 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=150&auto=format&fit=crop&q=80',
        'isAgentVerified': true,
        'isFavorite': false,
      },
      {
        'imageUrl': 'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=500&auto=format&fit=crop&q=80',
        'price': '₦280/month',
        'title': 'Urban Loft',
        'location': 'Jakarta, Indonesia',
        'agentAvatarUrl': 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=150&auto=format&fit=crop&q=80',
        'isAgentVerified': false,
        'isFavorite': false,
      },
      {
        'imageUrl': 'https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?w=500&auto=format&fit=crop&q=80',
        'price': '₦350/month',
        'title': 'Sky Residence',
        'location': 'Jakarta, Indonesia',
        'agentAvatarUrl': 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=150&auto=format&fit=crop&q=80',
        'isAgentVerified': true,
        'isFavorite': false,
      },
      {
        'imageUrl': 'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=500&auto=format&fit=crop&q=80',
        'price': '₦280/month',
        'title': 'Urban Loft',
        'location': 'Jakarta, Indonesia',
        'agentAvatarUrl': 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=150&auto=format&fit=crop&q=80',
        'isAgentVerified': false,
        'isFavorite': false,
      },
    ];

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
            imageUrl: prop['imageUrl'],
            price: prop['price'],
            title: prop['title'],
            location: prop['location'],
            agentAvatarUrl: prop['agentAvatarUrl'],
            isAgentVerified: prop['isAgentVerified'],
            isFavorite: prop['isFavorite'],
          );
        },
      ),
    );
  }
}

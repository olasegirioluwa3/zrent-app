import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Property model representing a listing in the ZRent application.
class Property {
  final String id;
  final String imageUrl;
  final String price;
  final String title;
  final String location;
  final String agentAvatarUrl;
  final bool isAgentVerified;
  final bool isFavorite;

  Property({
    required this.id,
    required this.imageUrl,
    required this.price,
    required this.title,
    required this.location,
    required this.agentAvatarUrl,
    required this.isAgentVerified,
    required this.isFavorite,
  });

  Property copyWith({
    String? id,
    String? imageUrl,
    String? price,
    String? title,
    String? location,
    String? agentAvatarUrl,
    bool? isAgentVerified,
    bool? isFavorite,
  }) {
    return Property(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      title: title ?? this.title,
      location: location ?? this.location,
      agentAvatarUrl: agentAvatarUrl ?? this.agentAvatarUrl,
      isAgentVerified: isAgentVerified ?? this.isAgentVerified,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

/// State notifier to manage the list of properties and their favorite state.
class PropertiesNotifier extends StateNotifier<List<Property>> {
  PropertiesNotifier() : super(_initialProperties);

  static final List<Property> _initialProperties = [
    Property(
      id: '1',
      imageUrl: 'https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?w=500&auto=format&fit=crop&q=80',
      price: '₦350/month',
      title: 'Sky Residence',
      location: 'Jakarta, Indonesia',
      agentAvatarUrl: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=150&auto=format&fit=crop&q=80',
      isAgentVerified: true,
      isFavorite: true, // Default to true as shown in the Figma Favorites page screenshot
    ),
    Property(
      id: '2',
      imageUrl: 'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=500&auto=format&fit=crop&q=80',
      price: '₦280/month',
      title: 'Urban Loft',
      location: 'Jakarta, Indonesia',
      agentAvatarUrl: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=150&auto=format&fit=crop&q=80',
      isAgentVerified: false,
      isFavorite: true, // Default to true as shown in the Figma Favorites page screenshot
    ),
    Property(
      id: '3',
      imageUrl: 'https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?w=500&auto=format&fit=crop&q=80',
      price: '\$350/month', // Dollar price for the third card in Figma
      title: 'Sky Residence',
      location: 'Jakarta, Indonesia',
      agentAvatarUrl: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=150&auto=format&fit=crop&q=80',
      isAgentVerified: true,
      isFavorite: true, // Default to true as shown in the Figma Favorites page screenshot
    ),
    Property(
      id: '4',
      imageUrl: 'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=500&auto=format&fit=crop&q=80',
      price: '₦280/month',
      title: 'Urban Loft',
      location: 'Jakarta, Indonesia',
      agentAvatarUrl: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=150&auto=format&fit=crop&q=80',
      isAgentVerified: false,
      isFavorite: true, // Default to true as shown in the Figma Favorites page screenshot
    ),
  ];

  void toggleFavorite(String id) {
    state = [
      for (final prop in state)
        if (prop.id == id)
          prop.copyWith(isFavorite: !prop.isFavorite)
        else
          prop,
    ];
  }
}

/// Global provider for properties state.
final propertiesProvider = StateNotifierProvider<PropertiesNotifier, List<Property>>((ref) {
  return PropertiesNotifier();
});

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

  static const _agentAvatar =
      'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=150&auto=format&fit=crop&q=80';
  static const _agentAvatar2 =
      'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=150&auto=format&fit=crop&q=80';

  static final List<Property> _initialProperties = [
    // ── Nigeria ───────────────────────────────────────────────────────────────
    Property(
      id: '1',
      imageUrl: 'https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?w=500&auto=format&fit=crop&q=80',
      price: '₦350,000/month',
      title: 'Sky Residence',
      location: 'Lagos, Nigeria',
      agentAvatarUrl: _agentAvatar,
      isAgentVerified: true,
      isFavorite: true,
    ),
    Property(
      id: '2',
      imageUrl: 'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=500&auto=format&fit=crop&q=80',
      price: '₦280,000/month',
      title: 'Urban Loft',
      location: 'Lekki, Lagos, Nigeria',
      agentAvatarUrl: _agentAvatar,
      isAgentVerified: false,
      isFavorite: true,
    ),
    Property(
      id: '3',
      imageUrl: 'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?w=500&auto=format&fit=crop&q=80',
      price: '₦420,000/month',
      title: 'Victoria Heights',
      location: 'Victoria Island, Lagos, Nigeria',
      agentAvatarUrl: _agentAvatar2,
      isAgentVerified: true,
      isFavorite: false,
    ),
    Property(
      id: '4',
      imageUrl: 'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?w=500&auto=format&fit=crop&q=80',
      price: '₦180,000/month',
      title: 'Ikeja Garden Suite',
      location: 'Ikeja, Lagos, Nigeria',
      agentAvatarUrl: _agentAvatar,
      isAgentVerified: true,
      isFavorite: false,
    ),
    Property(
      id: '5',
      imageUrl: 'https://images.unsplash.com/photo-1613490493576-7fde63acd811?w=500&auto=format&fit=crop&q=80',
      price: '₦250,000/month',
      title: 'Abuja Central Tower',
      location: 'Maitama, Abuja, Nigeria',
      agentAvatarUrl: _agentAvatar2,
      isAgentVerified: true,
      isFavorite: false,
    ),
    Property(
      id: '6',
      imageUrl: 'https://images.unsplash.com/photo-1600210492486-724fe5c67fb0?w=500&auto=format&fit=crop&q=80',
      price: '₦150,000/month',
      title: 'Port View Apartment',
      location: 'Port Harcourt, Nigeria',
      agentAvatarUrl: _agentAvatar,
      isAgentVerified: false,
      isFavorite: false,
    ),

    // ── Indonesia ─────────────────────────────────────────────────────────────
    Property(
      id: '7',
      imageUrl: 'https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?w=500&auto=format&fit=crop&q=80',
      price: '\$280/month',
      title: 'Jakarta Urban Flat',
      location: 'Jakarta, Indonesia',
      agentAvatarUrl: _agentAvatar2,
      isAgentVerified: true,
      isFavorite: false,
    ),
    Property(
      id: '8',
      imageUrl: 'https://images.unsplash.com/photo-1505691938895-1758d7feb511?w=500&auto=format&fit=crop&q=80',
      price: '\$350/month',
      title: 'Bali Villa Retreat',
      location: 'Bali, Indonesia',
      agentAvatarUrl: _agentAvatar,
      isAgentVerified: true,
      isFavorite: false,
    ),
    Property(
      id: '9',
      imageUrl: 'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?w=500&auto=format&fit=crop&q=80',
      price: '\$220/month',
      title: 'Bandung Hills Home',
      location: 'Bandung, Indonesia',
      agentAvatarUrl: _agentAvatar2,
      isAgentVerified: false,
      isFavorite: false,
    ),

    // ── United States ─────────────────────────────────────────────────────────
    Property(
      id: '10',
      imageUrl: 'https://images.unsplash.com/photo-1613490493576-7fde63acd811?w=500&auto=format&fit=crop&q=80',
      price: '\$3,200/month',
      title: 'Manhattan Penthouse',
      location: 'New York, United States',
      agentAvatarUrl: _agentAvatar,
      isAgentVerified: true,
      isFavorite: false,
    ),
    Property(
      id: '11',
      imageUrl: 'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?w=500&auto=format&fit=crop&q=80',
      price: '\$2,800/month',
      title: 'LA Luxury Condo',
      location: 'Los Angeles, United States',
      agentAvatarUrl: _agentAvatar2,
      isAgentVerified: true,
      isFavorite: false,
    ),
    Property(
      id: '12',
      imageUrl: 'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=500&auto=format&fit=crop&q=80',
      price: '\$2,100/month',
      title: 'Bay Area Studio',
      location: 'San Francisco, United States',
      agentAvatarUrl: _agentAvatar,
      isAgentVerified: false,
      isFavorite: false,
    ),

    // ── United Kingdom ────────────────────────────────────────────────────────
    Property(
      id: '13',
      imageUrl: 'https://images.unsplash.com/photo-1600210492486-724fe5c67fb0?w=500&auto=format&fit=crop&q=80',
      price: '£2,500/month',
      title: 'Chelsea Townhouse',
      location: 'Chelsea, London, United Kingdom',
      agentAvatarUrl: _agentAvatar2,
      isAgentVerified: true,
      isFavorite: false,
    ),
    Property(
      id: '14',
      imageUrl: 'https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?w=500&auto=format&fit=crop&q=80',
      price: '£1,800/month',
      title: 'Manchester Modern Flat',
      location: 'Manchester, United Kingdom',
      agentAvatarUrl: _agentAvatar,
      isAgentVerified: false,
      isFavorite: false,
    ),

    // ── United Arab Emirates ──────────────────────────────────────────────────
    Property(
      id: '15',
      imageUrl: 'https://images.unsplash.com/photo-1613490493576-7fde63acd811?w=500&auto=format&fit=crop&q=80',
      price: 'AED 12,000/month',
      title: 'Dubai Marina Tower',
      location: 'Dubai, United Arab Emirates',
      agentAvatarUrl: _agentAvatar2,
      isAgentVerified: true,
      isFavorite: false,
    ),
    Property(
      id: '16',
      imageUrl: 'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?w=500&auto=format&fit=crop&q=80',
      price: 'AED 8,500/month',
      title: 'Abu Dhabi Skyline',
      location: 'Abu Dhabi, United Arab Emirates',
      agentAvatarUrl: _agentAvatar,
      isAgentVerified: true,
      isFavorite: false,
    ),

    // ── South Africa ──────────────────────────────────────────────────────────
    Property(
      id: '17',
      imageUrl: 'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?w=500&auto=format&fit=crop&q=80',
      price: 'ZAR 18,000/month',
      title: 'Cape Town Sea View',
      location: 'Cape Town, South Africa',
      agentAvatarUrl: _agentAvatar2,
      isAgentVerified: true,
      isFavorite: false,
    ),
    Property(
      id: '18',
      imageUrl: 'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=500&auto=format&fit=crop&q=80',
      price: 'ZAR 14,500/month',
      title: 'Johannesburg Executive',
      location: 'Johannesburg, South Africa',
      agentAvatarUrl: _agentAvatar,
      isAgentVerified: false,
      isFavorite: false,
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

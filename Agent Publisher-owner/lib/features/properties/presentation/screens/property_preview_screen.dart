import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_theme.dart';

/// Property Preview
/// 
/// Figma: https://www.figma.com/design/MwxOsKuN9q6b815CH3IcLJ/Untitled?node-id=304-2317
/// Screen ID: 203:1803
class PropertyPreviewScreen extends StatelessWidget {
  const PropertyPreviewScreen({super.key});

  void _continueToPricing(BuildContext context) {
    context.push(RouteNames.propertyPricing);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.secondary),
          onPressed: () => context.pop(),
        ),
        title: const Text('Property Preview'),
        actions: [
          TextButton(
            onPressed: () {
              // TODO: Edit property
            },
            child: const Text('Edit'),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                // Property Images
                Container(
                  height: 250,
                  color: AppTheme.surface,
                  child: PageView.builder(
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Container(
                        color: AppTheme.borderLight,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.image, size: 64, color: AppTheme.textTertiary),
                              const SizedBox(height: 8),
                              Text('Image ${index + 1}', style: const TextStyle(color: AppTheme.textTertiary)),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Modern Apartment in Downtown',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.secondary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.location_on, size: 16, color: AppTheme.textSecondary),
                          const SizedBox(width: 4),
                          Text(
                            'Downtown, City Center',
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppTheme.textSecondary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          _buildFeatureChip(Icons.bed, '3 Bedrooms'),
                          const SizedBox(width: 12),
                          _buildFeatureChip(Icons.bathtub, '2 Bathrooms'),
                          const SizedBox(width: 12),
                          _buildFeatureChip(Icons.square_foot, '1,200 sq ft'),
                        ],
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.secondary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Beautiful modern apartment located in the heart of downtown. Features spacious rooms, natural lighting, and stunning city views. Perfect for professionals and small families.',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppTheme.textSecondary,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Amenities',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.secondary,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          _buildAmenityBadge('Parking'),
                          _buildAmenityBadge('Pool'),
                          _buildAmenityBadge('Gym'),
                          _buildAmenityBadge('Security'),
                          _buildAmenityBadge('Garden'),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              color: AppTheme.background,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: () => _continueToPricing(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primary,
                foregroundColor: AppTheme.secondary,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Continue to Pricing'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureChip(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppTheme.primary),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: AppTheme.secondary,
          ),
        ),
      ],
    );
  }

  Widget _buildAmenityBadge(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppTheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          color: AppTheme.secondary,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

/// Property Info Header Widget
/// 
/// Shows property title, price, location, and rating
class PropertyInfoHeader extends StatelessWidget {
  const PropertyInfoHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Price and Favorite
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '₦850,000',
                style: AppTypography.h2.copyWith(
                  color: AppColors.primary,
                  fontWeight: AppTypography.bold,
                ),
              ),
              Text(
                '/month',
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Title
          Text(
            'Luxury 3-Bedroom Apartment with Modern Amenities',
            style: AppTypography.h4.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          // Location
          Row(
            children: [
              const Icon(
                Icons.location_on_outlined,
                color: AppColors.primary,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Victoria Island, Lagos',
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Rating and Reviews
          Row(
            children: [
              const Icon(
                Icons.star,
                color: Color(0xFFFFB800),
                size: 20,
              ),
              const SizedBox(width: 4),
              Text(
                '4.8',
                style: AppTypography.labelLarge.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: AppTypography.semiBold,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                '(128 reviews)',
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

/// Property Summary Widget
/// 
/// Shows property being offered on
class PropertySummary extends StatelessWidget {
  const PropertySummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Property Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?w=200',
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 80,
                  height: 80,
                  color: AppColors.surfaceVariant,
                  child: const Icon(
                    Icons.home_outlined,
                    color: AppColors.textTertiary,
                    size: 32,
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 16),
          // Property Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Luxury 3-Bedroom Apartment',
                  style: AppTypography.labelLarge.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: AppTypography.semiBold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Victoria Island, Lagos',
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '₦850,000/month',
                  style: AppTypography.labelLarge.copyWith(
                    color: AppColors.primary,
                    fontWeight: AppTypography.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

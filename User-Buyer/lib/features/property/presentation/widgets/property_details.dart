import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

/// Property Details Widget
/// 
/// Shows property specifications (beds, baths, area, etc.)
class PropertyDetails extends StatelessWidget {
  const PropertyDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Property Details',
            style: AppTypography.h4.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          // Detail Items
          Row(
            children: [
              Expanded(
                child: _DetailItem(
                  icon: Icons.bed_outlined,
                  label: 'Bedrooms',
                  value: '3',
                ),
              ),
              Expanded(
                child: _DetailItem(
                  icon: Icons.bathtub_outlined,
                  label: 'Bathrooms',
                  value: '2',
                ),
              ),
              Expanded(
                child: _DetailItem(
                  icon: Icons.square_foot,
                  label: 'Area',
                  value: '150m²',
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _DetailItem(
                  icon: Icons.local_parking,
                  label: 'Parking',
                  value: '2',
                ),
              ),
              Expanded(
                child: _DetailItem(
                  icon: Icons.layers,
                  label: 'Floor',
                  value: '5th',
                ),
              ),
              Expanded(
                child: _DetailItem(
                  icon: Icons.calendar_today_outlined,
                  label: 'Built',
                  value: '2022',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DetailItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _DetailItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.border,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: AppColors.primary,
            size: 24,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: AppTypography.labelLarge.copyWith(
              color: AppColors.textPrimary,
              fontWeight: AppTypography.semiBold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: AppTypography.labelSmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

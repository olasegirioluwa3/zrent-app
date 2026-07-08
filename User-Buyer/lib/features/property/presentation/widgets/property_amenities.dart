import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

/// Property Amenities Widget
/// 
/// Lists property amenities with icons
class PropertyAmenities extends StatelessWidget {
  const PropertyAmenities({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Amenities',
            style: AppTypography.h4.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          // Amenities Grid
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 2.5,
            children: const [
              _AmenityItem(
                icon: Icons.wifi_outlined,
                label: 'Free WiFi',
              ),
              _AmenityItem(
                icon: Icons.pool_outlined,
                label: 'Swimming Pool',
              ),
              _AmenityItem(
                icon: Icons.fitness_center_outlined,
                label: 'Gym',
              ),
              _AmenityItem(
                icon: Icons.security_outlined,
                label: '24/7 Security',
              ),
              _AmenityItem(
                icon: Icons.ac_unit,
                label: 'Air Conditioning',
              ),
              _AmenityItem(
                icon: Icons.local_parking_outlined,
                label: 'Parking',
              ),
              _AmenityItem(
                icon: Icons.elevator_outlined,
                label: 'Elevator',
              ),
              _AmenityItem(
                icon: Icons.water_drop_outlined,
                label: 'Water Supply',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AmenityItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const _AmenityItem({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.border,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: AppColors.primary,
            size: 20,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              style: AppTypography.labelMedium.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

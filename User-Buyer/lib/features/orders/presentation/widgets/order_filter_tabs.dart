import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

/// Order Filter Tabs Widget
/// 
/// Horizontal scrollable filter tabs for orders
class OrderFilterTabs extends StatelessWidget {
  const OrderFilterTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: const [
          _FilterTab(
            label: 'All',
            isSelected: true,
          ),
          SizedBox(width: 12),
          _FilterTab(
            label: 'Pending',
            isSelected: false,
          ),
          SizedBox(width: 12),
          _FilterTab(
            label: 'Confirmed',
            isSelected: false,
          ),
          SizedBox(width: 12),
          _FilterTab(
            label: 'Completed',
            isSelected: false,
          ),
        ],
      ),
    );
  }
}

class _FilterTab extends StatelessWidget {
  final String label;
  final bool isSelected;

  const _FilterTab({
    required this.label,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary : AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? AppColors.primary : AppColors.border,
          width: 1,
        ),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ]
            : [
                BoxShadow(
                  color: AppColors.shadowLight,
                  blurRadius: 4,
                  offset: const Offset(0, 1),
                ),
              ],
      ),
      child: Text(
        label,
        style: AppTypography.labelLarge.copyWith(
          color: isSelected ? AppColors.textWhite : AppColors.textPrimary,
          fontWeight: isSelected ? AppTypography.semiBold : AppTypography.medium,
        ),
      ),
    );
  }
}

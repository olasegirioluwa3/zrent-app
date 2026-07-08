import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

/// Agent Stats Widget
/// 
/// Shows agent statistics (listings, rating, response time)
class AgentStats extends StatelessWidget {
  const AgentStats({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: _StatItem(
              icon: Icons.home_work_outlined,
              label: 'Listings',
              value: '45',
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _StatItem(
              icon: Icons.star_outlined,
              label: 'Rating',
              value: '4.9',
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _StatItem(
              icon: Icons.access_time,
              label: 'Response',
              value: '1h',
            ),
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _StatItem({
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
            style: AppTypography.h5.copyWith(
              color: AppColors.textPrimary,
              fontWeight: AppTypography.bold,
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

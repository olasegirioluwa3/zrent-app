import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../providers/agent_reviews_provider.dart';

/// Agent Stats Widget
/// 
/// Shows agent statistics (listings, rating, response time, earnings)
/// Dynamically updates rating & review count from [agentReviewsProvider]
class AgentStats extends ConsumerWidget {
  const AgentStats({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reviewsState = ref.watch(agentReviewsProvider);
    final ratingText = '${reviewsState.averageRating} (${reviewsState.totalReviews})';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          const Expanded(
            child: _StatItem(
              icon: Icons.home_work_outlined,
              label: 'Listings',
              value: '45',
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _StatItem(
              icon: Icons.star_outlined,
              label: 'Rating',
              value: ratingText,
            ),
          ),
          const SizedBox(width: 8),
          const Expanded(
            child: _StatItem(
              icon: Icons.access_time,
              label: 'Response',
              value: '1h',
            ),
          ),
          const SizedBox(width: 8),
          const Expanded(
            child: _StatItem(
              icon: Icons.monetization_on_outlined,
              label: 'Earned',
              value: '₦12.5M',
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
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
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
            size: 22,
          ),
          const SizedBox(height: 8),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              value,
              style: AppTypography.labelLarge.copyWith(
                color: AppColors.textPrimary,
                fontWeight: AppTypography.bold,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: AppTypography.labelSmall.copyWith(
              color: AppColors.textSecondary,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

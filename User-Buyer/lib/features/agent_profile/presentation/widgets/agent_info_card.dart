import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

/// Agent Info Card Widget
///
/// Shows agent avatar, name, title, and bio
class AgentInfoCard extends StatelessWidget {
  final String agentName;
  final String avatarUrl;

  const AgentInfoCard({
    super.key,
    required this.agentName,
    required this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
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
      child: Column(
        children: [
          // Avatar
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              avatarUrl,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 100,
                  height: 100,
                  color: AppColors.surfaceVariant,
                  child: const Icon(
                    Icons.person,
                    color: AppColors.textTertiary,
                    size: 50,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          // Name
          Text(
            agentName,
            style: AppTypography.h3.copyWith(
              color: AppColors.textPrimary,
              fontWeight: AppTypography.bold,
            ),
          ),
          const SizedBox(height: 4),
          // Title
          Text(
            'Senior Property Agent',
            style: AppTypography.labelLarge.copyWith(
              color: AppColors.primary,
              fontWeight: AppTypography.semiBold,
            ),
          ),
          const SizedBox(height: 12),
          // Bio
          Text(
            'Experienced real estate agent specializing in luxury properties in Victoria Island and Lekki. With over 10 years of experience, I help clients find their dream homes.',
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          // Verified Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFBEF264), // Figma Lime Green
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.verified,
                  color: Color(0xFF042F2C), // Dark Teal
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  'Verified Agent',
                  style: AppTypography.labelMedium.copyWith(
                    color: const Color(0xFF042F2C), // Dark Teal
                    fontWeight: AppTypography.semiBold,
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

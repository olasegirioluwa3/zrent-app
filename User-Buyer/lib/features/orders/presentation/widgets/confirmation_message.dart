import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

/// Confirmation Message Widget
/// 
/// Shows confirmation text and agent info
class ConfirmationMessage extends StatelessWidget {
  const ConfirmationMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Order Confirmed!',
          style: AppTypography.h2.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Your order has been confirmed by the agent',
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        // Agent Info
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                'https://i.pravatar.cc/150?img=1',
                width: 40,
                height: 40,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 40,
                    height: 40,
                    color: AppColors.surfaceVariant,
                    child: const Icon(
                      Icons.person,
                      color: AppColors.textTertiary,
                      size: 20,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'John Doe has confirmed your order',
              style: AppTypography.labelMedium.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

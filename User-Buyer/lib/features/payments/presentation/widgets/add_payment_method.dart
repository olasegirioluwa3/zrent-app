import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

/// Add Payment Method Widget
/// 
/// Button to add new payment method
class AddPaymentMethod extends StatelessWidget {
  const AddPaymentMethod({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.border,
          width: 2,
          style: BorderStyle.solid,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.add_circle_outline,
            color: AppColors.primary,
            size: 24,
          ),
          const SizedBox(width: 8),
          Text(
            'Add Payment Method',
            style: AppTypography.labelLarge.copyWith(
              color: AppColors.primary,
              fontWeight: AppTypography.semiBold,
            ),
          ),
        ],
      ),
    );
  }
}

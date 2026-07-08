import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

/// Payment Method Card Widget
/// 
/// Shows payment method details (card/bank)
class PaymentMethodCard extends StatelessWidget {
  final String type;
  final String lastFour;
  final String expiry;
  final bool isDefault;

  const PaymentMethodCard({
    super.key,
    required this.type,
    required this.lastFour,
    required this.expiry,
    required this.isDefault,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDefault ? AppColors.primary : AppColors.border,
          width: isDefault ? 2 : 1,
        ),
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
          // Icon
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: type == 'Card' 
                  ? AppColors.primary.withOpacity(0.1)
                  : AppColors.secondary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              type == 'Card' ? Icons.credit_card : Icons.account_balance,
              color: type == 'Card' ? AppColors.primary : AppColors.secondary,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      type == 'Card' ? 'Credit Card' : 'Bank Account',
                      style: AppTypography.labelLarge.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: AppTypography.semiBold,
                      ),
                    ),
                    if (isDefault) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'Default',
                          style: AppTypography.labelSmall.copyWith(
                            color: AppColors.primary,
                            fontWeight: AppTypography.semiBold,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  '**** **** **** $lastFour',
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                if (expiry.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    'Expires $expiry',
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.textTertiary,
                    ),
                  ),
                ],
              ],
            ),
          ),
          // Radio
          Icon(
            isDefault ? Icons.radio_button_checked : Icons.radio_button_unchecked,
            color: isDefault ? AppColors.primary : AppColors.textTertiary,
            size: 24,
          ),
        ],
      ),
    );
  }
}

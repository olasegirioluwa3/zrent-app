import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

/// Order Payment Info Widget
/// 
/// Shows payment details for the order
class OrderPaymentInfo extends StatelessWidget {
  const OrderPaymentInfo({super.key});

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Payment Information',
            style: AppTypography.h4.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          _PaymentRow(
            label: 'Transaction ID',
            value: '#TXN-2024-12345',
          ),
          const SizedBox(height: 12),
          _PaymentRow(
            label: 'Payment Method',
            value: 'Credit Card **** 4242',
          ),
          const SizedBox(height: 12),
          _PaymentRow(
            label: 'Amount',
            value: '₦850,000',
            isAmount: true,
          ),
          const SizedBox(height: 12),
          _PaymentRow(
            label: 'Payment Date',
            value: 'June 30, 2024',
          ),
          const SizedBox(height: 12),
          _PaymentRow(
            label: 'Payment Status',
            value: 'Paid',
            status: 'success',
          ),
        ],
      ),
    );
  }
}

class _PaymentRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isAmount;
  final String? status;

  const _PaymentRow({
    required this.label,
    required this.value,
    this.isAmount = false,
    this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        Row(
          children: [
            if (status == 'success') ...[
              const Icon(
                Icons.check_circle,
                color: AppColors.success,
                size: 16,
              ),
              const SizedBox(width: 4),
            ],
            Text(
              value,
              style: AppTypography.bodyMedium.copyWith(
                color: isAmount ? AppColors.primary : AppColors.textPrimary,
                fontWeight: isAmount ? AppTypography.bold : AppTypography.medium,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

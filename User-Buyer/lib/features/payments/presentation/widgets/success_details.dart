import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

/// Success Details Widget
/// 
/// Shows payment transaction details
class SuccessDetails extends StatelessWidget {
  const SuccessDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
          _DetailRow(
            label: 'Transaction ID',
            value: '#TXN-2024-12345',
          ),
          const SizedBox(height: 16),
          _DetailRow(
            label: 'Amount',
            value: '₦850,000',
          ),
          const SizedBox(height: 16),
          _DetailRow(
            label: 'Payment Method',
            value: 'Credit Card **** 4242',
          ),
          const SizedBox(height: 16),
          _DetailRow(
            label: 'Date',
            value: 'June 30, 2024',
          ),
          const SizedBox(height: 16),
          _DetailRow(
            label: 'Time',
            value: '11:45 AM',
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({
    required this.label,
    required this.value,
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
        Text(
          value,
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.textPrimary,
            fontWeight: AppTypography.semiBold,
          ),
        ),
      ],
    );
  }
}

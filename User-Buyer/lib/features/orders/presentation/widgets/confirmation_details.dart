import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

/// Confirmation Details Widget
/// 
/// Shows order confirmation details
class ConfirmationDetails extends StatelessWidget {
  const ConfirmationDetails({super.key});

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
            label: 'Order ID',
            value: '#ORD-2024-001',
          ),
          const SizedBox(height: 16),
          _DetailRow(
            label: 'Property',
            value: 'Luxury 3-Bedroom Apartment',
          ),
          const SizedBox(height: 16),
          _DetailRow(
            label: 'Location',
            value: 'Victoria Island, Lagos',
          ),
          const SizedBox(height: 16),
          _DetailRow(
            label: 'Amount',
            value: '₦850,000',
            isAmount: true,
          ),
          const SizedBox(height: 16),
          _DetailRow(
            label: 'Confirmation Date',
            value: 'June 30, 2024',
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isAmount;

  const _DetailRow({
    required this.label,
    required this.value,
    this.isAmount = false,
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
            color: isAmount ? AppColors.primary : AppColors.textPrimary,
            fontWeight: isAmount ? AppTypography.bold : AppTypography.medium,
          ),
        ),
      ],
    );
  }
}

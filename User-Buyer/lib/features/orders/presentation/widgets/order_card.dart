import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

/// Order Card Widget
/// 
/// Shows order details with status indicator
class OrderCard extends StatelessWidget {
  final String orderId;
  final String propertyName;
  final String propertyImage;
  final String location;
  final String amount;
  final String status;
  final String date;

  const OrderCard({
    super.key,
    required this.orderId,
    required this.propertyName,
    required this.propertyImage,
    required this.location,
    required this.amount,
    required this.status,
    required this.date,
  });

  Color _getStatusColor() {
    switch (status) {
      case 'Pending':
        return const Color(0xFFFFA500);
      case 'Confirmed':
        return const Color(0xFF4CAF50);
      case 'Completed':
        return AppColors.primary;
      default:
        return AppColors.textTertiary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
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
      child: Row(
        children: [
          // Property Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              propertyImage,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 80,
                  height: 80,
                  color: AppColors.surfaceVariant,
                  child: const Icon(
                    Icons.home_outlined,
                    color: AppColors.textTertiary,
                    size: 32,
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 16),
          // Order Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      orderId,
                      style: AppTypography.labelSmall.copyWith(
                        color: AppColors.textTertiary,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _getStatusColor().withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        status,
                        style: AppTypography.labelSmall.copyWith(
                          color: _getStatusColor(),
                          fontWeight: AppTypography.semiBold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  propertyName,
                  style: AppTypography.labelLarge.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: AppTypography.semiBold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      color: AppColors.textTertiary,
                      size: 14,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        location,
                        style: AppTypography.labelSmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      amount,
                      style: AppTypography.labelLarge.copyWith(
                        color: AppColors.primary,
                        fontWeight: AppTypography.bold,
                      ),
                    ),
                    Text(
                      date,
                      style: AppTypography.labelSmall.copyWith(
                        color: AppColors.textTertiary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

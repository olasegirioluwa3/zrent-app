import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

/// Order Timeline Widget
/// 
/// Shows order progress timeline
class OrderTimeline extends StatelessWidget {
  const OrderTimeline({super.key});

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
            'Order Timeline',
            style: AppTypography.h4.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 20),
          _TimelineItem(
            title: 'Order Placed',
            description: 'Your offer has been submitted',
            time: 'June 30, 2024 - 10:30 AM',
            isCompleted: true,
            isLast: false,
          ),
          const SizedBox(height: 16),
          _TimelineItem(
            title: 'Payment Pending',
            description: 'Waiting for payment confirmation',
            time: 'June 30, 2024 - 10:35 AM',
            isCompleted: true,
            isLast: false,
          ),
          const SizedBox(height: 16),
          _TimelineItem(
            title: 'Payment Confirmed',
            description: 'Payment received successfully',
            time: 'June 30, 2024 - 11:45 AM',
            isCompleted: true,
            isLast: false,
          ),
          const SizedBox(height: 16),
          _TimelineItem(
            title: 'Order Confirmed',
            description: 'Agent has confirmed your order',
            time: 'Pending',
            isCompleted: false,
            isLast: true,
          ),
        ],
      ),
    );
  }
}

class _TimelineItem extends StatelessWidget {
  final String title;
  final String description;
  final String time;
  final bool isCompleted;
  final bool isLast;

  const _TimelineItem({
    required this.title,
    required this.description,
    required this.time,
    required this.isCompleted,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Timeline Line
        Column(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: isCompleted ? AppColors.success : AppColors.border,
                shape: BoxShape.circle,
                border: Border.all(
                  color: isCompleted ? AppColors.success : AppColors.border,
                  width: 2,
                ),
              ),
              child: isCompleted
                  ? const Icon(
                      Icons.check,
                      color: AppColors.textWhite,
                      size: 8,
                    )
                  : null,
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 40,
                color: isCompleted ? AppColors.success : AppColors.border,
              ),
          ],
        ),
        const SizedBox(width: 16),
        // Content
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTypography.labelLarge.copyWith(
                  color: isCompleted ? AppColors.textPrimary : AppColors.textSecondary,
                  fontWeight: AppTypography.semiBold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                time,
                style: AppTypography.labelSmall.copyWith(
                  color: AppColors.textTertiary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

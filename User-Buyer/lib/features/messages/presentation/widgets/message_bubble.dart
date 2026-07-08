import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

/// Message Bubble Widget
/// 
/// Chat message bubble with sent/received styling
class MessageBubble extends StatelessWidget {
  final String message;
  final bool isSent;
  final String time;

  const MessageBubble({
    super.key,
    required this.message,
    required this.isSent,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSent ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: isSent ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.75,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isSent ? AppColors.primary : AppColors.surface,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadowLight,
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              message,
              style: AppTypography.bodyMedium.copyWith(
                color: isSent ? AppColors.textWhite : AppColors.textPrimary,
              ),
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
    );
  }
}

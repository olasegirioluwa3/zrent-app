import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

/// Confirmation Animation Widget
/// 
/// Shows checkmark animation for order confirmation
class ConfirmationAnimation extends StatelessWidget {
  const ConfirmationAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: AppColors.success.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.check_circle,
        color: AppColors.success,
        size: 80,
      ),
    );
  }
}

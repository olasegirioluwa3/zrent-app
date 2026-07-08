import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

/// Orders Header Widget
/// 
/// Shows screen title
class OrdersHeader extends StatelessWidget {
  const OrdersHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        'My Orders',
        style: AppTypography.h2.copyWith(
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../widgets/success_animation.dart';
import '../widgets/success_details.dart';
import '../widgets/back_to_home_button.dart';

/// Payment Success Screen - ZRent Buyer App
/// 
/// Shows successful payment confirmation with:
/// - Success animation
/// - Payment details
/// - Back to home button
class PaymentSuccessScreen extends StatelessWidget {
  const PaymentSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                SuccessAnimation(),
                SizedBox(height: 32),
                Text(
                  'Payment Successful!',
                  style: AppTypography.h2.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'Your payment has been processed successfully',
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 32),
                SuccessDetails(),
                SizedBox(height: 32),
                BackToHomeButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../widgets/confirmation_animation.dart';
import '../widgets/confirmation_message.dart';
import '../widgets/confirmation_details.dart';
import '../widgets/confirm_button.dart';

/// Order Confirmation Screen - ZRent Buyer App
/// 
/// Shows order confirmation with:
/// - Success animation
/// - Confirmation message
/// - Order details
/// - Confirm button
class OrderConfirmationScreen extends StatelessWidget {
  const OrderConfirmationScreen({super.key});

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
                ConfirmationAnimation(),
                SizedBox(height: 32),
                ConfirmationMessage(),
                SizedBox(height: 32),
                ConfirmationDetails(),
                SizedBox(height: 32),
                ConfirmButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

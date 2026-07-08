import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../widgets/checkout_header.dart';
import '../widgets/property_summary.dart';
import '../widgets/offer_form.dart';
import '../widgets/escrow_info.dart';
import '../widgets/checkout_button.dart';

/// Checkout Screen - ZRent Buyer App
/// 
/// Offer flow and escrow initiation with:
/// - Property summary
/// - Offer form
/// - Escrow information
/// - Submit offer action
class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            const CheckoutHeader(),
            // Content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    SizedBox(height: 24),
                    PropertySummary(),
                    SizedBox(height: 24),
                    OfferForm(),
                    SizedBox(height: 24),
                    EscrowInfo(),
                    SizedBox(height: 100), // Space for bottom button
                  ],
                ),
              ),
            ),
            // Bottom Button
            const CheckoutButton(),
          ],
        ),
      ),
    );
  }
}

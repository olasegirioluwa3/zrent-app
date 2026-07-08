import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../widgets/payments_header.dart';
import '../widgets/payment_method_card.dart';
import '../widgets/add_payment_method.dart';
import '../widgets/checkout_button.dart';

/// Payments Screen - ZRent Buyer App
/// 
/// Payment methods and escrow payments with:
/// - Header
/// - Payment methods list
/// - Add new payment method
/// - Checkout action
class PaymentsScreen extends StatelessWidget {
  const PaymentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            const PaymentsHeader(),
            const SizedBox(height: 24),
            // Payment Methods
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'Payment Methods',
                        style: AppTypography.h4,
                      ),
                    ),
                    SizedBox(height: 16),
                    PaymentMethodCard(
                      type: 'Card',
                      lastFour: '4242',
                      expiry: '12/25',
                      isDefault: true,
                    ),
                    SizedBox(height: 12),
                    PaymentMethodCard(
                      type: 'Card',
                      lastFour: '5555',
                      expiry: '08/26',
                      isDefault: false,
                    ),
                    SizedBox(height: 12),
                    PaymentMethodCard(
                      type: 'Bank',
                      lastFour: '7890',
                      expiry: '',
                      isDefault: false,
                    ),
                    SizedBox(height: 24),
                    AddPaymentMethod(),
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

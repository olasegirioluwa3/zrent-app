import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../widgets/order_detail_header.dart';
import '../widgets/order_property_summary.dart';
import '../widgets/order_timeline.dart';
import '../widgets/order_payment_info.dart';
import '../widgets/order_actions.dart';

/// Order Detail Screen - ZRent Buyer App
/// 
/// Shows detailed order information with:
/// - Header
/// - Property summary
/// - Order timeline
/// - Payment info
/// - Action buttons
class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            const OrderDetailHeader(),
            // Content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    SizedBox(height: 24),
                    OrderPropertySummary(),
                    SizedBox(height: 24),
                    OrderTimeline(),
                    SizedBox(height: 24),
                    OrderPaymentInfo(),
                    SizedBox(height: 100), // Space for bottom actions
                  ],
                ),
              ),
            ),
            // Actions
            const OrderActions(),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../widgets/orders_header.dart';
import '../widgets/order_filter_tabs.dart';
import '../widgets/order_card.dart';

/// Orders List Screen - ZRent Buyer App
/// 
/// Shows all user orders with:
/// - Header
/// - Filter tabs (All, Pending, Confirmed, Completed)
/// - Order cards with status
class OrdersListScreen extends StatelessWidget {
  const OrdersListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            const OrdersHeader(),
            const SizedBox(height: 16),
            const OrderFilterTabs(),
            const SizedBox(height: 24),
            // Orders List
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: const [
                  OrderCard(
                    orderId: '#ORD-2024-001',
                    propertyName: 'Luxury 3-Bedroom Apartment',
                    propertyImage: 'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?w=200',
                    location: 'Victoria Island, Lagos',
                    amount: '₦850,000',
                    status: 'Pending',
                    date: 'June 30, 2024',
                  ),
                  SizedBox(height: 16),
                  OrderCard(
                    orderId: '#ORD-2024-002',
                    propertyName: 'Modern Studio Apartment',
                    propertyImage: 'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=200',
                    location: 'Lekki Phase 1, Lagos',
                    amount: '₦350,000',
                    status: 'Confirmed',
                    date: 'June 28, 2024',
                  ),
                  SizedBox(height: 16),
                  OrderCard(
                    orderId: '#ORD-2024-003',
                    propertyName: 'Penthouse Suite',
                    propertyImage: 'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=200',
                    location: 'Ikoyi, Lagos',
                    amount: '₦1,200,000',
                    status: 'Completed',
                    date: 'June 20, 2024',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 100), // Space for bottom nav
          ],
        ),
      ),
    );
  }
}

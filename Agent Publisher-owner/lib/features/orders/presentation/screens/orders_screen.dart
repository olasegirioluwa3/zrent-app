import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

/// Orders Screen
/// 
/// Figma: https://www.figma.com/design/MwxOsKuN9q6b815CH3IcLJ/Untitled?node-id=304-1848
/// Screen ID: 198:47
class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.background,
        elevation: 0,
        title: const Text('Orders'),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            _buildOrderCard(
              context,
              orderId: 'ORD-001',
              propertyName: 'Modern Apartment',
              buyerName: 'John Doe',
              status: 'Pending',
              statusColor: AppTheme.warning,
              amount: '\$1,200',
            ),
            _buildOrderCard(
              context,
              orderId: 'ORD-002',
              propertyName: 'Luxury Villa',
              buyerName: 'Jane Smith',
              status: 'Completed',
              statusColor: AppTheme.success,
              amount: '\$5,000',
            ),
            _buildOrderCard(
              context,
              orderId: 'ORD-003',
              propertyName: 'Cozy Studio',
              buyerName: 'Bob Johnson',
              status: 'Cancelled',
              statusColor: AppTheme.error,
              amount: '\$800',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderCard(
    BuildContext context, {
    required String orderId,
    required String propertyName,
    required String buyerName,
    required String status,
    required Color statusColor,
    required String amount,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  orderId,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppTheme.textSecondary,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: statusColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              propertyName,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppTheme.secondary,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.person, size: 16, color: AppTheme.textSecondary),
                const SizedBox(width: 4),
                Text(
                  buyerName,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  amount,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.secondary,
                  ),
                ),
                OutlinedButton(
                  onPressed: () {
                    // TODO: View order details
                  },
                  child: const Text('View Details'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

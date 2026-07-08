import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

/// Notifications Screen
/// 
/// Figma: https://www.figma.com/design/MwxOsKuN9q6b815CH3IcLJ/Untitled?node-id=304-2675
/// Screen ID: 199:1413
class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.background,
        elevation: 0,
        title: const Text('Notifications'),
        actions: [
          TextButton(
            onPressed: () {
              // TODO: Mark all as read
            },
            child: const Text('Mark all read'),
          ),
        ],
      ),
      body: ListView(
        children: [
          _buildNotificationItem(
            icon: Icons.shopping_bag,
            title: 'New Order Received',
            subtitle: 'You have a new order for Modern Apartment',
            time: '2 min ago',
            isUnread: true,
            color: AppTheme.success,
          ),
          _buildNotificationItem(
            icon: Icons.message,
            title: 'New Message',
            subtitle: 'John Doe sent you a message',
            time: '1 hour ago',
            isUnread: true,
            color: AppTheme.primary,
          ),
          _buildNotificationItem(
            icon: Icons.account_balance_wallet,
            title: 'Withdrawal Successful',
            subtitle: 'Your withdrawal of \$500 has been processed',
            time: '3 hours ago',
            isUnread: false,
            color: AppTheme.secondary,
          ),
          _buildNotificationItem(
            icon: Icons.verified,
            title: 'Verification Approved',
            subtitle: 'Your document verification has been approved',
            time: 'Yesterday',
            isUnread: false,
            color: AppTheme.success,
          ),
          _buildNotificationItem(
            icon: Icons.list_alt,
            title: 'Property Published',
            subtitle: 'Your property listing is now live',
            time: '2 days ago',
            isUnread: false,
            color: AppTheme.primary,
          ),
          _buildNotificationItem(
            icon: Icons.star,
            title: 'New Review',
            subtitle: 'You received a 5-star review',
            time: '3 days ago',
            isUnread: false,
            color: AppTheme.warning,
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required String time,
    required bool isUnread,
    required Color color,
  }) {
    return Container(
      color: isUnread ? AppTheme.surface.withOpacity(0.5) : Colors.transparent,
      child: InkWell(
        onTap: () {
          // TODO: Handle notification tap
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: isUnread ? FontWeight.w600 : FontWeight.normal,
                        color: AppTheme.secondary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppTheme.textSecondary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    time,
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppTheme.textTertiary,
                    ),
                  ),
                  if (isUnread)
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: AppTheme.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Notification Screen - ZRent Buyer App
///
/// Notification center displaying:
/// - App bar with back button, title, and user profile
/// - Recent notification section with badge
/// - Clear all button
/// - List of notification items with icons, titles, descriptions, and timestamps
class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color(0xFF1E3A8A),
            size: 24,
          ),
        ),
        title: const Text(
          'Notification',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1E3A8A),
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: [
                // Profile picture
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFFE5E7EB),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/profile_placeholder.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                // User name
                const Text(
                  'Bessie Cooper',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF1E3A8A),
                  ),
                ),
                const SizedBox(width: 4),
                // Dropdown arrow
                const Icon(
                  Icons.keyboard_arrow_down,
                  color: Color(0xFF6B7280),
                  size: 20,
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          // Recent Notification header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text(
                      'Recent Notification',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1E3A8A),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Notification badge
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEF4444),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        '1',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                // Clear All button
                GestureDetector(
                  onTap: () {
                    // TODO: Clear all notifications
                  },
                  child: const Text(
                    'Clear All',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF84CC16),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Notification list
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              children: const [
                _NotificationItem(
                  icon: Icons.home_outlined,
                  iconColor: Color(0xFF84CC16),
                  title: 'New Property Listed',
                  description: 'A new property has been listed in your area.',
                  time: '2m ago',
                  hasUnread: true,
                ),
                _NotificationItem(
                  icon: Icons.message_outlined,
                  iconColor: Color(0xFF3B82F6),
                  title: 'New Message',
                  description: 'You have a new message from John Doe.',
                  time: '1h ago',
                  hasUnread: false,
                ),
                _NotificationItem(
                  icon: Icons.favorite_border,
                  iconColor: Color(0xFFEF4444),
                  title: 'Property Liked',
                  description: 'Someone liked your saved property.',
                  time: '3h ago',
                  hasUnread: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NotificationItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String description;
  final String time;
  final bool hasUnread;

  const _NotificationItem({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.description,
    required this.time,
    required this.hasUnread,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: hasUnread ? const Color(0xFFF9FAFB) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: hasUnread ? const Color(0xFF84CC16) : const Color(0xFFE5E7EB),
          width: hasUnread ? 1 : 1,
        ),
      ),
      child: Row(
        children: [
          // Icon with notification dot
          Stack(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 24,
                ),
              ),
              if (hasUnread)
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: const BoxDecoration(
                      color: Color(0xFFEF4444),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 16),
          // Text content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: hasUnread ? FontWeight.w600 : FontWeight.w500,
                    color: const Color(0xFF1E3A8A),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // Time
          Text(
            time,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Color(0xFF9CA3AF),
            ),
          ),
        ],
      ),
    );
  }
}

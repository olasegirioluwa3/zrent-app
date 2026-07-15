import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../home/presentation/widgets/bottom_nav_bar.dart';

/// Profile Screen - ZRent Buyer App
///
/// User profile screen displaying:
/// - Profile picture and name
/// - Date and location info
/// - Edit button
/// - Other information section (Notification, Payment, Location, Support, Log out)
/// - Bottom navigation bar
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 32),
              // Profile picture
              const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/profile_placeholder.png'),
                backgroundColor: Color(0xFFE5E7EB),
              ),
              const SizedBox(height: 16),
              // Name
              const Text(
                'Bessie Cooper',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1E3A8A),
                ),
              ),
              const SizedBox(height: 8),
              // Date
              const Text(
                '15 May 2026',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF6B7280),
                ),
              ),
              const SizedBox(height: 4),
              // Location
              const Text(
                'Ikeja, Lagos, Nigeria',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF6B7280),
                ),
              ),
              const SizedBox(height: 16),
              // Edit button
              OutlinedButton.icon(
                onPressed: () {
                  // TODO: Navigate to edit profile screen
                },
                icon: const Icon(
                  Icons.edit_outlined,
                  size: 18,
                  color: Color(0xFF84CC16),
                ),
                label: const Text(
                  'Edit',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF84CC16),
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(
                    color: Color(0xFF84CC16),
                    width: 1,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              // Other Information section
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x0D000000),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Notification with toggle
                    _buildMenuItem(
                      icon: Icons.notifications_outlined,
                      title: 'Notification',
                      trailing: Switch(
                        value: _notificationsEnabled,
                        onChanged: (value) {
                          setState(() {
                            _notificationsEnabled = value;
                          });
                        },
                        activeColor: const Color(0xFF84CC16),
                      ),
                    ),
                    const Divider(height: 1, color: Color(0xFFE5E7EB)),
                    // Payment
                    _buildMenuItem(
                      icon: Icons.payment_outlined,
                      title: 'Payment',
                      onTap: () {
                        // TODO: Navigate to payment screen
                      },
                    ),
                    const Divider(height: 1, color: Color(0xFFE5E7EB)),
                    // Location
                    _buildMenuItem(
                      icon: Icons.location_on_outlined,
                      title: 'Location',
                      onTap: () {
                        // TODO: Navigate to location screen
                      },
                    ),
                    const Divider(height: 1, color: Color(0xFFE5E7EB)),
                    // Support
                    _buildMenuItem(
                      icon: Icons.support_agent_outlined,
                      title: 'Support',
                      onTap: () {
                        // TODO: Navigate to support screen
                      },
                    ),
                    const Divider(height: 1, color: Color(0xFFE5E7EB)),
                    // Log out
                    _buildMenuItem(
                      icon: Icons.logout_outlined,
                      title: 'Log out',
                      onTap: () {
                        Navigator.of(context).pushReplacementNamed('/');
                      },
                      titleColor: const Color(0xFFEF4444),
                      iconColor: const Color(0xFFEF4444),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 100), // Space for bottom nav
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(initialIndex: 4),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    Widget? trailing,
    VoidCallback? onTap,
    Color titleColor = const Color(0xFF1E3A8A),
    Color iconColor = const Color(0xFF6B7280),
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Icon(
              icon,
              color: iconColor,
              size: 24,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: titleColor,
                ),
              ),
            ),
            if (trailing != null)
              trailing
            else
              const Icon(
                Icons.chevron_right,
                color: Color(0xFF9CA3AF),
                size: 24,
              ),
          ],
        ),
      ),
    );
  }
}

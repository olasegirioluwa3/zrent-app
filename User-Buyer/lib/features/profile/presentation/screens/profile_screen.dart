import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../home/presentation/widgets/bottom_nav_bar.dart';
import 'dart:io';
import 'payment_details_screen.dart';
import 'support_screen.dart';
import 'edit_profile_screen.dart';
import 'package:zrent_buyer/shared/providers/profile_provider.dart';
import '../../../home/presentation/providers/location_provider.dart';

/// Profile Screen - ZRent Buyer App
///
/// User profile screen displaying:
/// - Profile picture and name
/// - Date and location info (dynamic location from locationProvider)
/// - Edit button
/// - Other information section (Notification, Payment, Location switch, Support, Log out)
/// - Bottom navigation bar
class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  bool _notificationsEnabled = true;
  bool _locationEnabled = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    final locationState = ref.watch(locationProvider);
    final profileState = ref.watch(profileProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 32),
              // Profile picture
              CircleAvatar(
                radius: 50,
                backgroundColor: const Color(0xFFE5E7EB),
                backgroundImage: profileState.profilePicturePath != null
                    ? (profileState.isProfilePicLocal
                        ? FileImage(File(profileState.profilePicturePath!)) as ImageProvider
                        : AssetImage(profileState.profilePicturePath!) as ImageProvider)
                    : const AssetImage('assets/images/profile_placeholder.png'),
              ),
              const SizedBox(height: 16),
              // Name
              Text(
                profileState.name,
                style: const TextStyle(
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
              // Address Location
              Text(
                profileState.address,
                style: const TextStyle(
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EditProfileScreen(),
                    ),
                  );
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PaymentDetailsScreen(),
                          ),
                        );
                      },
                    ),
                    const Divider(height: 1, color: Color(0xFFE5E7EB)),
                    // Location with toggle switch
                    _buildMenuItem(
                      icon: Icons.location_on_outlined,
                      title: 'Location',
                      trailing: Switch(
                        value: _locationEnabled,
                        onChanged: (value) async {
                          setState(() {
                            _locationEnabled = value;
                          });
                          if (value) {
                            await ref.read(locationProvider.notifier).requestAndFetchLocation();
                            if (!mounted) return;
                            final updatedState = ref.read(locationProvider);
                            if (updatedState.errorMessage != null) {
                              setState(() {
                                _locationEnabled = false;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(updatedState.errorMessage!),
                                  backgroundColor: AppColors.error,
                                ),
                              );
                            }
                          } else {
                            // Reset location to default when toggled off
                            ref.read(locationProvider.notifier).updateLocation(
                              country: 'Nigeria',
                              allLocationsEnabled: false,
                              city: 'Lagos',
                            );
                          }
                        },
                        activeColor: const Color(0xFF84CC16),
                      ),
                    ),
                    const Divider(height: 1, color: Color(0xFFE5E7EB)),
                    // Support
                    _buildMenuItem(
                      icon: Icons.support_agent_outlined,
                      title: 'Support',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SupportScreen(),
                          ),
                        );
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

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_theme.dart';

/// Profile Screen
/// 
/// Figma: https://www.figma.com/design/MwxOsKuN9q6b815CH3IcLJ/Untitled?node-id=304-1002
/// 
/// When Agent clicked on profile picture in Home it takes them to their profile
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Future<void> _logout(BuildContext context) async {
    await Supabase.instance.client.auth.signOut();
    if (context.mounted) {
      context.go(RouteNames.splash);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: const Text(
          'Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppTheme.secondary,
            letterSpacing: -0.5,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Profile Header
                _buildProfileHeader(context),
                const SizedBox(height: 32),
                
                // General Settings Group
                _buildMenuGroup(
                  title: 'General',
                  items: [
                    _buildMenuItem(
                      icon: LucideIcons.user,
                      title: 'Edit Profile',
                      onTap: () {
                        // TODO: Navigate to edit profile
                      },
                    ),
                    _buildMenuItem(
                      icon: LucideIcons.badgeCheck,
                      title: 'Verification',
                      onTap: () {
                        context.push(RouteNames.verificationDashboard);
                      },
                    ),
                    _buildMenuItem(
                      icon: LucideIcons.sparkles,
                      title: 'Subscription Plans',
                      onTap: () {
                        context.push(RouteNames.subscription);
                      },
                    ),
                    _buildMenuItem(
                      icon: LucideIcons.list,
                      title: 'My Properties',
                      onTap: () {
                        context.go(RouteNames.properties);
                      },
                    ),
                    _buildMenuItem(
                      icon: LucideIcons.wallet,
                      title: 'Wallet',
                      onTap: () {
                        context.go(RouteNames.wallet);
                      },
                    ),
                  ],
                ),
                
                const SizedBox(height: 24),

                // App Settings Group
                _buildMenuGroup(
                  title: 'App Settings',
                  items: [
                    _buildMenuItem(
                      icon: LucideIcons.settings,
                      title: 'Settings',
                      onTap: () {
                        context.push(RouteNames.settings);
                      },
                    ),
                    _buildMenuItem(
                      icon: LucideIcons.helpCircle,
                      title: 'Help & Support',
                      onTap: () {
                        // TODO: Navigate to help
                      },
                    ),
                    _buildMenuItem(
                      icon: LucideIcons.info,
                      title: 'About',
                      onTap: () {
                        // TODO: Show about dialog
                      },
                      showDivider: false,
                    ),
                  ],
                ),
                
                const SizedBox(height: 32),

                // Logout Button
                InkWell(
                  onTap: () => _showLogoutDialog(context),
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: AppTheme.error.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppTheme.error.withOpacity(0.2)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(LucideIcons.logOut, color: AppTheme.error, size: 20),
                        const SizedBox(width: 8),
                        const Text(
                          'Logout',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.error,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppTheme.primary.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
            border: Border.all(
              color: AppTheme.background,
              width: 4,
            ),
          ),
          child: CircleAvatar(
            radius: 56,
            backgroundColor: AppTheme.primary,
            child: const Icon(
              LucideIcons.user,
              color: AppTheme.secondary,
              size: 48,
            ),
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Agent Name',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: AppTheme.secondary,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'agent@example.com',
          style: TextStyle(
            fontSize: 15,
            color: AppTheme.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 16),
        GestureDetector(
          onTap: () => context.push(RouteNames.subscription),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppTheme.success.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppTheme.success.withOpacity(0.2)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(LucideIcons.shieldCheck, color: AppTheme.success, size: 16),
                const SizedBox(width: 6),
                const Text(
                  'Tier 1 Agent',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.success,
                    letterSpacing: 0.2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMenuGroup({
    required String title,
    required List<Widget> items,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 12),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppTheme.textTertiary,
              letterSpacing: 0.5,
              textBaseline: TextBaseline.alphabetic,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppTheme.background,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppTheme.borderLight, width: 1.5),
            boxShadow: [
              BoxShadow(
                color: AppTheme.secondary.withOpacity(0.02),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: items,
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? color,
    bool showDivider = true,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: (color ?? AppTheme.secondary).withOpacity(0.08),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      icon,
                      color: color ?? AppTheme.secondary,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: color ?? AppTheme.secondary,
                      ),
                    ),
                  ),
                  Icon(
                    LucideIcons.chevronRight,
                    color: AppTheme.textTertiary,
                    size: 20,
                  ),
                ],
              ),
            ),
            if (showDivider)
              Padding(
                padding: const EdgeInsets.only(left: 64.0, right: 20.0),
                child: Divider(
                  height: 1,
                  color: AppTheme.borderLight,
                  thickness: 1.5,
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        backgroundColor: AppTheme.background,
        elevation: 0,
        title: const Text(
          'Logout',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppTheme.secondary,
            letterSpacing: -0.5,
          ),
          textAlign: TextAlign.center,
        ),
        content: const Text(
          'Are you sure you want to logout? You will need to login again to access your account.',
          style: TextStyle(
            color: AppTheme.textSecondary,
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
        actionsPadding: const EdgeInsets.only(left: 24, right: 24, bottom: 24, top: 8),
        actions: [
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _logout(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.error,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Logout',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/router/route_names.dart';

/// Settings Screen for ZRent Agent
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _pushNotifications = true;
  bool _emailNotifications = false;
  bool _biometricAuth = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft, color: AppTheme.secondary),
          onPressed: () => context.pop(),
        ),
        centerTitle: true,
        title: const Text(
          'Settings',
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Account Settings Group
                _buildSettingGroup(
                  title: 'Account Settings',
                  items: [
                    _buildNavigationItem(
                      icon: LucideIcons.user,
                      title: 'Personal Information',
                      subtitle: 'Update your name, email, and phone',
                      onTap: () {
                        // TODO: Navigate to personal info
                      },
                    ),
                    _buildNavigationItem(
                      icon: LucideIcons.keyRound,
                      title: 'Change Password',
                      subtitle: 'Choose a strong, secure password',
                      onTap: () {
                        // TODO: Navigate to change password
                      },
                    ),
                    _buildNavigationItem(
                      icon: LucideIcons.shieldCheck,
                      title: 'Verification status',
                      subtitle: 'Tier 1 Agent - View limits',
                      onTap: () {
                        context.push(RouteNames.verificationDashboard);
                      },
                      showDivider: false,
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Notifications Group
                _buildSettingGroup(
                  title: 'Notifications',
                  items: [
                    _buildToggleItem(
                      icon: LucideIcons.bell,
                      title: 'Push Notifications',
                      subtitle: 'Instant alerts on listings and offers',
                      value: _pushNotifications,
                      onChanged: (val) {
                        setState(() {
                          _pushNotifications = val;
                        });
                      },
                    ),
                    _buildToggleItem(
                      icon: LucideIcons.mail,
                      title: 'Email Notifications',
                      subtitle: 'Daily digest and performance metrics',
                      value: _emailNotifications,
                      onChanged: (val) {
                        setState(() {
                          _emailNotifications = val;
                        });
                      },
                      showDivider: false,
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Security & Wallet Settings Group
                _buildSettingGroup(
                  title: 'Security',
                  items: [
                    _buildToggleItem(
                      icon: LucideIcons.fingerprint,
                      title: 'Biometric Authentication',
                      subtitle: 'Use FaceID/TouchID to access app',
                      value: _biometricAuth,
                      onChanged: (val) {
                        setState(() {
                          _biometricAuth = val;
                        });
                      },
                    ),
                    _buildNavigationItem(
                      icon: LucideIcons.lockKeyhole,
                      title: 'Change Transaction PIN',
                      subtitle: 'Secure wallet withdrawals',
                      onTap: () {
                        context.push(RouteNames.setPin);
                      },
                      showDivider: false,
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Legal & About Group
                _buildSettingGroup(
                  title: 'Support & Legal',
                  items: [
                    _buildNavigationItem(
                      icon: LucideIcons.helpCircle,
                      title: 'Terms of Service',
                      subtitle: 'View user agreement',
                      onTap: () {},
                    ),
                    _buildNavigationItem(
                      icon: LucideIcons.shieldAlert,
                      title: 'Privacy Policy',
                      subtitle: 'How we manage your data',
                      onTap: () {},
                      showDivider: false,
                    ),
                  ],
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSettingGroup({
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

  Widget _buildNavigationItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
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
                      color: AppTheme.secondary.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      icon,
                      color: AppTheme.secondary,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.secondary,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          subtitle,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppTheme.textSecondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    LucideIcons.chevronRight,
                    color: AppTheme.textTertiary,
                    size: 20,
                  ),
                ],
              ),
            ),
            if (showDivider)
              const Padding(
                padding: EdgeInsets.only(left: 64.0, right: 20.0),
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

  Widget _buildToggleItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    bool showDivider = true,
  }) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppTheme.secondary.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: AppTheme.secondary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.secondary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppTheme.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Switch.adaptive(
                value: value,
                activeColor: AppTheme.primary,
                activeTrackColor: AppTheme.primary.withOpacity(0.4),
                inactiveThumbColor: Colors.white,
                inactiveTrackColor: AppTheme.border,
                onChanged: onChanged,
              ),
            ],
          ),
        ),
        if (showDivider)
          const Padding(
            padding: EdgeInsets.only(left: 64.0, right: 20.0),
            child: Divider(
              height: 1,
              color: AppTheme.borderLight,
              thickness: 1.5,
            ),
          ),
      ],
    );
  }
}

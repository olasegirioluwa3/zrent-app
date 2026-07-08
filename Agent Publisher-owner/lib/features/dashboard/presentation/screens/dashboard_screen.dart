import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_theme.dart';

/// Agent Dashboard
/// 
/// Figma: https://www.figma.com/design/MwxOsKuN9q6b815CH3IcLJ/Untitled?node-id=304-1276
/// Screen ID: 189:17
/// 
/// Purpose:
/// - Wallet
/// - Listings
/// - Analytics
/// - Orders
class DashboardScreen extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const DashboardScreen({
    super.key,
    required this.navigationShell,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppTheme.background,
          border: Border(
            top: BorderSide(
              color: AppTheme.borderLight,
              width: 1.5,
            ),
          ),
        ),
        child: NavigationBarTheme(
          data: NavigationBarThemeData(
            indicatorColor: AppTheme.primary.withOpacity(0.25),
            labelTextStyle: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.selected)) {
                return const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.secondary,
                );
              }
              return const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppTheme.textSecondary,
              );
            }),
            iconTheme: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.selected)) {
                return const IconThemeData(
                  color: AppTheme.secondary,
                  size: 24,
                );
              }
              return const IconThemeData(
                color: AppTheme.textSecondary,
                size: 24,
              );
            }),
          ),
          child: NavigationBar(
            height: 70,
            elevation: 0,
            selectedIndex: navigationShell.currentIndex,
            onDestinationSelected: (index) {
              navigationShell.goBranch(index);
            },
            backgroundColor: AppTheme.background,
            destinations: const [
              NavigationDestination(
                icon: Icon(LucideIcons.home),
                selectedIcon: Icon(LucideIcons.home, color: AppTheme.secondary),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(LucideIcons.list),
                selectedIcon: Icon(LucideIcons.list, color: AppTheme.secondary),
                label: 'Listings',
              ),
              NavigationDestination(
                icon: Icon(LucideIcons.messageSquare),
                selectedIcon: Icon(LucideIcons.messageSquare, color: AppTheme.secondary),
                label: 'Messages',
              ),
              NavigationDestination(
                icon: Icon(LucideIcons.wallet),
                selectedIcon: Icon(LucideIcons.wallet, color: AppTheme.secondary),
                label: 'Wallet',
              ),
              NavigationDestination(
                icon: Icon(LucideIcons.user),
                selectedIcon: Icon(LucideIcons.user, color: AppTheme.secondary),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Dashboard Home Screen
class DashboardHomeScreen extends StatelessWidget {
  const DashboardHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        title: const Text(
          'Dashboard',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppTheme.secondary,
            fontSize: 24,
            letterSpacing: -0.5,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              color: AppTheme.borderLight.withOpacity(0.5),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(
                LucideIcons.bell,
                color: AppTheme.secondary,
              ),
              onPressed: () {
                context.push(RouteNames.notifications);
              },
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Section
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.primary.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: AppTheme.primary.withOpacity(0.15),
                    width: 1.5,
                  ),
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.push(RouteNames.profile);
                      },
                      child: Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color: AppTheme.primary,
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.primary.withOpacity(0.2),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Icon(
                          LucideIcons.user,
                          color: AppTheme.secondary,
                          size: 28,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Welcome back!',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: AppTheme.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Agent Name',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.secondary,
                              letterSpacing: -0.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: AppTheme.background,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.secondary.withOpacity(0.04),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: const Icon(
                          LucideIcons.settings,
                          color: AppTheme.secondary,
                          size: 22,
                        ),
                        onPressed: () {
                          context.push(RouteNames.settings);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Quick Stats Cards
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      context,
                      icon: LucideIcons.list,
                      title: 'Listings',
                      value: '12',
                      onTap: () {
                        context.go(RouteNames.properties);
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard(
                      context,
                      icon: LucideIcons.shoppingBag,
                      title: 'Orders',
                      value: '8',
                      onTap: () {
                        context.push(RouteNames.orders);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      context,
                      icon: LucideIcons.wallet,
                      title: 'Wallet',
                      value: '\$5,420',
                      onTap: () {
                        context.go(RouteNames.wallet);
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard(
                      context,
                      icon: LucideIcons.pieChart,
                      title: 'Analytics',
                      value: 'View',
                      onTap: () {
                        context.push(RouteNames.analytics);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),

              // Recent Activity Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Recent Activity',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.secondary,
                      letterSpacing: -0.3,
                    ),
                  ),
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: AppTheme.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color: AppTheme.background,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: AppTheme.borderLight, width: 1.5),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.secondary.withOpacity(0.02),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _buildActivityItem(
                      icon: LucideIcons.plusCircle,
                      title: 'New property listed',
                      subtitle: '2 hours ago',
                      color: AppTheme.success,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 64.0),
                      child: Divider(height: 1, color: AppTheme.borderLight),
                    ),
                    _buildActivityItem(
                      icon: LucideIcons.shoppingBag,
                      title: 'New order received',
                      subtitle: '5 hours ago',
                      color: AppTheme.primary,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 64.0),
                      child: Divider(height: 1, color: AppTheme.borderLight),
                    ),
                    _buildActivityItem(
                      icon: LucideIcons.messageSquare,
                      title: 'New message from buyer',
                      subtitle: '1 day ago',
                      color: AppTheme.warning,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              // Quick Actions
              const Text(
                'Quick Actions',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.secondary,
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primary.withOpacity(0.2),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      context.push(RouteNames.propertyLocation);
                    },
                    icon: const Icon(LucideIcons.plus, size: 22),
                    label: const Text(
                      'Add New Property',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.1,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primary,
                      foregroundColor: AppTheme.secondary,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.background,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.borderLight, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: AppTheme.secondary.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppTheme.primary.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        icon,
                        color: AppTheme.secondary,
                        size: 24,
                      ),
                    ),
                    const Icon(
                      LucideIcons.chevronRight,
                      color: AppTheme.textTertiary,
                      size: 12,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.textSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.secondary,
                    letterSpacing: -0.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActivityItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon, 
              color: color, 
              size: 20,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
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
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            LucideIcons.chevronRight,
            color: AppTheme.textTertiary,
            size: 18,
          ),
        ],
      ),
    );
  }
}

/// Properties Screen (placeholder)
class PropertiesScreen extends StatelessWidget {
  const PropertiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.background,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'My Properties',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppTheme.secondary,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppTheme.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                LucideIcons.listPlus,
                size: 64,
                color: AppTheme.secondary,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Properties Screen',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

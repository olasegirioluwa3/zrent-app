import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../profile/presentation/screens/profile_screen.dart';
import '../../../discover/presentation/screens/discover_screen.dart';
import '../../../favorites/presentation/screens/favorites_screen.dart';
import '../../../messages/presentation/screens/messages_screen.dart';
import '../screens/home_screen.dart';

/// Bottom Navigation Bar Widget - ZRent Buyer App
///
/// Stateful widget that tracks the selected tab and navigates to:
/// - Home (index 0) — stays on home screen
/// - Discover (index 1) — DiscoverScreen
/// - Favorites (index 2) — FavoritesScreen
/// - Messages (index 3) — MessagesScreen
/// - Profile (index 4) — ProfileScreen
class BottomNavBar extends StatefulWidget {
  final int initialIndex;
  const BottomNavBar({super.key, this.initialIndex = 0});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  void _onItemTapped(BuildContext context, int index) {
    if (_selectedIndex == index) return;

    setState(() => _selectedIndex = index);

    Widget? screen;
    switch (index) {
      case 0:
        screen = const HomeScreen();
        break;
      case 1:
        screen = const DiscoverScreen();
        break;
      case 2:
        screen = const FavoritesScreen();
        break;
      case 3:
        screen = const MessagesScreen();
        break;
      case 4:
        screen = const ProfileScreen();
        break;
    }

    if (screen != null) {
      Navigator.of(context)
          .pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => screen!),
            (route) => false,
          );
    }
  }

  static const _navItems = [
    _NavData(icon: Icons.home_filled, activeIcon: Icons.home, label: 'Home'),
    _NavData(icon: Icons.search, activeIcon: Icons.search, label: 'Discover'),
    _NavData(icon: Icons.favorite_border, activeIcon: Icons.favorite, label: 'Favorites'),
    _NavData(icon: Icons.chat_bubble_outline, activeIcon: Icons.chat_bubble, label: 'Messages'),
    _NavData(icon: Icons.person_outline, activeIcon: Icons.person, label: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Color(0xFFF3F4F6),
            width: 1.5,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(_navItems.length, (index) {
            final item = _navItems[index];
            final isSelected = _selectedIndex == index;
            const activeColor = Color(0xFF042F2C);
            const inactiveColor = Color(0xFF9CA3AF);

            return GestureDetector(
              onTap: () => _onItemTapped(context, index),
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isSelected ? item.activeIcon : item.icon,
                      color: isSelected ? activeColor : inactiveColor,
                      size: 26,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.label,
                      style: GoogleFonts.poppins(
                        color: isSelected ? activeColor : inactiveColor,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class _NavData {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  const _NavData({required this.icon, required this.activeIcon, required this.label});
}

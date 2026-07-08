import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/discover_search_bar.dart';
import '../widgets/recommend_section.dart';
import '../../../home/presentation/screens/home_screen.dart';
import '../../../favorites/presentation/screens/favorites_screen.dart';
import '../../../messages/presentation/screens/messages_screen.dart';
import '../../../profile/presentation/screens/profile_screen.dart';

/// Discover Screen - ZRent Buyer App
///
/// Contains:
/// - Fixed search bar at the top
/// - Fully interactive Vector Street Map (pan/zoomable using InteractiveViewer)
/// - "Recommend for you" section with property cards
/// - Bottom Nav Bar
class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  int _selectedNavIndex = 1; // Discover tab active

  void _onNavTap(int index) {
    if (index == _selectedNavIndex) return;
    setState(() => _selectedNavIndex = index);

    Widget? screen;
    switch (index) {
      case 0:
        screen = const HomeScreen();
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
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => screen!),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: Column(
        children: [
          // ── Fixed Search Bar ─────────────────────────────────────────
          const SafeArea(bottom: false, child: DiscoverSearchBar()),

          // ── Scrollable Body ──────────────────────────────────────────
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Interactive Custom Map ───────────────────────────
                  SizedBox(
                    height: 350,
                    child: ClipRRect(
                      child: InteractiveViewer(
                        maxScale: 2.5,
                        minScale: 0.8,
                        boundaryMargin: const EdgeInsets.all(100),
                        child: const _InteractiveVectorMap(),
                      ),
                    ),
                  ),

                  // Bottom sheet handle pill
                  Center(
                    child: Container(
                      margin: const EdgeInsets.only(top: 12),
                      width: 48,
                      height: 5,
                      decoration: BoxDecoration(
                        color: const Color(0xFFD1D5DB),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // ── Recommend Section ────────────────────────────────
                  const RecommendSection(),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),

          // ── Bottom Navigation ────────────────────────────────────────
          _DiscoverBottomNav(
            selectedIndex: _selectedNavIndex,
            onTap: _onNavTap,
          ),
        ],
      ),
    );
  }
}

/// A custom vector street map widget that draws clean minimalist street grids,
/// street names, routes, and custom pins matching the Figma design.
class _InteractiveVectorMap extends StatelessWidget {
  const _InteractiveVectorMap();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      height: 350,
      color: const Color(0xFFF3F4F6), // Light grey base map background
      child: Stack(
        children: [
          // 1. Street Grid & Route Line Painter
          Positioned.fill(
            child: CustomPaint(
              painter: _MapGridPainter(),
            ),
          ),

          // 2. Map Labels / Street names
          Positioned(
            left: 20,
            top: 120,
            child: RotationTransition(
              turns: const AlwaysStoppedAnimation(-45 / 360),
              child: Text(
                'street name',
                style: GoogleFonts.poppins(
                  fontSize: 8,
                  color: const Color(0xFF9CA3AF),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Positioned(
            right: 180,
            top: 250,
            child: RotationTransition(
              turns: const AlwaysStoppedAnimation(45 / 360),
              child: Text(
                'street name',
                style: GoogleFonts.poppins(
                  fontSize: 8,
                  color: const Color(0xFF9CA3AF),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Positioned(
            left: 170,
            bottom: 60,
            child: Text(
              'STREET',
              style: GoogleFonts.poppins(
                fontSize: 9,
                color: const Color(0xFF6B7280),
                fontWeight: FontWeight.w600,
                letterSpacing: 1,
              ),
            ),
          ),
          Positioned(
            right: 15,
            top: 100,
            child: Text(
              'LOWERVAILSBURG',
              style: GoogleFonts.poppins(
                fontSize: 9,
                color: const Color(0xFF6B7280),
                fontWeight: FontWeight.w600,
                letterSpacing: 1,
              ),
            ),
          ),

          // 3. Custom Green Pin 1 (Origin)
          Positioned(
            left: 90,
            top: 50,
            child: _buildMapPin(),
          ),

          // 4. Custom Green Pin 2 (Destination)
          Positioned(
            left: 200,
            top: 195,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Destination ripple zone matching Figma
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xFF042F2C).withOpacity(0.12),
                    shape: BoxShape.circle,
                  ),
                ),
                _buildMapPin(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMapPin() {
    return Container(
      width: 26,
      height: 26,
      decoration: const BoxDecoration(
        color: Color(0xFFBEF264), // Lime Green pin
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: const Center(
        child: Icon(
          Icons.location_on,
          color: Color(0xFF042F2C), // Dark Teal icon
          size: 16,
        ),
      ),
    );
  }
}

/// Custom Painter to draw the clean street polygons, borders, lines, and route
class _MapGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final streetPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = const Color(0xFFE5E7EB)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    // Draw main street polygon blocks (Figma style blocks)
    // Block 1
    final path1 = Path()
      ..moveTo(0, 80)
      ..lineTo(140, 0)
      ..lineTo(220, 0)
      ..lineTo(50, 120)
      ..close();
    canvas.drawPath(path1, streetPaint);
    canvas.drawPath(path1, borderPaint);

    // Block 2
    final path2 = Path()
      ..moveTo(60, 130)
      ..lineTo(190, 50)
      ..lineTo(250, 120)
      ..lineTo(90, 220)
      ..close();
    canvas.drawPath(path2, streetPaint);
    canvas.drawPath(path2, borderPaint);

    // Block 3
    final path3 = Path()
      ..moveTo(250, 0)
      ..lineTo(400, 0)
      ..lineTo(320, 110)
      ..lineTo(210, 30)
      ..close();
    canvas.drawPath(path3, streetPaint);
    canvas.drawPath(path3, borderPaint);

    // Block 4 (Lower Right)
    final path4 = Path()
      ..moveTo(330, 140)
      ..lineTo(480, 100)
      ..lineTo(480, 250)
      ..lineTo(380, 260)
      ..close();
    canvas.drawPath(path4, streetPaint);
    canvas.drawPath(path4, borderPaint);

    // Block 5 (Lower Left)
    final path5 = Path()
      ..moveTo(0, 180)
      ..lineTo(80, 230)
      ..lineTo(0, 310)
      ..close();
    canvas.drawPath(path5, streetPaint);
    canvas.drawPath(path5, borderPaint);

    // ── Draw the Dark Teal Route Line ──
    final routePaint = Paint()
      ..color = const Color(0xFF042F2C)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.5
      ..strokeCap = StrokeCap.round;

    final routePath = Path()
      ..moveTo(103, 63)     // Near pin 1
      ..lineTo(103, 73)
      ..lineTo(213, 178)    // Zig zag
      ..lineTo(93, 218)
      ..lineTo(213, 210);   // Near pin 2
    canvas.drawPath(routePath, routePaint);

    // Arrowhead at the end of the route line
    final arrowPaint = Paint()
      ..color = const Color(0xFF042F2C)
      ..style = PaintingStyle.fill;
    final arrowPath = Path()
      ..moveTo(125, 170)
      ..lineTo(138, 172)
      ..lineTo(133, 178)
      ..close();
    canvas.drawPath(arrowPath, arrowPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ── Discover-specific BottomNavBar ──────────────────────────────────────────
class _DiscoverBottomNav extends StatelessWidget {
  final int selectedIndex;
  final void Function(int) onTap;

  const _DiscoverBottomNav({
    required this.selectedIndex,
    required this.onTap,
  });

  static const _items = [
    _NavItem(icon: Icons.home_outlined, activeIcon: Icons.home, label: 'Home'),
    _NavItem(icon: Icons.search, activeIcon: Icons.search, label: 'Discover'),
    _NavItem(icon: Icons.favorite_border, activeIcon: Icons.favorite, label: 'Favorites'),
    _NavItem(icon: Icons.chat_bubble_outline, activeIcon: Icons.chat_bubble, label: 'Messages'),
    _NavItem(icon: Icons.person_outline, activeIcon: Icons.person, label: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFF3F4F6), width: 1.5)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(_items.length, (i) {
            final isSelected = selectedIndex == i;
            const activeColor = Color(0xFF042F2C);
            const inactiveColor = Color(0xFF9CA3AF);
            final item = _items[i];
            return GestureDetector(
              onTap: () => onTap(i),
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
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.w500,
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

class _NavItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  const _NavItem(
      {required this.icon, required this.activeIcon, required this.label});
}

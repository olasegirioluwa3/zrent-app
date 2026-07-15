import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Favorites App Bar Widget - ZRent Buyer App
///
/// Matches the Figma design search bar:
/// - Rounded white container
/// - Search icon on the left
/// - Location text "Ikeja, Lagos, Nigeria" in the center
/// - Search/Filter icon on the right
class FavoritesAppBar extends StatelessWidget {
  const FavoritesAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Colors.transparent, // Let the page background show through
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            // Left Search Icon
            const Icon(
              Icons.search,
              color: Color(0xFF042F2C),
              size: 24,
            ),
            const SizedBox(width: 12),
            // Location text in the center
            Expanded(
              child: Text(
                'Ikeja, Lagos, Nigeria',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF042F2C),
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            // Right Search Icon
            const Icon(
              Icons.search,
              color: Color(0xFF042F2C),
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Promo Banner Widget - ZRent Buyer App
///
/// Implements the promotional banner:
/// - Dark teal rounded container
/// - Text: "Save 15%" & "Limited Time Offer Sign up Now"
/// - Coral red "Explore" pill button on the right
class PromoBanner extends StatelessWidget {
  const PromoBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          image: const DecorationImage(
            image: NetworkImage(
              'https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?w=500&auto=format&fit=crop&q=80',
            ),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Color(0xFF042F2C), // Dark green / teal
              BlendMode.colorBurn,
            ),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                const Color(0xFF042F2C).withOpacity(0.95),
                const Color(0xFF021F1D).withOpacity(0.85),
              ],
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Promo Text Column
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Save 15%',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Limited Time Offer Sign up Now',
                      style: GoogleFonts.poppins(
                        color: const Color(0xFFE5E7EB),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              // Explore Button
              ElevatedButton(
                onPressed: () {
                  // Action for explore
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFA5A5A), // Coral Red
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: const StadiumBorder(),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: Text(
                  'Explore',
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

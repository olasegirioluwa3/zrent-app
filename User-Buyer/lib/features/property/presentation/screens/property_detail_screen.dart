import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../messages/presentation/screens/chat_detail_screen.dart';
import '../../../checkout/presentation/screens/checkout_screen.dart';
import '../../../../shared/providers/properties_provider.dart';

/// Property Detail Screen - ZRent Buyer App
/// 
/// 100% compliant with the Figma design mockup:
/// - Hero image carousel with 4 interactive network thumbnails.
/// - Top action buttons (circular back and favorite toggle).
/// - ZRent Logo watermark.
/// - Agent Verified badge and Agent Chat button (navigates to ChatDetailScreen).
/// - Exact address, GPS Coordinates, and high-fidelity specifications.
/// - Interactive Unit Counter and rating info.
/// - "ZRent AI Insight" box with custom styled tags.
/// - "Plot Boundaries" satellite preview drawing the bright green polygon.
/// - Sticky Bottom action bar with price and "Pay Now" button (navigates to CheckoutScreen).
class PropertyDetailScreen extends ConsumerStatefulWidget {
  final String propertyId;

  const PropertyDetailScreen({super.key, required this.propertyId});

  @override
  ConsumerState<PropertyDetailScreen> createState() => _PropertyDetailScreenState();
}

class _PropertyDetailScreenState extends ConsumerState<PropertyDetailScreen> {
  int _selectedImageIndex = 0;
  int _quantity = 1;
  bool _isFavorite = true; // Default to true matching Figma favorite state
  bool _isDescriptionExpanded = false;

  // High-fidelity image gallery URLs from Unsplash
  final List<String> _galleryImages = [
    'https://images.unsplash.com/photo-1613490493576-7fde63acd811?w=1000&auto=format&fit=crop&q=80', // Exterior
    'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=1000&auto=format&fit=crop&q=80', // Living Room
    'https://images.unsplash.com/photo-1600210492486-724fe5c67fb0?w=1000&auto=format&fit=crop&q=80', // Cozy Sofa
    'https://images.unsplash.com/photo-1505691938895-1758d7feb511?w=1000&auto=format&fit=crop&q=80', // Bedroom
  ];

  @override
  Widget build(BuildContext context) {
    final darkTeal = const Color(0xFF042F2C);
    final limeGreen = const Color(0xFFBEF264);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // ── Scrollable Body Content ────────────────────────────────────────
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Image Carousel & Watermark Section
                Stack(
                  children: [
                    // Main Property Image
                    Container(
                      height: 380,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF3F4F6),
                      ),
                      child: Image.network(
                        _galleryImages[_selectedImageIndex],
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(
                            child: Icon(Icons.image_outlined, color: Color(0xFF9CA3AF), size: 48),
                          );
                        },
                      ),
                    ),
                    
                    // ZRent watermark logo overlay (center of the image)
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.apartment,
                                color: Colors.white70,
                                size: 24,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                'ZRent',
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Navigation Back & Favorite Action Buttons
                    Positioned(
                      top: MediaQuery.of(context).padding.top + 12,
                      left: 16,
                      right: 16,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Back Circle Button
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              width: 42,
                              height: 42,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.arrow_back,
                                color: Colors.black87,
                                size: 20,
                              ),
                            ),
                          ),
                          // Favorite Circle Button
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _isFavorite = !_isFavorite;
                              });
                              // Also toggle favorite in global properties if ID matches
                              ref.read(propertiesProvider.notifier).toggleFavorite(widget.propertyId);
                            },
                            child: Container(
                              width: 42,
                              height: 42,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                _isFavorite ? Icons.favorite : Icons.favorite_border,
                                color: _isFavorite ? Colors.red : Colors.grey,
                                size: 22,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Interactive Thumbnails Row (aligned at the bottom of the image)
                    Positioned(
                      bottom: 24,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(_galleryImages.length, (index) {
                          final isSelected = _selectedImageIndex == index;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedImageIndex = index;
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 6),
                              width: 52,
                              height: 52,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: isSelected ? Colors.white : Colors.transparent,
                                  width: 2,
                                ),
                                image: DecorationImage(
                                  image: NetworkImage(_galleryImages[index]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),

                // 2. Main Details Content Overlay
                Transform.translate(
                  offset: const Offset(0, -12),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Agent Verified badge & Agent Chat Button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Verified badge
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE2F9B8),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    'Agent Verified',
                                    style: GoogleFonts.poppins(
                                      color: darkTeal,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Icon(Icons.check_circle_outline, color: darkTeal, size: 13),
                                ],
                              ),
                            ),
                            
                            // Agent Chat button
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ChatDetailScreen(
                                      contactName: 'Bessie Cooper',
                                      avatarUrl: 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=150&h=150&fit=crop&crop=face',
                                      propertyId: widget.propertyId,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                decoration: BoxDecoration(
                                  color: limeGreen,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      'Agent Chat',
                                      style: GoogleFonts.poppins(
                                        color: darkTeal,
                                        fontSize: 11.5,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    Icon(Icons.chat_bubble_outline, color: darkTeal, size: 14),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),

                        // Location & GPS Coordinates Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.location_on, color: Color(0xFF84CC16), size: 16),
                                const SizedBox(width: 4),
                                Text(
                                  'Ikeja, Lagos, Nigeria',
                                  style: GoogleFonts.poppins(
                                    color: const Color(0xFF6B7280),
                                    fontSize: 12.5,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              'GPS Coordinates: 34.0259° N, 118.7798° W',
                              style: GoogleFonts.poppins(
                                color: const Color(0xFF9CA3AF),
                                fontSize: 9.5,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),

                        // Property Title
                        Text(
                          'Luxury 5-Bedroom Apartment with Modern Amenities',
                          style: GoogleFonts.poppins(
                            color: darkTeal,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            height: 1.3,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Demand & Price Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.trending_up, color: Color(0xFF0C4D49), size: 14),
                                    const SizedBox(width: 4),
                                    Text(
                                      'HIGH DEMAND',
                                      style: GoogleFonts.poppins(
                                        color: const Color(0xFF0C4D49),
                                        fontSize: 10,
                                        fontWeight: FontWeight.w800,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '₦12,500,000/month',
                                  style: GoogleFonts.poppins(
                                    color: darkTeal,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              'Price may increase soon',
                              style: GoogleFonts.poppins(
                                color: const Color(0xFFEF4444),
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),

                        // Units Left, Due Date, and Interactive Quantity Counter Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  '3 unit left',
                                  style: GoogleFonts.poppins(
                                    color: const Color(0xFFEF4444),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE2F9B8),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    '2 Due in 5day',
                                    style: GoogleFonts.poppins(
                                      color: darkTeal,
                                      fontSize: 10.5,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            
                            // Quantity Counter
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (_quantity > 1) {
                                      setState(() {
                                        _quantity--;
                                      });
                                    }
                                  },
                                  child: Container(
                                    width: 32,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF3F4F6),
                                      shape: BoxShape.circle,
                                      border: Border.all(color: const Color(0xFFE5E7EB)),
                                    ),
                                    child: const Icon(Icons.remove, size: 16, color: Colors.black87),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  '$_quantity',
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _quantity++;
                                    });
                                  },
                                  child: Container(
                                    width: 32,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF3F4F6),
                                      shape: BoxShape.circle,
                                      border: Border.all(color: const Color(0xFFE5E7EB)),
                                    ),
                                    child: const Icon(Icons.add, size: 16, color: Colors.black87),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),

                        // Rating info
                        Row(
                          children: [
                            const Icon(Icons.star, color: Color(0xFFFFB800), size: 18),
                            const SizedBox(width: 4),
                            Text(
                              '4.8',
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '(128 reviews)',
                              style: GoogleFonts.poppins(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF6B7280),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),

                        // Specifications Row
                        Row(
                          children: [
                            _buildSpecCard('2 Bed'),
                            const SizedBox(width: 10),
                            _buildSpecCard('1 Bath'),
                            const SizedBox(width: 10),
                            _buildSpecCard('1,200 sqft'),
                          ],
                        ),
                        const SizedBox(height: 24),

                        // Description Section
                        Text(
                          'Description',
                          style: GoogleFonts.poppins(
                            color: darkTeal,
                            fontSize: 15.5,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Wings Tower is a modern residential property featuring contemporary architecture with premium finishes. Located in the heart of Jakarta, this property offers convenient access to shopping centers, restaurants, and major transportation hubs. The spacious layout and large windows provide abundant natural light throughout the day.',
                          maxLines: _isDescriptionExpanded ? null : 3,
                          overflow: _isDescriptionExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            color: const Color(0xFF4B5563),
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _isDescriptionExpanded = !_isDescriptionExpanded;
                            });
                          },
                          child: Text(
                            _isDescriptionExpanded ? 'Read less' : 'Read more',
                            style: GoogleFonts.poppins(
                              color: const Color(0xFF0C4D49),
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // ZRent AI Insight Section
                        Row(
                          children: [
                            const Icon(Icons.auto_awesome, color: Color(0xFF042F2C), size: 18),
                            const SizedBox(width: 6),
                            Text(
                              'ZRENT AI INSIGHT',
                              style: GoogleFonts.poppins(
                                color: darkTeal,
                                fontSize: 13.5,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF9FAFB),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: const Color(0xFFE5E7EB)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '"This property sits in the 98th percentile for capital appreciation in the Dubai Hills sector. Recent expansion of the nearby marina and Zrent-exclusive predictive analytics suggest a 12% equity growth within the next 18 months."',
                                style: GoogleFonts.poppins(
                                  color: const Color(0xFF374151),
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.italic,
                                  height: 1.5,
                                ),
                              ),
                              const SizedBox(height: 14),
                              Row(
                                children: [
                                  _buildInsightTag('Market Leader', Icons.trending_up),
                                  const SizedBox(width: 8),
                                  _buildInsightTag('High Liquidity', Icons.pie_chart_outline),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Plot Boundaries Section
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Plot Boundaries',
                              style: GoogleFonts.poppins(
                                color: darkTeal,
                                fontSize: 15.5,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              'OPEN SATELLITE',
                              style: GoogleFonts.poppins(
                                color: const Color(0xFF0C4D49),
                                fontSize: 11.5,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        
                        // Satellite Map Container with polygon custom painter overlay
                        Container(
                          height: 220,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: const Color(0xFFE5E7EB)),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Stack(
                              children: [
                                // Map background image
                                Positioned.fill(
                                  child: Image.network(
                                    'https://images.unsplash.com/photo-1524661135-423995f22d0b?w=600&auto=format&fit=crop&q=80',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                // Custom Paint overlay drawing the green boundary polygon
                                Positioned.fill(
                                  child: CustomPaint(
                                    painter: _MapBoundaryPainter(),
                                  ),
                                ),
                                // GPS Coordinates overlay card at the bottom
                                Positioned(
                                  bottom: 12,
                                  left: 12,
                                  right: 12,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.92),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      'GPS Coordinates: 34.0259° N, 118.7798° W',
                                      style: GoogleFonts.poppins(
                                        color: Colors.black87,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        
                        // Extra bottom padding to scroll past the fixed bottom bar
                        const SizedBox(height: 110),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ── Sticky Bottom Action Bar ───────────────────────────────────────
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 10,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '₦12,500,000/month',
                        style: GoogleFonts.poppins(
                          color: darkTeal,
                          fontSize: 18.5,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Escrow protected',
                        style: GoogleFonts.poppins(
                          color: const Color(0xFF6B7280),
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  
                  // Pay Now Button
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CheckoutScreen(propertyId: widget.propertyId),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                      decoration: BoxDecoration(
                        color: darkTeal,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        'Pay Now',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 14.5,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Specifications Widget Chip
  Widget _buildSpecCard(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 12.5,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }

  // AI Insight tag chip
  Widget _buildInsightTag(String text, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: const Color(0xFF4B5563)),
          const SizedBox(width: 4),
          Text(
            text,
            style: GoogleFonts.poppins(
              color: const Color(0xFF4B5563),
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

/// Custom Painter drawing a clean green polygon overlay boundary on map
class _MapBoundaryPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final borderPaint = Paint()
      ..color = const Color(0xFF10B981) // Green border color matching Figma
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    final fillPaint = Paint()
      ..color = const Color(0xFF10B981).withOpacity(0.18) // Semi-transparent green fill
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(size.width * 0.38, size.height * 0.32)
      ..lineTo(size.width * 0.62, size.height * 0.28)
      ..lineTo(size.width * 0.58, size.height * 0.72)
      ..lineTo(size.width * 0.42, size.height * 0.68)
      ..close();

    canvas.drawPath(path, fillPaint);
    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

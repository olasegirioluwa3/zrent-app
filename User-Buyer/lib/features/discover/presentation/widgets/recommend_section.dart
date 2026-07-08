import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../agent_profile/presentation/screens/agent_profile_screen.dart';
import '../../../messages/presentation/screens/chat_detail_screen.dart';

/// Recommend Section - ZRent Buyer Discover Screen
///
/// Matches the Figma layout:
/// 1. Section title "Recommend for you"
/// 2. Horizontal scrollable list of property cards (image left, details right)
/// 3. 2-column grid of property cards (image full top, heart icon, no agent row)
class RecommendSection extends StatelessWidget {
  const RecommendSection({super.key});

  static const _horizontalProperties = [
    _PropertyData(
      imageUrl: 'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=400&auto=format&fit=crop&q=80',
      price: '\$280/month',
      title: 'Urban Loft',
      location: 'Jakarta, Indonesia',
      isVerified: true,
    ),
    _PropertyData(
      imageUrl: 'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?w=400&auto=format&fit=crop&q=80',
      price: '\$350/month',
      title: 'Sky Residence',
      location: 'Jakarta, Indonesia',
      isVerified: false,
    ),
    _PropertyData(
      imageUrl: 'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?w=400&auto=format&fit=crop&q=80',
      price: '\$420/month',
      title: 'Garden Villa',
      location: 'Bali, Indonesia',
      isVerified: true,
    ),
  ];

  static const _gridProperties = [
    _PropertyData(
      imageUrl: 'https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?w=400&auto=format&fit=crop&q=80',
      price: '\$280/month',
      title: 'Urban Loft',
      location: 'Jakarta, Indonesia',
      isVerified: false,
    ),
    _PropertyData(
      imageUrl: 'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=400&auto=format&fit=crop&q=80',
      price: '\$280/month',
      title: 'Urban Loft',
      location: 'Jakarta, Indonesia',
      isVerified: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Section title ──────────────────────────────────────────────
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Recommend  for you',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF111827),
            ),
          ),
        ),
        const SizedBox(height: 16),

        // ── Horizontal property cards ──────────────────────────────────
        SizedBox(
          height: 120,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            physics: const BouncingScrollPhysics(),
            itemCount: _horizontalProperties.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, i) =>
                _HorizontalPropertyCard(data: _horizontalProperties[i]),
          ),
        ),

        const SizedBox(height: 20),

        // ── 2-column grid cards ────────────────────────────────────────
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
              childAspectRatio: 0.85,
            ),
            itemCount: _gridProperties.length,
            itemBuilder: (context, i) =>
                _GridPropertyCard(data: _gridProperties[i]),
          ),
        ),
      ],
    );
  }
}

// ── Horizontal Card ─────────────────────────────────────────────────────────
class _HorizontalPropertyCard extends StatelessWidget {
  final _PropertyData data;
  const _HorizontalPropertyCard({required this.data});

  @override
  Widget build(BuildContext context) {
    const darkTeal = Color(0xFF042F2C);

    return Container(
      width: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Property image (left square)
          ClipRRect(
            borderRadius: const BorderRadius.horizontal(left: Radius.circular(16)),
            child: Image.network(
              data.imageUrl,
              width: 110,
              height: 120,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 110,
                color: const Color(0xFFF3F4F6),
                child: const Icon(Icons.image_outlined, color: Color(0xFF9CA3AF)),
              ),
            ),
          ),
          // Property details (right)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.price,
                        style: GoogleFonts.poppins(
                          color: darkTeal,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        data.title,
                        style: GoogleFonts.poppins(
                          color: darkTeal,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.location_on,
                              color: Color(0xFF9CA3AF), size: 12),
                          const SizedBox(width: 3),
                          Expanded(
                            child: Text(
                              data.location,
                              style: GoogleFonts.poppins(
                                color: const Color(0xFF6B7280),
                                fontSize: 11,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // Agent row
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => const AgentProfileScreen())),
                        child: const CircleAvatar(
                          radius: 14,
                          backgroundImage: NetworkImage(
                            'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=100&auto=format&fit=crop&q=80',
                          ),
                        ),
                      ),
                      if (data.isVerified) ...[
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFFBEF264),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Text(
                                'Agent Verified',
                                style: GoogleFonts.poppins(
                                  color: darkTeal,
                                  fontSize: 7,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(width: 2),
                              const Icon(Icons.check_circle,
                                  color: Color(0xFF042F2C), size: 8),
                            ],
                          ),
                        ),
                      ],
                      const Spacer(),
                      GestureDetector(
                        onTap: () => Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => const ChatDetailScreen())),
                        child: const Icon(Icons.more_horiz,
                            color: Color(0xFF6B7280), size: 20),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Grid Card ───────────────────────────────────────────────────────────────
class _GridPropertyCard extends StatefulWidget {
  final _PropertyData data;
  const _GridPropertyCard({required this.data});

  @override
  State<_GridPropertyCard> createState() => _GridPropertyCardState();
}

class _GridPropertyCardState extends State<_GridPropertyCard> {
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    const darkTeal = Color(0xFF042F2C);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image + heart
          Stack(
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(18)),
                child: Image.network(
                  widget.data.imageUrl,
                  height: 130,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 130,
                    color: const Color(0xFFF3F4F6),
                    child: const Icon(Icons.image_outlined,
                        color: Color(0xFF9CA3AF), size: 32),
                  ),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: GestureDetector(
                  onTap: () => setState(() => _isFavorite = !_isFavorite),
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: const BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    child: Center(
                      child: Icon(
                        _isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: const Color(0xFF84CC16),
                        size: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Details
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 8, 10, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.data.price,
                  style: GoogleFonts.poppins(
                      color: darkTeal,
                      fontWeight: FontWeight.w700,
                      fontSize: 13),
                ),
                Text(
                  widget.data.title,
                  style: GoogleFonts.poppins(
                      color: darkTeal,
                      fontWeight: FontWeight.w600,
                      fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    const Icon(Icons.location_on,
                        color: Color(0xFF9CA3AF), size: 12),
                    const SizedBox(width: 2),
                    Expanded(
                      child: Text(
                        widget.data.location,
                        style: GoogleFonts.poppins(
                            color: const Color(0xFF6B7280), fontSize: 10),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Data model ──────────────────────────────────────────────────────────────
class _PropertyData {
  final String imageUrl;
  final String price;
  final String title;
  final String location;
  final bool isVerified;

  const _PropertyData({
    required this.imageUrl,
    required this.price,
    required this.title,
    required this.location,
    required this.isVerified,
  });
}

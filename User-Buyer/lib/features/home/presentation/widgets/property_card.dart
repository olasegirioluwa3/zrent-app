import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../shared/providers/properties_provider.dart';
import '../../../agent_profile/presentation/screens/agent_profile_screen.dart';
import '../../../messages/presentation/screens/chat_detail_screen.dart';

/// Property Card Widget - ZRent Buyer App
///
/// Implements the grid item matching the Figma mockup:
/// - Rounded card with white background
/// - Image with top-right lime-green heart outline favorite badge
/// - Price and Title in bold dark green/teal
/// - Location row with pin icon
/// - Agent avatar and checkmarked "Agent Verified" badge
/// - Message bubble icon on the right
class PropertyCard extends ConsumerWidget {
  final String id;
  final String imageUrl;
  final String price;
  final String title;
  final String location;
  final String agentAvatarUrl;
  final bool isAgentVerified;
  final bool isFavorite;

  const PropertyCard({
    super.key,
    required this.id,
    required this.imageUrl,
    required this.price,
    required this.title,
    required this.location,
    required this.agentAvatarUrl,
    this.isAgentVerified = false,
    this.isFavorite = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final darkTeal = const Color(0xFF042F2C);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFF3F4F6),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Section with Favorite button
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                child: Image.network(
                  imageUrl,
                  height: 140,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 140,
                      width: double.infinity,
                      color: const Color(0xFFF3F4F6),
                      child: const Icon(
                        Icons.image_outlined,
                        color: Color(0xFF9CA3AF),
                        size: 32,
                      ),
                    );
                  },
                ),
              ),
              // Favorite button (lime green outline inside white circle)
              Positioned(
                top: 10,
                right: 10,
                child: GestureDetector(
                  onTap: () {
                    ref.read(propertiesProvider.notifier).toggleFavorite(id);
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: const Color(0xFFBEF264), // Figma Lime Green (0xFFBEF264 / 0xFF84CC16)
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Content Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Price text
                Text(
                  price,
                  style: GoogleFonts.poppins(
                    color: darkTeal,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 2),
                // Title text
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    color: darkTeal,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                // Location text with grey map pin icon
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: Color(0xFF9CA3AF),
                      size: 14,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        location,
                        style: GoogleFonts.poppins(
                          color: const Color(0xFF6B7280),
                          fontWeight: FontWeight.w400,
                          fontSize: 11,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Agent Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Agent image + verification status
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const AgentProfileScreen(),
                              ),
                            );
                          },
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: const Color(0xFFE5E7EB),
                            backgroundImage: NetworkImage(agentAvatarUrl),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: isAgentVerified
                                ? const Color(0xFFBEF264)
                                : const Color(0xFFFECACA), // Verified = Lime Green, Not Verified = Red
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Text(
                                isAgentVerified ? 'Agent Verified' : 'Not Verified',
                                style: GoogleFonts.poppins(
                                  color: darkTeal,
                                  fontSize: 8,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(width: 2),
                              Icon(
                                isAgentVerified ? Icons.check_circle : Icons.cancel,
                                color: darkTeal,
                                size: 10,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    // Chat Message bubble icon
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ChatDetailScreen(propertyId: id),
                          ),
                        );
                      },
                      child: Icon(
                        Icons.chat_bubble_outline,
                        color: darkTeal,
                        size: 20,
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

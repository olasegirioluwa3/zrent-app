import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../shared/providers/properties_provider.dart';
import 'order_detail_screen.dart';

/// Orders List Screen — ZRent Buyer App
///
/// Matches the Figma design:
/// - Header: "Orders List" (centered, back button).
/// - A vertical list of paid properties.
/// - Each card features:
///   - Green border outline.
///   - "Payment Successful 🎉" indicator.
///   - Property Image, Title, Location.
///   - Agent avatar and "Agent Verified" pill.
///   - Price on the right.
/// - Tapping any card navigates to the Track Order Screen (Order Detail) passing the property ID.
class OrdersListScreen extends ConsumerWidget {
  const OrdersListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final properties = ref.watch(propertiesProvider);
    const darkTeal = Color(0xFF042F2C);
    const greenBorder = Color(0xFF22C55E);

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () {
            // Go back
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Orders List',
          style: GoogleFonts.poppins(
            color: const Color(0xFF1A1A1A),
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          physics: const BouncingScrollPhysics(),
          itemCount: properties.length,
          separatorBuilder: (_, __) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final property = properties[index];

            return GestureDetector(
              onTap: () {
                // Navigate to Track Order (Order Detail) screen with propertyId context
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderDetailScreen(propertyId: property.id),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: greenBorder,
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.02),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Property Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        property.imageUrl,
                        width: 96,
                        height: 76,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 96,
                            height: 76,
                            color: const Color(0xFFF3F4F6),
                            child: const Icon(Icons.image_outlined, color: Color(0xFF9CA3AF), size: 24),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 12),

                    // Property Details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Payment Successful Label
                          Row(
                            children: [
                              const Icon(
                                Icons.check_circle,
                                color: Color(0xFF22C55E),
                                size: 11,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Payment Successful 🎉',
                                style: GoogleFonts.poppins(
                                  color: const Color(0xFF22C55E),
                                  fontSize: 8.5,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),

                          // Title
                          Text(
                            property.title,
                            style: GoogleFonts.poppins(
                              color: const Color(0xFF1A1A1A),
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),

                          // Location
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                color: Color(0xFF9CA3AF),
                                size: 12,
                              ),
                              const SizedBox(width: 3),
                              Expanded(
                                child: Text(
                                  property.location,
                                  style: GoogleFonts.poppins(
                                    color: const Color(0xFF6B7280),
                                    fontSize: 10.5,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),

                          // Agent verified row
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  property.agentAvatarUrl,
                                  width: 20,
                                  height: 20,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const CircleAvatar(
                                      radius: 10,
                                      backgroundColor: Color(0xFFE5E7EB),
                                      child: Icon(Icons.person, size: 10, color: Color(0xFF9CA3AF)),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(width: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
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
                                        fontSize: 7.5,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const SizedBox(width: 2),
                                    const Icon(
                                      Icons.check_circle,
                                      color: darkTeal,
                                      size: 8,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Price info
                    const SizedBox(width: 8),
                    Text(
                      property.price,
                      style: GoogleFonts.poppins(
                        color: darkTeal,
                        fontSize: 13.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

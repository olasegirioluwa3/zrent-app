import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../orders/presentation/screens/orders_list_screen.dart';
import '../../../orders/presentation/screens/order_detail_screen.dart';

/// Orders List Widget - ZRent Buyer App
///
/// Implements the "Orders List" section matching the Figma design screenshot.
/// Features a horizontal scrolling list of order cards representing properties the user has paid for.
class OrdersList extends StatelessWidget {
  const OrdersList({super.key});

  @override
  Widget build(BuildContext context) {
    final darkTeal = const Color(0xFF042F2C);

    // Mock data matching the design screenshot with property IDs
    final List<Map<String, dynamic>> mockOrders = [
      {
        'id': '2',
        'imageUrl': 'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=500&auto=format&fit=crop&q=80',
        'price': '\$280/month',
        'title': 'Urban Loft',
        'location': 'Jakarta, Indonesia',
        'agentAvatarUrl': 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=150&auto=format&fit=crop&q=80',
      },
      {
        'id': '1',
        'imageUrl': 'https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?w=500&auto=format&fit=crop&q=80',
        'price': '₦350/month',
        'title': 'Sky Residence',
        'location': 'Jakarta, Indonesia',
        'agentAvatarUrl': 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=150&h=150&fit=crop&crop=face',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header Section
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Orders List',
                style: GoogleFonts.poppins(
                  color: darkTeal,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              // Dark Teal Rounded "View all" Button
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OrdersListScreen(),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: darkTeal,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'View all',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        // Horizontal scrollable list
        SizedBox(
          height: 128,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: mockOrders.length,
            separatorBuilder: (context, index) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              final order = mockOrders[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderDetailScreen(propertyId: order['id']),
                    ),
                  );
                },
                child: _OrderHorizontalCard(
                  imageUrl: order['imageUrl'],
                  price: order['price'],
                  title: order['title'],
                  location: order['location'],
                  agentAvatarUrl: order['agentAvatarUrl'],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

/// Horizontal card representation of a paid order
class _OrderHorizontalCard extends StatelessWidget {
  final String imageUrl;
  final String price;
  final String title;
  final String location;
  final String agentAvatarUrl;

  const _OrderHorizontalCard({
    required this.imageUrl,
    required this.price,
    required this.title,
    required this.location,
    required this.agentAvatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    final darkTeal = const Color(0xFF042F2C);

    return Container(
      width: 290,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFF3F4F6),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          // Left: Property Image
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              imageUrl,
              width: 110,
              height: 110,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 110,
                  height: 110,
                  color: const Color(0xFFF3F4F6),
                  child: const Icon(
                    Icons.image_outlined,
                    color: Color(0xFF9CA3AF),
                    size: 24,
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 12),
          // Right: Content Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Price text
                Text(
                  price,
                  style: GoogleFonts.poppins(
                    color: darkTeal,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 1),
                // Title text
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    color: darkTeal,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 3),
                // Location row
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: Color(0xFF9CA3AF),
                      size: 13,
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
                const SizedBox(height: 8),
                // Agent verification & Chat row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Agent PFP & Badge
                    Expanded(
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 12,
                            backgroundColor: const Color(0xFFE5E7EB),
                            backgroundImage: NetworkImage(agentAvatarUrl),
                          ),
                          const SizedBox(width: 6),
                          // Agent Verified Badge
                          Flexible(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFBEF264), // Figma Lime Green
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Flexible(
                                    child: Text(
                                      'Agent Verified',
                                      style: GoogleFonts.poppins(
                                        color: darkTeal,
                                        fontSize: 7.5,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const SizedBox(width: 2),
                                  Icon(
                                    Icons.check_circle,
                                    color: darkTeal,
                                    size: 9,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Chat message icon
                    Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: Icon(
                        Icons.chat_bubble_outline,
                        color: darkTeal,
                        size: 16,
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

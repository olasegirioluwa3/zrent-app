import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/chat_header.dart';
import '../widgets/message_bubble.dart';
import '../widgets/chat_input.dart';
import '../../../orders/presentation/screens/orders_list_screen.dart';

/// Chat Detail Screen — ZRent Buyer App
///
/// Implements the Figma message thread UI:
/// - Agent Header with Close (X) button, profile image, name, green online status,
///   a "Pay" button navigating to checkout, and call button.
/// - Chat message bubbles matching the text and layout in the design mockup.
/// - Right-aligned Shared Property message card with green outline border.
/// - Left-aligned ZRent system card with "Confirm you got your Order" button
///   which navigates to the Orders List screen.
/// - Custom chat input composer matching Figma styling.
class ChatDetailScreen extends StatelessWidget {
  final String contactName;
  final String avatarUrl;
  final String? propertyId;

  const ChatDetailScreen({
    super.key,
    this.contactName = 'Bessie Cooper',
    this.avatarUrl = 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=150&h=150&fit=crop&crop=face',
    this.propertyId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Header Section (Passes propertyId down to pay flow)
            ChatHeader(
              contactName: contactName,
              avatarUrl: avatarUrl,
              propertyId: propertyId,
            ),
            // Message Thread
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                physics: const BouncingScrollPhysics(),
                children: [
                  // Today Separator
                  Center(
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 12),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE5E7EB),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Today',
                        style: GoogleFonts.poppins(
                          color: const Color(0xFF6B7280),
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),

                  // Message 1: Shared Property Message Card (Sent by user, right aligned)
                  const Align(
                    alignment: Alignment.centerRight,
                    child: _SharedPropertyMessageCard(
                      imageUrl: 'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=500&auto=format&fit=crop&q=80',
                      price: '₦2800/month',
                      title: 'Urban Loft',
                      location: 'Jakarta, Indonesia',
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Message 2 & 3: Sent by User
                  const MessageBubble(
                    message: 'Hello! Good morning 👋',
                    isSent: true,
                    time: '', // Blank time as it flows into next message
                  ),
                  const SizedBox(height: 4),
                  const MessageBubble(
                    message: 'I\'m interested in this house. Can i get more information about it',
                    isSent: true,
                    time: '09:15 AM',
                  ),
                  const SizedBox(height: 12),

                  // Message 4: Received from Agent
                  const MessageBubble(
                    message: 'Good morning Saifi, Yes you can 👋',
                    isSent: false,
                    time: '09:15 AM',
                  ),
                  const SizedBox(height: 12),

                  // Message 5: Sent by User
                  const MessageBubble(
                    message: 'Can i go to the house and check',
                    isSent: true,
                    time: '09:18 AM',
                  ),
                  const SizedBox(height: 12),

                  // Message 6: Received from Agent
                  const MessageBubble(
                    message: 'Of course, the door is open',
                    isSent: false,
                    time: '09:16 AM',
                  ),
                  const SizedBox(height: 12),

                  // Message 7: Sent by User
                  const MessageBubble(
                    message: 'I really like it',
                    isSent: true,
                    time: '09:18 AM',
                  ),
                  const SizedBox(height: 16),

                  // Message 8: ZRent Order Confirmation Card (Left aligned system card)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: _OrderConfirmationMessageCard(
                      imageUrl: 'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=500&auto=format&fit=crop&q=80',
                      price: '\$280/month',
                      title: 'Urban Loft',
                      location: 'Jakarta, Indonesia',
                      onConfirmTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const OrdersListScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            // Input Bar composer
            const ChatInput(),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}

/// Shared Property Message Card Widget (Right aligned, Green Outline)
class _SharedPropertyMessageCard extends StatelessWidget {
  final String imageUrl;
  final String price;
  final String title;
  final String location;

  const _SharedPropertyMessageCard({
    required this.imageUrl,
    required this.price,
    required this.title,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    final darkTeal = const Color(0xFF042F2C);
    final width = MediaQuery.of(context).size.width * 0.76;

    return Container(
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFBEF264), // Figma Lime Green border
          width: 1.8,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              imageUrl,
              width: 90,
              height: 76,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 90,
                  height: 76,
                  color: const Color(0xFFF3F4F6),
                  child: const Icon(Icons.image_outlined, color: Color(0xFF9CA3AF), size: 20),
                );
              },
            ),
          ),
          const SizedBox(width: 12),
          // Property Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  price,
                  style: GoogleFonts.poppins(
                    color: darkTeal,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 1),
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    color: darkTeal,
                    fontWeight: FontWeight.w600,
                    fontSize: 12.5,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
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
                        location,
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Order Confirmation Message Card Widget (Left aligned system card)
class _OrderConfirmationMessageCard extends StatelessWidget {
  final String imageUrl;
  final String price;
  final String title;
  final String location;
  final VoidCallback onConfirmTap;

  const _OrderConfirmationMessageCard({
    required this.imageUrl,
    required this.price,
    required this.title,
    required this.location,
    required this.onConfirmTap,
  });

  @override
  Widget build(BuildContext context) {
    final darkTeal = const Color(0xFF042F2C);
    final width = MediaQuery.of(context).size.width * 0.78;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: const Color(0xFFF3F4F6),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Property details row
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      imageUrl,
                      width: 95,
                      height: 76,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 95,
                          height: 76,
                          color: const Color(0xFFF3F4F6),
                          child: const Icon(Icons.image_outlined, color: Color(0xFF9CA3AF), size: 20),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          price,
                          style: GoogleFonts.poppins(
                            color: darkTeal,
                            fontWeight: FontWeight.w700,
                            fontSize: 13.5,
                          ),
                        ),
                        const SizedBox(height: 1),
                        Text(
                          title,
                          style: GoogleFonts.poppins(
                            color: darkTeal,
                            fontWeight: FontWeight.w600,
                            fontSize: 12.5,
                          ),
                        ),
                        const SizedBox(height: 2),
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
                                location,
                                style: GoogleFonts.poppins(
                                  color: const Color(0xFF6B7280),
                                  fontSize: 11,
                                  fontWeight: FontWeight.w400,
                                ),
                                maxLines: 1,
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
              const SizedBox(height: 10),
              // Confirm order action button
              GestureDetector(
                onTap: onConfirmTap,
                child: Container(
                  width: double.infinity,
                  height: 38,
                  decoration: BoxDecoration(
                    color: darkTeal,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Confirm you got your Order',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 11.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        // Subtitle message from ZRent
        Text(
          'This message is from Zrent',
          style: GoogleFonts.poppins(
            color: const Color(0xFF9CA3AF),
            fontSize: 10.5,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

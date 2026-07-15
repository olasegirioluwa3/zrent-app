import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../checkout/presentation/screens/checkout_screen.dart';

/// Chat Header Widget — ZRent Buyer App
///
/// Matches the Figma design:
/// - Close button (X) on the far left
/// - Agent profile avatar
/// - Agent name & online indicator
/// - "Pay" button in dark teal color navigating to Checkout with propertyId
/// - Call icon button on the right
class ChatHeader extends StatelessWidget {
  final String contactName;
  final String avatarUrl;
  final String? propertyId;

  const ChatHeader({
    super.key,
    required this.contactName,
    required this.avatarUrl,
    this.propertyId,
  });

  @override
  Widget build(BuildContext context) {
    const darkTeal = Color(0xFF042F2C);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Color(0xFFF3F4F6), width: 1),
        ),
      ),
      child: Row(
        children: [
          // ── Close button (X) ───────────────────────────────────────────
          GestureDetector(
            onTap: () => Navigator.pop(context),
            behavior: HitTestBehavior.opaque,
            child: Container(
              width: 36,
              height: 36,
              alignment: Alignment.center,
              child: const Icon(
                Icons.close,
                color: Colors.black87,
                size: 24,
              ),
            ),
          ),
          const SizedBox(width: 8),

          // ── Agent avatar ───────────────────────────────────────────────
          CircleAvatar(
            radius: 20,
            backgroundColor: const Color(0xFFE5E7EB),
            backgroundImage: NetworkImage(avatarUrl),
            onBackgroundImageError: (_, __) {},
          ),
          const SizedBox(width: 12),

          // ── Name & status ──────────────────────────────────────────────
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  contactName,
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF1A1A1A),
                    fontSize: 14.5,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 1),
                Text(
                  'online',
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF22C55E),
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),

          // ── "Pay" button ───────────────────────────────────────────────
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CheckoutScreen(propertyId: propertyId),
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
                'Pay',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),

          // ── Call button ────────────────────────────────────────────────
          GestureDetector(
            onTap: () {
              // Phone call action
            },
            child: const Icon(
              Icons.phone_outlined,
              color: Colors.black87,
              size: 24,
            ),
          ),
          const SizedBox(width: 4),
        ],
      ),
    );
  }
}

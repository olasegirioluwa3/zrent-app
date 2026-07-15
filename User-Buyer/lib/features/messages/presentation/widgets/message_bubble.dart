import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Message Bubble Widget — ZRent Buyer App
///
/// Chat message bubble with sent/received styling.
class MessageBubble extends StatelessWidget {
  final String message;
  final bool isSent;
  final String time;

  const MessageBubble({
    super.key,
    required this.message,
    required this.isSent,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    const darkTeal = Color(0xFF042F2C);
    const bubbleSent = Color(0xFF042F2C);
    const bubbleReceived = Colors.white;

    return Align(
      alignment: isSent ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment:
            isSent ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.75,
            ),
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isSent ? bubbleSent : bubbleReceived,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(18),
                topRight: const Radius.circular(18),
                bottomLeft:
                    isSent ? const Radius.circular(18) : const Radius.circular(4),
                bottomRight:
                    isSent ? const Radius.circular(4) : const Radius.circular(18),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              message,
              style: GoogleFonts.poppins(
                color: isSent ? Colors.white : darkTeal,
                fontSize: 13.5,
                fontWeight: FontWeight.w400,
                height: 1.45,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            time,
            style: GoogleFonts.poppins(
              color: const Color(0xFF9CA3AF),
              fontSize: 10.5,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

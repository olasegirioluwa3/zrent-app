import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Chat Input Widget — ZRent Buyer App
///
/// Message composer bar with attachment button, text field, and send button.
class ChatInput extends StatefulWidget {
  const ChatInput({super.key});

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  final _ctrl = TextEditingController();

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const darkTeal = Color(0xFF042F2C);

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Color(0xFFF3F4F6), width: 1),
        ),
      ),
      child: Row(
        children: [
          // ── Attachment button ──────────────────────────────────────────
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.attach_file_rounded,
              color: Color(0xFF6B7280),
              size: 20,
            ),
          ),
          const SizedBox(width: 10),

          // ── Text input ─────────────────────────────────────────────────
          Expanded(
            child: Container(
              height: 44,
              decoration: BoxDecoration(
                color: const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(14),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: TextField(
                controller: _ctrl,
                textAlignVertical: TextAlignVertical.center,
                style: GoogleFonts.poppins(
                  color: const Color(0xFF1A1A1A),
                  fontSize: 13.5,
                  fontWeight: FontWeight.w400,
                ),
                decoration: InputDecoration(
                  hintText: 'Type a message...',
                  hintStyle: GoogleFonts.poppins(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 13.5,
                    fontWeight: FontWeight.w400,
                  ),
                  border: InputBorder.none,
                  isCollapsed: true,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),

          // ── Send button ────────────────────────────────────────────────
          GestureDetector(
            onTap: () {
              if (_ctrl.text.trim().isEmpty) return;
              setState(() => _ctrl.clear());
            },
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: darkTeal,
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(
                Icons.send_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

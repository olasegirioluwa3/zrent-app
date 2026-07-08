import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Discover Search Bar - matches the Figma search row exactly:
/// - Left search icon (grey)
/// - Center: "Ikeja, Lagos, Nigeria" placeholder text
/// - Right: round search icon button
class DiscoverSearchBar extends StatefulWidget {
  const DiscoverSearchBar({super.key});

  @override
  State<DiscoverSearchBar> createState() => _DiscoverSearchBarState();
}

class _DiscoverSearchBarState extends State<DiscoverSearchBar> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Container(
        height: 54,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            const SizedBox(width: 16),
            // Left search icon
            const Icon(Icons.search, color: Color(0xFF6B7280), size: 22),
            const SizedBox(width: 10),
            // Text input
            Expanded(
              child: TextField(
                controller: _controller,
                textInputAction: TextInputAction.search,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: const Color(0xFF1F2937),
                  fontWeight: FontWeight.w400,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  hintText: 'Ikeja, Lagos, Nigeria',
                  hintStyle: GoogleFonts.poppins(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            // Right search icon button (rounded)
            Container(
              width: 38,
              height: 38,
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.search,
                color: Color(0xFF042F2C),
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

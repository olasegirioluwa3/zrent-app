import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../search/presentation/screens/search_results_screen.dart';

/// Search Bar Widget — sits inside the white floating card on the HomeHeader.
///
/// - TextField accepts user input
/// - Tapping the lime-green button OR pressing keyboard "Search" navigates to
///   SearchResultsScreen with the typed query
class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final TextEditingController _controller = TextEditingController();

  void _doSearch() {
    final query = _controller.text.trim();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => SearchResultsScreen(searchQuery: query),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          // ── Search input field ────────────────────────────────────────
          Expanded(
            child: Container(
              height: 52,
              decoration: BoxDecoration(
                color: const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 14),
                  Transform.rotate(
                    angle: -0.5,
                    child: const Icon(
                      Icons.navigation_outlined,
                      color: Color(0xFF9CA3AF),
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      textInputAction: TextInputAction.search,
                      onSubmitted: (_) => _doSearch(),
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: const Color(0xFF1F2937),
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        hintText: 'Search properties location',
                        hintStyle: GoogleFonts.poppins(
                          color: const Color(0xFF9CA3AF),
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          // ── Lime-green search button ──────────────────────────────────
          GestureDetector(
            onTap: _doSearch,
            child: Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: const Color(0xFFBEF264),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Center(
                child: Icon(
                  Icons.search,
                  color: Color(0xFF042F2C),
                  size: 24,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

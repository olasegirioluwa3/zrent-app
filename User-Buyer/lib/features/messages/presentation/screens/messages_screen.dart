import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../home/presentation/widgets/bottom_nav_bar.dart';
import 'chat_detail_screen.dart';

// ── Data Model ──────────────────────────────────────────────────────────────

class _Contact {
  final String name;
  final String avatarUrl;
  final String lastMessage;
  final String time;
  final int unreadCount;

  const _Contact({
    required this.name,
    required this.avatarUrl,
    required this.lastMessage,
    required this.time,
    this.unreadCount = 0,
  });
}

// ── Static Data ─────────────────────────────────────────────────────────────

const _kContacts = [
  _Contact(
    name: 'Anderson',
    avatarUrl:
        'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop&crop=face',
    lastMessage: "Great! I'll schedule a viewing for tomorrow...",
    time: '10:24 AM',
    unreadCount: 2,
  ),
  _Contact(
    name: 'Sarah Miller',
    avatarUrl:
        'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=150&h=150&fit=crop&crop=face',
    lastMessage: 'Thank you for your interest in Wings Tower',
    time: 'Yesterday',
  ),
  _Contact(
    name: 'David Chen',
    avatarUrl:
        'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=150&h=150&fit=crop&crop=face',
    lastMessage: 'The property documents are ready for revi...',
    time: 'Yesterday',
    unreadCount: 1,
  ),
  _Contact(
    name: 'Emma Johnson',
    avatarUrl:
        'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=150&h=150&fit=crop&crop=face',
    lastMessage: 'Would you like to see the apartment this weeke...',
    time: '2 days ago',
  ),
  _Contact(
    name: 'James Wilson',
    avatarUrl:
        'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150&h=150&fit=crop&crop=face',
    lastMessage: 'I have some great options that match your criteria',
    time: '1 week ago',
  ),
  _Contact(
    name: 'Lisa Martinez',
    avatarUrl:
        'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=150&h=150&fit=crop&crop=face',
    lastMessage: 'The virtual tour link is now available',
    time: '1 week ago',
  ),
];

// ── Screen ───────────────────────────────────────────────────────────────────

/// Messages Screen — ZRent Buyer App
///
/// Pixel-perfect match to the Figma design:
///   • "Messages" heading (bold, dark teal)
///   • Rounded search bar with centred placeholder text
///   • Scrollable contact list (avatar · name · last msg · time · unread badge)
///   • Persistent BottomNavBar with Messages (index 3) active
class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final _searchCtrl = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  List<_Contact> get _filtered {
    if (_query.isEmpty) return _kContacts;
    final q = _query.toLowerCase();
    return _kContacts
        .where((c) =>
            c.name.toLowerCase().contains(q) ||
            c.lastMessage.toLowerCase().contains(q))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // Figma page bg (light grey)
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── "Messages" heading ───────────────────────────────────────
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Text(
                'Messages',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF1A1A1A),
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.3,
                ),
              ),
            ),

            // ── Search bar ───────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                height: 52,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFFE5E7EB),
                    width: 1,
                  ),
                ),
                child: TextField(
                  controller: _searchCtrl,
                  onChanged: (v) => setState(() => _query = v),
                  textAlignVertical: TextAlignVertical.center,
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF1A1A1A),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Search messages',
                    filled: true,
                    fillColor: Colors.white,
                    hintStyle: GoogleFonts.poppins(
                      color: const Color(0xFFB0B0B0),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    border: InputBorder.none,
                    isCollapsed: true,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 16),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // ── Contact list ─────────────────────────────────────────────
            Expanded(
              child: _filtered.isEmpty
                  ? _buildEmpty()
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      itemCount: _filtered.length,
                      itemBuilder: (context, i) =>
                          _ContactTile(contact: _filtered[i]),
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(initialIndex: 3),
    );
  }

  Widget _buildEmpty() => Center(
        child: Text(
          'No messages found',
          style: GoogleFonts.poppins(
            color: const Color(0xFF9CA3AF),
            fontSize: 14,
          ),
        ),
      );
}

// ── Contact Tile ─────────────────────────────────────────────────────────────

class _ContactTile extends StatelessWidget {
  final _Contact contact;

  const _ContactTile({required this.contact});

  @override
  Widget build(BuildContext context) {
    final bool hasUnread = contact.unreadCount > 0;

    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ChatDetailScreen(
            contactName: contact.name,
            avatarUrl: contact.avatarUrl,
          ),
        ),
      ),
      child: Container(
        color: Colors.white,
        padding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ── Avatar ─────────────────────────────────────────────────
            CircleAvatar(
              radius: 28,
              backgroundColor: const Color(0xFFE5E7EB),
              backgroundImage: NetworkImage(contact.avatarUrl),
              onBackgroundImageError: (_, __) {},
            ),

            const SizedBox(width: 14),

            // ── Text column ────────────────────────────────────────────
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name & timestamp row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        contact.name,
                        style: GoogleFonts.poppins(
                          color: const Color(0xFF1A1A1A),
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        contact.time,
                        style: GoogleFonts.poppins(
                          color: const Color(0xFFB0B0B0),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  // Last message & badge row
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          contact.lastMessage,
                          style: GoogleFonts.poppins(
                            color: const Color(0xFF7A7A7A),
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (hasUnread) ...[
                        const SizedBox(width: 8),
                        Container(
                          width: 22,
                          height: 22,
                          decoration: const BoxDecoration(
                            color: Color(0xFF042F2C), // Dark teal badge
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            contact.unreadCount.toString(),
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

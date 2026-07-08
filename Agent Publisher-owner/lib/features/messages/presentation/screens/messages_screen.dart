import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_theme.dart';

/// Messages Screen
///
/// Figma: https://www.figma.com/design/MwxOsKuN9q6b815CH3IcLJ/Untitled?node-id=304-764
/// Screen ID: 199:1224
class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  final List<_ConversationItem> _conversations = [
    _ConversationItem(
      name: 'Sarah Miller',
      lastMessage: 'Thank you for your interest in Wings Tower',
      time: 'Today',
      unreadCount: 0,
      avatarInitials: 'SM',
      avatarColor: Color(0xFF6366F1),
    ),
    _ConversationItem(
      name: 'David Chen',
      lastMessage: 'The property documents are ready for revi...',
      time: 'Yesterday',
      unreadCount: 1,
      avatarInitials: 'DC',
      avatarColor: Color(0xFF0EA5E9),
    ),
    _ConversationItem(
      name: 'Aisha Bello',
      lastMessage: 'Can we schedule a viewing this weekend?',
      time: 'Mon',
      unreadCount: 3,
      avatarInitials: 'AB',
      avatarColor: Color(0xFFF59E0B),
    ),
    _ConversationItem(
      name: 'James Okafor',
      lastMessage: 'I sent the signed agreement. Please confirm.',
      time: 'Sun',
      unreadCount: 0,
      avatarInitials: 'JO',
      avatarColor: Color(0xFF10B981),
    ),
  ];

  List<_ConversationItem> get _filtered {
    if (_searchQuery.isEmpty) return _conversations;
    return _conversations
        .where((c) =>
            c.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            c.lastMessage.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Large title ──────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 12),
              child: const Text(
                'Messages',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.secondary,
                  letterSpacing: -0.8,
                ),
              ),
            ),

            // ── Search bar ───────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: (v) => setState(() => _searchQuery = v),
                  style: const TextStyle(
                    fontSize: 15,
                    color: AppTheme.secondary,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Search messages',
                    hintStyle: TextStyle(
                      color: AppTheme.textTertiary,
                      fontSize: 15,
                    ),
                    prefixIcon: Icon(
                      LucideIcons.search,
                      color: AppTheme.textTertiary,
                      size: 18,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 8),

            // ── Conversation list ────────────────────────────────
            Expanded(
              child: _filtered.isEmpty
                  ? _buildEmpty()
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      itemCount: _filtered.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 0),
                      itemBuilder: (context, index) {
                        final item = _filtered[index];
                        return _ConversationTile(
                          item: item,
                          onTap: () => context.push(RouteNames.openChat),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(LucideIcons.messageSquare,
              size: 56, color: AppTheme.textTertiary),
          const SizedBox(height: 16),
          const Text(
            'No conversations yet',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Data model ───────────────────────────────────────────────────────────────
class _ConversationItem {
  final String name;
  final String lastMessage;
  final String time;
  final int unreadCount;
  final String avatarInitials;
  final Color avatarColor;

  const _ConversationItem({
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.unreadCount,
    required this.avatarInitials,
    required this.avatarColor,
  });
}

// ── Conversation tile ─────────────────────────────────────────────────────────
class _ConversationTile extends StatelessWidget {
  final _ConversationItem item;
  final VoidCallback onTap;

  const _ConversationTile({required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Avatar
              CircleAvatar(
                radius: 28,
                backgroundColor: item.avatarColor.withOpacity(0.18),
                child: Text(
                  item.avatarInitials,
                  style: TextStyle(
                    color: item.avatarColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(width: 14),

              // Name + message
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          item.name,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: item.unreadCount > 0
                                ? FontWeight.bold
                                : FontWeight.w600,
                            color: AppTheme.secondary,
                          ),
                        ),
                        Text(
                          item.time,
                          style: TextStyle(
                            fontSize: 12,
                            color: item.unreadCount > 0
                                ? AppTheme.textSecondary
                                : AppTheme.textTertiary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            item.lastMessage,
                            style: TextStyle(
                              fontSize: 13,
                              color: item.unreadCount > 0
                                  ? AppTheme.textPrimary
                                  : AppTheme.textSecondary,
                              fontWeight: item.unreadCount > 0
                                  ? FontWeight.w500
                                  : FontWeight.normal,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (item.unreadCount > 0) ...[
                          const SizedBox(width: 8),
                          Container(
                            width: 22,
                            height: 22,
                            decoration: const BoxDecoration(
                              color: AppTheme.secondary,
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              item.unreadCount.toString(),
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
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
      ),
    );
  }
}

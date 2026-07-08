import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../core/theme/app_theme.dart';

/// Open Chat Screen
///
/// Figma: https://www.figma.com/design/MwxOsKuN9q6b815CH3IcLJ/Untitled?node-id=304-841
/// Screen ID: 199:1140
///
/// Rules:
/// - Block: Phone Numbers
/// - Block: Email Addresses
/// - Block: WhatsApp Links
/// - Block: Telegram Links
class OpenChatScreen extends StatefulWidget {
  const OpenChatScreen({super.key});

  @override
  State<OpenChatScreen> createState() => _OpenChatScreenState();
}

class _OpenChatScreenState extends State<OpenChatScreen> {
  final _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<ChatMessage> _messages = [
    ChatMessage(
      text: 'Hello! Good morning 👋',
      isFromMe: false,
      time: 'MA 31:60',
    ),
    ChatMessage(
      text: "I'm interested in this house. Can i get more information about it",
      isFromMe: false,
      time: 'MA 31:60',
    ),
    ChatMessage(
      text: 'Good morning Saifi, Yes you can 👋',
      isFromMe: true,
      time: '09:15 AM',
    ),
    ChatMessage(
      text: 'Can i go to the house and check',
      isFromMe: false,
      time: '09:18 AM',
    ),
    ChatMessage(
      text: 'Of course, the door is open',
      isFromMe: true,
      time: '09:16 AM',
    ),
    ChatMessage(
      text: 'I really like it',
      isFromMe: false,
      time: '09:18 AM',
    ),
  ];

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // ── Blocked content guard ─────────────────────────────────────────────────
  bool _containsBlockedContent(String text) {
    if (RegExp(r'\+?\d{10,}').hasMatch(text)) return true;
    if (RegExp(r'[\w\.-]+@[\w\.-]+\.\w+').hasMatch(text)) return true;
    final lower = text.toLowerCase();
    if (lower.contains('wa.me') || lower.contains('whatsapp')) return true;
    if (lower.contains('t.me') || lower.contains('telegram')) return true;
    return false;
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    if (_containsBlockedContent(text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text('Sharing phone numbers, emails, or external links is not allowed'),
          backgroundColor: AppTheme.error,
        ),
      );
      return;
    }

    setState(() {
      _messages.add(ChatMessage(
        text: text,
        isFromMe: true,
        time: _getCurrentTime(),
      ));
      _messageController.clear();
    });

    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  String _getCurrentTime() {
    final now = DateTime.now();
    final hour = now.hour % 12 == 0 ? 12 : now.hour % 12;
    final minute = now.minute.toString().padLeft(2, '0');
    final period = now.hour < 12 ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  // ── Build ─────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      appBar: _buildAppBar(context),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              children: [
                // ── Date chip ──────────────────────────────────
                _buildDateChip('Today'),
                const SizedBox(height: 12),

                // ── Property card ──────────────────────────────
                _buildPropertyCard(),
                const SizedBox(height: 16),

                // ── Messages ───────────────────────────────────
                ..._messages.map(_buildMessageBubble),
                const SizedBox(height: 8),
              ],
            ),
          ),

          // ── Input bar ─────────────────────────────────────────
          _buildInputBar(),
        ],
      ),
    );
  }

  // ── AppBar ────────────────────────────────────────────────────────────────
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppTheme.background,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: IconButton(
        icon: const Icon(LucideIcons.x, color: AppTheme.secondary, size: 22),
        onPressed: () => context.pop(),
      ),
      titleSpacing: 0,
      title: Row(
        children: [
          // Avatar
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppTheme.borderLight, width: 2),
              color: const Color(0xFF0EA5E9).withOpacity(0.15),
            ),
            alignment: Alignment.center,
            child: const Text(
              'DC',
              style: TextStyle(
                color: Color(0xFF0EA5E9),
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text(
                'Anderson',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.secondary,
                  letterSpacing: -0.3,
                ),
              ),
              SizedBox(height: 2),
              Text(
                'online',
                style: TextStyle(
                  fontSize: 12,
                  color: AppTheme.success,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: GestureDetector(
            onTap: () {
              // TODO: Implement call
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppTheme.border, width: 1.5),
              ),
              child: const Icon(
                LucideIcons.phone,
                color: AppTheme.secondary,
                size: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ── Date chip ─────────────────────────────────────────────────────────────
  Widget _buildDateChip(String label) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: AppTheme.border.withOpacity(0.8),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: AppTheme.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  // ── Property listing card ─────────────────────────────────────────────────
  Widget _buildPropertyCard() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        width: 240,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppTheme.primary, width: 2),
        ),
        clipBehavior: Clip.hardEdge,
        child: Row(
          children: [
            // Property image placeholder
            Container(
              width: 80,
              height: 72,
              color: const Color(0xFF94A3B8),
              child: const Icon(
                LucideIcons.building2,
                color: Colors.white54,
                size: 28,
              ),
            ),
            // Info
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      '₦2800/month',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.secondary,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Urban Loft',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.secondary,
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(LucideIcons.mapPin,
                            size: 10, color: AppTheme.textSecondary),
                        SizedBox(width: 3),
                        Text(
                          'Jakarta, Indonesia',
                          style: TextStyle(
                            fontSize: 10,
                            color: AppTheme.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Message bubble ────────────────────────────────────────────────────────
  Widget _buildMessageBubble(ChatMessage message) {
    final isMe = message.isFromMe;
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Align(
            alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.72,
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isMe ? AppTheme.secondary : Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(18),
                  topRight: const Radius.circular(18),
                  bottomLeft: Radius.circular(isMe ? 18 : 4),
                  bottomRight: Radius.circular(isMe ? 4 : 18),
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
                message.text,
                style: TextStyle(
                  fontSize: 14,
                  color: isMe ? Colors.white : AppTheme.textPrimary,
                  height: 1.4,
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              message.time,
              style: const TextStyle(
                fontSize: 11,
                color: AppTheme.textTertiary,
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  // ── Input bar ─────────────────────────────────────────────────────────────
  Widget _buildInputBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            // Attach icon
            GestureDetector(
              onTap: () {
                // TODO: Attach file
              },
              child: const Icon(
                LucideIcons.paperclip,
                color: AppTheme.textTertiary,
                size: 22,
              ),
            ),
            const SizedBox(width: 12),

            // Text field
            Expanded(
              child: Container(
                height: 46,
                decoration: BoxDecoration(
                  color: const Color(0xFFF2F2F7),
                  borderRadius: BorderRadius.circular(24),
                ),
                alignment: Alignment.center,
                child: TextField(
                  controller: _messageController,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppTheme.secondary,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Type a message...',
                    hintStyle: TextStyle(
                      fontSize: 14,
                      color: AppTheme.textTertiary,
                    ),
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  onSubmitted: (_) => _sendMessage(),
                ),
              ),
            ),
            const SizedBox(width: 10),

            // Send button
            GestureDetector(
              onTap: _sendMessage,
              child: Container(
                width: 46,
                height: 46,
                decoration: const BoxDecoration(
                  color: AppTheme.secondary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  LucideIcons.sendHorizonal,
                  color: AppTheme.primary,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Data model ────────────────────────────────────────────────────────────────
class ChatMessage {
  final String text;
  final bool isFromMe;
  final String time;

  ChatMessage({
    required this.text,
    required this.isFromMe,
    required this.time,
  });
}

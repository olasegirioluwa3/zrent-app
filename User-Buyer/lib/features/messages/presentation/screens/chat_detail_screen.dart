import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../widgets/chat_header.dart';
import '../widgets/message_bubble.dart';
import '../widgets/chat_input.dart';

/// Chat Detail Screen - ZRent Buyer App
/// 
/// Individual conversation with agent
class ChatDetailScreen extends StatelessWidget {
  const ChatDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            const ChatHeader(),
            // Messages
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                children: const [
                  MessageBubble(
                    message: 'Hello! I\'m interested in the property at Lekki Phase 1. Is it still available?',
                    isSent: false,
                    time: '10:30 AM',
                  ),
                  SizedBox(height: 12),
                  MessageBubble(
                    message: 'Yes, it\'s still available! Would you like to schedule a viewing?',
                    isSent: true,
                    time: '10:32 AM',
                  ),
                  SizedBox(height: 12),
                  MessageBubble(
                    message: 'That would be great. What times work for you?',
                    isSent: false,
                    time: '10:35 AM',
                  ),
                  SizedBox(height: 12),
                  MessageBubble(
                    message: 'I\'m available this Saturday between 10 AM and 2 PM. Does that work for you?',
                    isSent: true,
                    time: '10:38 AM',
                  ),
                  SizedBox(height: 12),
                  MessageBubble(
                    message: 'Perfect! Let\'s do 11 AM then.',
                    isSent: false,
                    time: '10:40 AM',
                  ),
                ],
              ),
            ),
            // Chat Input
            const ChatInput(),
          ],
        ),
      ),
    );
  }
}

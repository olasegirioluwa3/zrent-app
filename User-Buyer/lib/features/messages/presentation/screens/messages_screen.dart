import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../widgets/messages_header.dart';
import '../widgets/message_list_item.dart';

/// Messages Screen - ZRent Buyer App
/// 
/// List of conversations with agents
class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            const MessagesHeader(),
            const SizedBox(height: 16),
            // Message List
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: const [
                  MessageListItem(
                    agentName: 'John Doe',
                    agentAvatar: 'https://i.pravatar.cc/150?img=1',
                    lastMessage: 'Is the property still available?',
                    time: '2m ago',
                    unreadCount: 2,
                    propertyImage: 'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?w=100',
                  ),
                  SizedBox(height: 16),
                  MessageListItem(
                    agentName: 'Sarah Johnson',
                    agentAvatar: 'https://i.pravatar.cc/150?img=5',
                    lastMessage: 'Thank you for the quick response!',
                    time: '1h ago',
                    unreadCount: 0,
                    propertyImage: 'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=100',
                  ),
                  SizedBox(height: 16),
                  MessageListItem(
                    agentName: 'Michael Brown',
                    agentAvatar: 'https://i.pravatar.cc/150?img=3',
                    lastMessage: 'Can we schedule a viewing?',
                    time: '3h ago',
                    unreadCount: 1,
                    propertyImage: 'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=100',
                  ),
                  SizedBox(height: 16),
                  MessageListItem(
                    agentName: 'Emily Davis',
                    agentAvatar: 'https://i.pravatar.cc/150?img=9',
                    lastMessage: 'The price is negotiable',
                    time: '1d ago',
                    unreadCount: 0,
                    propertyImage: 'https://images.unsplash.com/photo-1567496898669-ee935f5f647a?w=100',
                  ),
                  SizedBox(height: 16),
                  MessageListItem(
                    agentName: 'David Wilson',
                    agentAvatar: 'https://i.pravatar.cc/150?img=8',
                    lastMessage: 'I\'ll send you the documents',
                    time: '2d ago',
                    unreadCount: 0,
                    propertyImage: 'https://images.unsplash.com/photo-1555854877-bab0e564b8d5?w=100',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 100), // Space for bottom nav
          ],
        ),
      ),
    );
  }
}

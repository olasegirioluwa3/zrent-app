import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../widgets/agent_profile_header.dart';
import '../widgets/agent_info_card.dart';
import '../widgets/agent_stats.dart';
import '../widgets/agent_listings.dart';
import '../widgets/reviews_section.dart';
import '../widgets/contact_actions.dart';

/// Agent Profile Screen - ZRent Buyer App
///
/// Shows agent information with:
/// - Profile header (displays agent name)
/// - Agent info card (avatar + name)
/// - Stats (listings, rating, response time)
/// - Property listings
/// - Reviews
/// - Contact actions
class AgentProfileScreen extends StatelessWidget {
  final String agentName;
  final String avatarUrl;

  const AgentProfileScreen({
    super.key,
    required this.agentName,
    required this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header — shows agent name as title
            AgentProfileHeader(agentName: agentName),
            // Content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    AgentInfoCard(agentName: agentName, avatarUrl: avatarUrl),
                    const SizedBox(height: 24),
                    const AgentStats(),
                    const SizedBox(height: 24),
                    const AgentListings(),
                    const SizedBox(height: 24),
                    const ReviewsSection(),
                    const SizedBox(height: 100), // Space for bottom actions
                  ],
                ),
              ),
            ),
            // Contact Actions
            const ContactActions(),
          ],
        ),
      ),
    );
  }
}

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
/// - Profile header
/// - Agent info card
/// - Stats (listings, rating, response time)
/// - Property listings
/// - Reviews
/// - Contact actions
class AgentProfileScreen extends StatelessWidget {
  const AgentProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            const AgentProfileHeader(),
            // Content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    SizedBox(height: 24),
                    AgentInfoCard(),
                    SizedBox(height: 24),
                    AgentStats(),
                    SizedBox(height: 24),
                    AgentListings(),
                    SizedBox(height: 24),
                    ReviewsSection(),
                    SizedBox(height: 100), // Space for bottom actions
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

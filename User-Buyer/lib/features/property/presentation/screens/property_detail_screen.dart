import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../widgets/property_image_gallery.dart';
import '../widgets/property_info_header.dart';
import '../widgets/property_details.dart';
import '../widgets/property_amenities.dart';
import '../widgets/agent_card.dart';
import '../widgets/bottom_action_bar.dart';

/// Property Detail Screen - ZRent Buyer App
/// 
/// Detailed property view with:
/// - Image gallery
/// - Property information
/// - Amenities
/// - Agent info
/// - Book/offer actions
class PropertyDetailScreen extends StatelessWidget {
  final String propertyId;

  const PropertyDetailScreen({super.key, required this.propertyId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Main Content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    PropertyImageGallery(),
                    SizedBox(height: 24),
                    PropertyInfoHeader(),
                    SizedBox(height: 24),
                    PropertyDetails(),
                    SizedBox(height: 24),
                    PropertyAmenities(),
                    SizedBox(height: 24),
                    AgentCard(),
                    SizedBox(height: 100), // Space for bottom action bar
                  ],
                ),
              ),
            ),
            // Bottom Action Bar
            const BottomActionBar(),
          ],
        ),
      ),
    );
  }
}

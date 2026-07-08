import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

/// Agent Listings Widget
/// 
/// Shows agent's property listings
class AgentListings extends StatelessWidget {
  const AgentListings({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Agent Listings',
                style: AppTypography.h4.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                'View All',
                style: AppTypography.labelMedium.copyWith(
                  color: AppColors.primary,
                  fontWeight: AppTypography.semiBold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: const [
              _ListingCard(
                imageUrl: 'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?w=300',
                title: 'Luxury Apartment',
                location: 'Victoria Island',
                price: '₦850,000',
              ),
              SizedBox(width: 16),
              _ListingCard(
                imageUrl: 'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=300',
                title: 'Modern Studio',
                location: 'Lekki Phase 1',
                price: '₦350,000',
              ),
              SizedBox(width: 16),
              _ListingCard(
                imageUrl: 'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=300',
                title: 'Penthouse Suite',
                location: 'Ikoyi',
                price: '₦1,200,000',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ListingCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String location;
  final String price;

  const _ListingCard({
    required this.imageUrl,
    required this.title,
    required this.location,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(12),
            ),
            child: Image.network(
              imageUrl,
              height: 100,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 100,
                  width: double.infinity,
                  color: AppColors.surfaceVariant,
                  child: const Icon(
                    Icons.home_outlined,
                    color: AppColors.textTertiary,
                    size: 32,
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  price,
                  style: AppTypography.labelLarge.copyWith(
                    color: AppColors.primary,
                    fontWeight: AppTypography.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: AppTypography.labelMedium.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: AppTypography.semiBold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      color: AppColors.textTertiary,
                      size: 12,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        location,
                        style: AppTypography.labelSmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

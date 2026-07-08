import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

/// Reviews Section Widget
/// 
/// Shows agent reviews from clients
class ReviewsSection extends StatelessWidget {
  const ReviewsSection({super.key});

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
                'Reviews',
                style: AppTypography.h4.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                'See All (128)',
                style: AppTypography.labelMedium.copyWith(
                  color: AppColors.primary,
                  fontWeight: AppTypography.semiBold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Reviews List
        ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: const [
            _ReviewCard(
              reviewerName: 'Sarah Johnson',
              reviewerAvatar: 'https://i.pravatar.cc/150?img=5',
              rating: 5.0,
              date: '2 days ago',
              review: 'Excellent service! John was very professional and helped me find the perfect apartment. Highly recommended!',
            ),
            SizedBox(height: 12),
            _ReviewCard(
              reviewerName: 'Michael Brown',
              reviewerAvatar: 'https://i.pravatar.cc/150?img=3',
              rating: 4.5,
              date: '1 week ago',
              review: 'Great experience. John was responsive and knowledgeable about the market.',
            ),
            SizedBox(height: 12),
            _ReviewCard(
              reviewerName: 'Emily Davis',
              reviewerAvatar: 'https://i.pravatar.cc/150?img=9',
              rating: 5.0,
              date: '2 weeks ago',
              review: 'Very patient and understanding. Found me exactly what I was looking for.',
            ),
          ],
        ),
      ],
    );
  }
}

class _ReviewCard extends StatelessWidget {
  final String reviewerName;
  final String reviewerAvatar;
  final double rating;
  final String date;
  final String review;

  const _ReviewCard({
    required this.reviewerName,
    required this.reviewerAvatar,
    required this.rating,
    required this.date,
    required this.review,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.border,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Reviewer Info
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  reviewerAvatar,
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 40,
                      height: 40,
                      color: AppColors.surfaceVariant,
                      child: const Icon(
                        Icons.person,
                        color: AppColors.textTertiary,
                        size: 20,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      reviewerName,
                      style: AppTypography.labelLarge.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: AppTypography.semiBold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Color(0xFFFFB800),
                          size: 14,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          rating.toStringAsFixed(1),
                          style: AppTypography.labelSmall.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: AppTypography.semiBold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          date,
                          style: AppTypography.labelSmall.copyWith(
                            color: AppColors.textTertiary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Review Text
          Text(
            review,
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

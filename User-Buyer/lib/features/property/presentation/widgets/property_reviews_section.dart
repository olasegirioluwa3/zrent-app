import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/property_review.dart';
import '../providers/property_reviews_provider.dart';
import 'add_property_review_modal.dart';

/// Property Reviews Section Widget - ZRent Buyer App
/// 
/// Displays ratings and tenant/renter reviews for a specific property:
/// - Summary rating score & total reviews count
/// - "+ Add Review" modal trigger button
/// - Review cards with "Did you find this helpful? Yes / No" feedback
class PropertyReviewsSection extends ConsumerWidget {
  final String propertyId;

  const PropertyReviewsSection({
    super.key,
    required this.propertyId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reviewsState = ref.watch(propertyReviewsProvider(propertyId));
    final reviews = reviewsState.reviews;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ratings & Reviews',
                  style: AppTypography.h4.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: AppTypography.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    const Icon(Icons.star, color: Color(0xFFFFB800), size: 14),
                    const SizedBox(width: 4),
                    Text(
                      '${reviewsState.averageRating}',
                      style: AppTypography.labelMedium.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: AppTypography.bold,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '(${reviewsState.totalReviews} reviews)',
                      style: AppTypography.labelSmall.copyWith(
                        color: AppColors.textTertiary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            // "+ Add Review" Button
            InkWell(
              onTap: () => AddPropertyReviewModal.show(context, propertyId: propertyId),
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.rate_review_outlined,
                      size: 16,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Add Review',
                      style: AppTypography.labelMedium.copyWith(
                        color: AppColors.primary,
                        fontWeight: AppTypography.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Reviews List
        if (reviews.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Center(
              child: Text(
                'No reviews for this property yet. Be the first to leave a review!',
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textTertiary,
                ),
              ),
            ),
          )
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: reviews.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final review = reviews[index];
              return _PropertyReviewCard(
                review: review,
                propertyId: propertyId,
              );
            },
          ),
      ],
    );
  }
}

class _PropertyReviewCard extends ConsumerWidget {
  final PropertyReview review;
  final String propertyId;

  const _PropertyReviewCard({
    required this.review,
    required this.propertyId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isVotedYes = review.userVotedHelpful == true;
    final isVotedNo = review.userVotedHelpful == false;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.border,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Reviewer Header
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  review.reviewerAvatar,
                  width: 42,
                  height: 42,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 42,
                      height: 42,
                      color: AppColors.surfaceVariant,
                      child: const Icon(
                        Icons.person,
                        color: AppColors.textTertiary,
                        size: 22,
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
                      review.reviewerName,
                      style: AppTypography.labelLarge.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: AppTypography.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Row(
                          children: List.generate(5, (starIdx) {
                            return Icon(
                              starIdx < review.rating.floor()
                                  ? Icons.star
                                  : (starIdx < review.rating
                                      ? Icons.star_half
                                      : Icons.star_border),
                              color: const Color(0xFFFFB800),
                              size: 14,
                            );
                          }),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          review.rating.toStringAsFixed(1),
                          style: AppTypography.labelSmall.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: AppTypography.bold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '•  ${review.date}',
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
            review.review,
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textSecondary,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 14),
          const Divider(height: 1, color: AppColors.border),
          const SizedBox(height: 12),
          // Helpful Vote Row
          Row(
            children: [
              Text(
                'Did you find this helpful?',
                style: AppTypography.labelSmall.copyWith(
                  color: AppColors.textTertiary,
                ),
              ),
              const Spacer(),
              // Yes Button
              InkWell(
                onTap: () {
                  ref
                      .read(propertyReviewsProvider(propertyId).notifier)
                      .toggleHelpful(
                        reviewId: review.id,
                        isHelpful: true,
                      );
                },
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: isVotedYes
                        ? AppColors.primary.withValues(alpha: 0.15)
                        : AppColors.background,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isVotedYes ? AppColors.primary : AppColors.border,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.thumb_up_alt_outlined,
                        size: 14,
                        color: isVotedYes ? AppColors.primary : AppColors.textSecondary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Yes',
                        style: AppTypography.labelSmall.copyWith(
                          color: isVotedYes ? AppColors.primary : AppColors.textSecondary,
                          fontWeight: isVotedYes ? AppTypography.bold : AppTypography.medium,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // No Button
              InkWell(
                onTap: () {
                  ref
                      .read(propertyReviewsProvider(propertyId).notifier)
                      .toggleHelpful(
                        reviewId: review.id,
                        isHelpful: false,
                      );
                },
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: isVotedNo
                        ? Colors.redAccent.withValues(alpha: 0.15)
                        : AppColors.background,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isVotedNo ? Colors.redAccent : AppColors.border,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.thumb_down_alt_outlined,
                        size: 14,
                        color: isVotedNo ? Colors.redAccent : AppColors.textSecondary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'No',
                        style: AppTypography.labelSmall.copyWith(
                          color: isVotedNo ? Colors.redAccent : AppColors.textSecondary,
                          fontWeight: isVotedNo ? AppTypography.bold : AppTypography.medium,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          if (review.helpfulCount > 0) ...[
            const SizedBox(height: 8),
            Text(
              '${review.helpfulCount} ${review.helpfulCount == 1 ? 'person' : 'people'} found this helpful',
              style: AppTypography.labelSmall.copyWith(
                color: AppColors.primary,
                fontWeight: AppTypography.medium,
                fontSize: 11,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

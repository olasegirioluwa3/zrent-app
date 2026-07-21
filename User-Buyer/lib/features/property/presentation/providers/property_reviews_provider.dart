import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/property_review.dart';

class PropertyReviewsState {
  final List<PropertyReview> reviews;
  final double averageRating;
  final int totalReviews;

  const PropertyReviewsState({
    required this.reviews,
    required this.averageRating,
    required this.totalReviews,
  });

  PropertyReviewsState copyWith({
    List<PropertyReview>? reviews,
    double? averageRating,
    int? totalReviews,
  }) {
    return PropertyReviewsState(
      reviews: reviews ?? this.reviews,
      averageRating: averageRating ?? this.averageRating,
      totalReviews: totalReviews ?? this.totalReviews,
    );
  }
}

class PropertyReviewsNotifier
    extends StateNotifier<PropertyReviewsState> {
  final String propertyId;

  PropertyReviewsNotifier(this.propertyId)
      : super(
          PropertyReviewsState(
            reviews: [
              PropertyReview(
                id: 'prop_rev_1',
                propertyId: propertyId,
                reviewerName: 'David Okon',
                reviewerAvatar: 'https://i.pravatar.cc/150?img=11',
                rating: 5.0,
                date: '3 days ago',
                review:
                    'The apartment looks even better in person! Quiet neighborhood, fast water supply, 24/7 power backup and security. Worth every naira.',
                helpfulCount: 32,
                userVotedHelpful: null,
              ),
              PropertyReview(
                id: 'prop_rev_2',
                propertyId: propertyId,
                reviewerName: 'Fatimah Bello',
                reviewerAvatar: 'https://i.pravatar.cc/150?img=26',
                rating: 4.5,
                date: '1 week ago',
                review:
                    'Spacious rooms with excellent natural lighting. The agent was prompt and transparent during the viewing process.',
                helpfulCount: 19,
                userVotedHelpful: null,
              ),
              PropertyReview(
                id: 'prop_rev_3',
                propertyId: propertyId,
                reviewerName: 'Alex Morgan',
                reviewerAvatar: 'https://i.pravatar.cc/150?img=68',
                rating: 5.0,
                date: '2 weeks ago',
                review:
                    'Great location near main access roads and shopping centers. Very clean and well-maintained property.',
                helpfulCount: 11,
                userVotedHelpful: null,
              ),
            ],
            averageRating: 4.8,
            totalReviews: 128,
          ),
        );

  void addReview({
    required double rating,
    required String reviewText,
    String reviewerName = 'You',
    String reviewerAvatar = 'https://i.pravatar.cc/150?img=12',
  }) {
    final newReview = PropertyReview(
      id: 'prop_rev_${DateTime.now().millisecondsSinceEpoch}',
      propertyId: propertyId,
      reviewerName: reviewerName,
      reviewerAvatar: reviewerAvatar,
      rating: rating,
      date: 'Just now',
      review: reviewText,
      helpfulCount: 0,
      userVotedHelpful: null,
    );

    final updatedReviews = [newReview, ...state.reviews];
    final newTotalReviews = state.totalReviews + 1;

    // Calculate new average rating
    final sumRating = (state.averageRating * state.totalReviews) + rating;
    final newAverageRating = sumRating / newTotalReviews;

    state = state.copyWith(
      reviews: updatedReviews,
      totalReviews: newTotalReviews,
      averageRating: double.parse(newAverageRating.toStringAsFixed(1)),
    );
  }

  void toggleHelpful({required String reviewId, required bool isHelpful}) {
    final updatedReviews = state.reviews.map((rev) {
      if (rev.id != reviewId) return rev;

      if (isHelpful) {
        if (rev.userVotedHelpful == true) {
          // Untoggle Yes
          return rev.copyWith(
            helpfulCount: (rev.helpfulCount - 1).clamp(0, 9999),
            clearUserVote: true,
          );
        } else if (rev.userVotedHelpful == false) {
          // Change from No to Yes
          return rev.copyWith(
            helpfulCount: rev.helpfulCount + 1,
            userVotedHelpful: true,
          );
        } else {
          // Vote Yes
          return rev.copyWith(
            helpfulCount: rev.helpfulCount + 1,
            userVotedHelpful: true,
          );
        }
      } else {
        if (rev.userVotedHelpful == false) {
          // Untoggle No
          return rev.copyWith(
            clearUserVote: true,
          );
        } else if (rev.userVotedHelpful == true) {
          // Change from Yes to No
          return rev.copyWith(
            helpfulCount: (rev.helpfulCount - 1).clamp(0, 9999),
            userVotedHelpful: false,
          );
        } else {
          // Vote No
          return rev.copyWith(
            userVotedHelpful: false,
          );
        }
      }
    }).toList();

    state = state.copyWith(reviews: updatedReviews);
  }
}

final propertyReviewsProvider = StateNotifierProvider.family<
    PropertyReviewsNotifier, PropertyReviewsState, String>(
  (ref, propertyId) => PropertyReviewsNotifier(propertyId),
);

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/agent_review.dart';

class AgentReviewsState {
  final List<AgentReview> reviews;
  final double averageRating;
  final int totalReviews;

  const AgentReviewsState({
    required this.reviews,
    required this.averageRating,
    required this.totalReviews,
  });

  AgentReviewsState copyWith({
    List<AgentReview>? reviews,
    double? averageRating,
    int? totalReviews,
  }) {
    return AgentReviewsState(
      reviews: reviews ?? this.reviews,
      averageRating: averageRating ?? this.averageRating,
      totalReviews: totalReviews ?? this.totalReviews,
    );
  }
}

class AgentReviewsNotifier extends StateNotifier<AgentReviewsState> {
  AgentReviewsNotifier()
      : super(
          const AgentReviewsState(
            reviews: [
              AgentReview(
                id: 'rev_1',
                reviewerName: 'Sarah Johnson',
                reviewerAvatar: 'https://i.pravatar.cc/150?img=5',
                rating: 5.0,
                date: '2 days ago',
                review:
                    'Excellent service! John was very professional and helped me find the perfect apartment. Highly recommended! This agent is trusted.',
                helpfulCount: 24,
                userVotedHelpful: null,
              ),
              AgentReview(
                id: 'rev_2',
                reviewerName: 'Michael Brown',
                reviewerAvatar: 'https://i.pravatar.cc/150?img=3',
                rating: 4.5,
                date: '1 week ago',
                review:
                    'Great experience. John was responsive and knowledgeable about the market.',
                helpfulCount: 12,
                userVotedHelpful: null,
              ),
              AgentReview(
                id: 'rev_3',
                reviewerName: 'Emily Davis',
                reviewerAvatar: 'https://i.pravatar.cc/150?img=9',
                rating: 5.0,
                date: '2 weeks ago',
                review:
                    'Very patient and understanding. Found me exactly what I was looking for.',
                helpfulCount: 8,
                userVotedHelpful: null,
              ),
            ],
            averageRating: 4.9,
            totalReviews: 128,
          ),
        );

  void addReview({
    required double rating,
    required String reviewText,
    String reviewerName = 'You',
    String reviewerAvatar = 'https://i.pravatar.cc/150?img=12',
  }) {
    final newReview = AgentReview(
      id: 'rev_${DateTime.now().millisecondsSinceEpoch}',
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

final agentReviewsProvider =
    StateNotifierProvider<AgentReviewsNotifier, AgentReviewsState>(
  (ref) => AgentReviewsNotifier(),
);

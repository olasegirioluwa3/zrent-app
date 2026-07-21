import 'package:flutter/foundation.dart';

/// Domain entity representing a Property Review
@immutable
class PropertyReview {
  final String id;
  final String propertyId;
  final String reviewerName;
  final String reviewerAvatar;
  final double rating;
  final String date;
  final String review;
  final int helpfulCount;
  final bool? userVotedHelpful; // true = Yes, false = No, null = Not voted

  const PropertyReview({
    required this.id,
    required this.propertyId,
    required this.reviewerName,
    required this.reviewerAvatar,
    required this.rating,
    required this.date,
    required this.review,
    this.helpfulCount = 0,
    this.userVotedHelpful,
  });

  PropertyReview copyWith({
    String? id,
    String? propertyId,
    String? reviewerName,
    String? reviewerAvatar,
    double? rating,
    String? date,
    String? review,
    int? helpfulCount,
    bool? userVotedHelpful,
    bool clearUserVote = false,
  }) {
    return PropertyReview(
      id: id ?? this.id,
      propertyId: propertyId ?? this.propertyId,
      reviewerName: reviewerName ?? this.reviewerName,
      reviewerAvatar: reviewerAvatar ?? this.reviewerAvatar,
      rating: rating ?? this.rating,
      date: date ?? this.date,
      review: review ?? this.review,
      helpfulCount: helpfulCount ?? this.helpfulCount,
      userVotedHelpful: clearUserVote ? null : (userVotedHelpful ?? this.userVotedHelpful),
    );
  }
}

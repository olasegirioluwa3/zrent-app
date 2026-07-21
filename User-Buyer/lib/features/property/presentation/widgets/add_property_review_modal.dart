import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../providers/property_reviews_provider.dart';

class AddPropertyReviewModal extends ConsumerStatefulWidget {
  final String propertyId;

  const AddPropertyReviewModal({
    super.key,
    required this.propertyId,
  });

  static void show(BuildContext context, {required String propertyId}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AddPropertyReviewModal(propertyId: propertyId),
    );
  }

  @override
  ConsumerState<AddPropertyReviewModal> createState() => _AddPropertyReviewModalState();
}

class _AddPropertyReviewModalState extends ConsumerState<AddPropertyReviewModal> {
  double _rating = 5.0;
  final TextEditingController _reviewController = TextEditingController();

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  String _getRatingLabel(double rating) {
    switch (rating.toInt()) {
      case 5:
        return '5.0 — Excellent Property';
      case 4:
        return '4.0 — Very Good';
      case 3:
        return '3.0 — Average';
      case 2:
        return '2.0 — Needs Improvement';
      case 1:
        return '1.0 — Poor Experience';
      default:
        return 'Select Rating';
    }
  }

  void _submitReview() {
    final text = _reviewController.text.trim();
    if (text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your review details'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    ref.read(propertyReviewsProvider(widget.propertyId).notifier).addReview(
          rating: _rating,
          reviewText: text,
        );

    Navigator.of(context).pop();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Thank you! Your property review has been posted.'),
        backgroundColor: AppColors.primary,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 16,
        bottom: bottomInset + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drag indicator
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Rate & Review Property',
                style: AppTypography.h4.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: AppTypography.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, color: AppColors.textSecondary),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Interactive Star Rating Selector
          Center(
            child: Column(
              children: [
                Text(
                  'How would you rate this property?',
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textTertiary,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    final starRating = index + 1.0;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _rating = starRating;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Icon(
                          index < _rating ? Icons.star : Icons.star_border,
                          color: const Color(0xFFFFB800),
                          size: 36,
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 8),
                Text(
                  _getRatingLabel(_rating),
                  style: AppTypography.labelLarge.copyWith(
                    color: AppColors.primary,
                    fontWeight: AppTypography.semiBold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Review Input Field
          Text(
            'Your Review',
            style: AppTypography.labelMedium.copyWith(
              color: AppColors.textPrimary,
              fontWeight: AppTypography.semiBold,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _reviewController,
            maxLines: 4,
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textPrimary,
            ),
            decoration: InputDecoration(
              hintText:
                  'Share details about this property (e.g., condition, security, water/power supply, neighborhood)...',
              hintStyle: AppTypography.bodyMedium.copyWith(
                color: AppColors.textTertiary,
              ),
              filled: true,
              fillColor: AppColors.background,
              contentPadding: const EdgeInsets.all(16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColors.border),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColors.border),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
              ),
            ),
          ),
          const SizedBox(height: 24),
          // Submit Button
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: _submitReview,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: Text(
                'Submit Review',
                style: AppTypography.labelLarge.copyWith(
                  fontWeight: AppTypography.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

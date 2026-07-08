import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

/// Property Image Gallery Widget
/// 
/// Horizontal scrollable property images with indicators
class PropertyImageGallery extends StatelessWidget {
  const PropertyImageGallery({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      child: Stack(
        children: [
          // Image Gallery
          PageView.builder(
            itemCount: 3,
            itemBuilder: (context, index) {
              return Image.network(
                'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?w=600',
                width: double.infinity,
                height: 280,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: double.infinity,
                    height: 280,
                    color: AppColors.surfaceVariant,
                    child: const Icon(
                      Icons.home_outlined,
                      color: AppColors.textTertiary,
                      size: 60,
                    ),
                  );
                },
              );
            },
          ),
          // Back Button
          Positioned(
            top: 16,
            left: 20,
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.textWhite.withOpacity(0.9),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadow,
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(
                Icons.arrow_back,
                color: AppColors.textPrimary,
                size: 22,
              ),
            ),
          ),
          // Favorite Button
          Positioned(
            top: 16,
            right: 20,
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.textWhite.withOpacity(0.9),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadow,
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(
                Icons.favorite_border,
                color: AppColors.textPrimary,
                size: 22,
              ),
            ),
          ),
          // Page Indicators
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: index == 0 ? 24 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: index == 0 ? AppColors.primary : AppColors.textWhite.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

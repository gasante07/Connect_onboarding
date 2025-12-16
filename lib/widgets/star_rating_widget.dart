import 'package:flutter/material.dart';
import '../config/app_theme.dart';

/// A scalable star rating widget for sport selection
/// Displays 3 stars that can be filled based on rating value
class StarRatingWidget extends StatelessWidget {
  /// Current rating (0-3)
  final int rating;
  
  /// Maximum number of stars
  final int maxStars;
  
  /// Size of each star
  final double starSize;
  
  /// Color of filled stars
  final Color? filledColor;
  
  /// Color of unfilled stars
  final Color? unfilledColor;
  
  /// Callback when a star is tapped
  final ValueChanged<int>? onRatingChanged;

  const StarRatingWidget({
    super.key,
    required this.rating,
    this.maxStars = 3,
    this.starSize = 20.0,
    this.filledColor,
    this.unfilledColor,
    this.onRatingChanged,
  }) : assert(rating >= 0 && rating <= maxStars,
         'Rating must be between 0 and maxStars');

  @override
  Widget build(BuildContext context) {
    final effectiveFilledColor = filledColor ?? AppTheme.primary600;
    final effectiveUnfilledColor = unfilledColor ?? AppTheme.primary600.withOpacity(0.3);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(maxStars, (index) {
        final isFilled = index < rating;
        return GestureDetector(
          onTap: onRatingChanged != null
              ? () {
                  // Toggle: if tapping the current rating, set to 0, otherwise set to tapped star
                  final newRating = (rating == index + 1) ? 0 : index + 1;
                  onRatingChanged!(newRating);
                }
              : null,
          child: Padding(
            padding: EdgeInsets.only(
              right: index < maxStars - 1 ? AppTheme.spacingXS : 0,
            ),
            child: Icon(
              isFilled ? Icons.star : Icons.star_border,
              size: starSize,
              color: isFilled ? effectiveFilledColor : effectiveUnfilledColor,
            ),
          ),
        );
      }),
    );
  }
}

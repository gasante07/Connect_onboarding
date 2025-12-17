import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../config/app_theme.dart';
import '../config/app_sizes.dart';
import 'star_rating_widget.dart';

/// A scalable sport selection item widget
/// Displays sport icon, name, and star rating in a card format
class SportSelectionItemWidget extends StatelessWidget {
  /// Sport name
  final String sportName;
  
  /// Sport icon (emoji or icon data)
  final String icon;
  
  /// Current rating (0-3)
  final int rating;
  
  /// Callback when rating changes
  final ValueChanged<int>? onRatingChanged;
  
  /// Optional custom icon widget (if not using emoji)
  final Widget? iconWidget;

  String _skillLabel(int value) {
    switch (value) {
      case 1:
        return 'Newbie';
      case 2:
        return 'Intermediate';
      case 3:
        return 'Advanced';
      default:
        return 'Not set';
    }
  }

  const SportSelectionItemWidget({
    super.key,
    required this.sportName,
    required this.icon,
    this.rating = 0,
    this.onRatingChanged,
    this.iconWidget,
  });

  @override
  Widget build(BuildContext context) {
    final isNarrow = MediaQuery.of(context).size.width < 340;
    final nameSize = isNarrow ? AppTheme.fontSizeSM : AppTheme.fontSizeMD;
    final starSize = isNarrow ? 18.0 : 20.0;
    final horizontalGap = isNarrow ? AppTheme.spacingSM : AppTheme.spacingLG;
    final iconBox = isNarrow ? 44.0 : 48.0;

    return Container(
      margin: EdgeInsets.only(bottom: AppTheme.spacingLG),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSizes.inputBorderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(isNarrow ? AppTheme.spacingMD : AppTheme.spacingLG),
        child: Row(
          children: [
            // Sport icon
            Container(
              width: iconBox,
              height: iconBox,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppTheme.backgroundColorGrey100,
              ),
              child: Center(
                child: iconWidget ??
                    Text(
                      icon,
                      style: const TextStyle(fontSize: 24),
                    ),
              ),
            ),
            SizedBox(width: horizontalGap),
            // Sport name
            Expanded(
              child: Text(
                sportName,
                style: GoogleFonts.inter(
                  fontSize: nameSize,
                  fontWeight: AppTheme.fontWeightMedium,
                  color: AppTheme.textPrimary,
                  letterSpacing: AppTheme.letterSpacingNormal,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(width: AppTheme.spacingMD),
            // Star rating
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                StarRatingWidget(
                  rating: rating,
                  maxStars: 3,
                  starSize: starSize,
                  onRatingChanged: onRatingChanged,
                ),
                SizedBox(height: AppTheme.spacingXS),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppTheme.spacingSM,
                    vertical: AppTheme.spacingXS,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.primary600.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    _skillLabel(rating),
                    style: GoogleFonts.inter(
                      fontSize: AppTheme.fontSizeXS,
                      fontWeight: AppTheme.fontWeightMedium,
                      color: AppTheme.primary700,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

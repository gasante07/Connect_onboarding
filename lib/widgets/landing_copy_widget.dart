import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../config/app_copy.dart';
import '../config/app_theme.dart';

/// A scalable widget for displaying engaging landing page copy
/// Supports different styles and can be easily customized
class LandingCopyWidget extends StatelessWidget {
  /// Whether to show the full copy or just headline
  final bool showFullCopy;
  
  /// Text alignment
  final TextAlign textAlign;
  
  /// Custom headline (optional, uses default if null)
  final String? customHeadline;
  
  /// Custom subheadline (optional, uses default if null)
  final String? customSubheadline;

  const LandingCopyWidget({
    super.key,
    this.showFullCopy = true,
    this.textAlign = TextAlign.center,
    this.customHeadline,
    this.customSubheadline,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Clean headline
        Text(
          customHeadline ?? AppCopy.landingHeadline,
          textAlign: textAlign,
          style: GoogleFonts.inter(
            fontSize: AppTheme.fontSize2XL,
            fontWeight: AppTheme.fontWeightBold,
            color: AppTheme.textWhite,
            height: 1.2,
            letterSpacing: -0.5,
            shadows: [
              Shadow(
                color: Colors.black.withOpacity(0.7),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
              Shadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 4,
                offset: const Offset(0, 1),
              ),
            ],
          ),
        ),
        if (showFullCopy) ...[
          SizedBox(height: AppTheme.spacingLG),
          // Clean subheadline
          Text(
            customSubheadline ?? AppCopy.landingSubheadline,
            textAlign: textAlign,
            style: GoogleFonts.inter(
              fontSize: AppTheme.fontSizeMD,
              fontWeight: AppTheme.fontWeightRegular,
              color: AppTheme.textWhite,
              height: 1.5,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.6),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
                Shadow(
                  color: Colors.black.withOpacity(0.4),
                  blurRadius: 3,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

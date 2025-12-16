import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../config/app_theme.dart';

/// A scalable motivational text widget for onboarding screens
/// Displays exciting copy to get users engaged
class MotivationalTextWidget extends StatelessWidget {
  /// The motivational text to display
  final String text;
  
  /// Text alignment
  final TextAlign textAlign;
  
  /// Optional custom text style
  final TextStyle? textStyle;

  const MotivationalTextWidget({
    super.key,
    required this.text,
    this.textAlign = TextAlign.center,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppTheme.spacingXL,
        vertical: AppTheme.spacingLG,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Text(
        text,
        textAlign: textAlign,
        style: textStyle ??
            GoogleFonts.inter(
              fontSize: AppTheme.fontSizeMD,
              fontWeight: AppTheme.fontWeightMedium,
              color: Colors.white,
              letterSpacing: AppTheme.letterSpacingNormal,
              height: 1.5,
            ),
      ),
    );
  }
}

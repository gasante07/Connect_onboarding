import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../config/app_theme.dart';

/// A scalable progress indicator widget for onboarding flows
/// Displays current step and visual progress bar
class ProgressIndicatorWidget extends StatelessWidget {
  /// Current step number (1-based)
  final int currentStep;
  
  /// Total number of steps
  final int totalSteps;
  
  /// Color of the progress bar (defaults to primary orange)
  final Color? progressColor;
  
  /// Color of the progress track (defaults to light gray)
  final Color? trackColor;
  
  /// Height of the progress bar
  final double height;

  const ProgressIndicatorWidget({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    this.progressColor,
    this.trackColor,
    this.height = 4.0,
  }) : assert(currentStep > 0 && currentStep <= totalSteps,
         'Current step must be between 1 and totalSteps');

  @override
  Widget build(BuildContext context) {
    final progress = currentStep / totalSteps;
    final effectiveProgressColor = progressColor ?? AppTheme.primary600;
    final effectiveTrackColor = trackColor ?? const Color(0xFFE5E5E5);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Step text indicator
        Text(
          '$currentStep of $totalSteps',
          style: GoogleFonts.inter(
            fontSize: AppTheme.fontSizeSM,
            fontWeight: AppTheme.fontWeightMedium,
            color: AppTheme.textSecondary,
            letterSpacing: AppTheme.letterSpacingNormal,
          ),
        ),
        SizedBox(height: AppTheme.spacingMD),
        // Progress bar
        ClipRRect(
          borderRadius: BorderRadius.circular(height / 2),
          child: Container(
            height: height,
            decoration: BoxDecoration(
              color: effectiveTrackColor,
              borderRadius: BorderRadius.circular(height / 2),
            ),
            child: Stack(
              children: [
                // Progress fill
                FractionallySizedBox(
                  widthFactor: progress,
                  alignment: Alignment.centerLeft,
                  child: Container(
                    decoration: BoxDecoration(
                      color: effectiveProgressColor,
                      borderRadius: BorderRadius.circular(height / 2),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

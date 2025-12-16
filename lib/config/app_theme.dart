import 'package:flutter/material.dart';

/// Centralized design system for the app
/// All design tokens (colors, spacing, sizes, etc.) should be defined here
/// This ensures consistency and makes it easy to update the design across the app
class AppTheme {
  AppTheme._(); // Private constructor to prevent instantiation

  // ==================== Colors ====================
  
  /// Primary brand color (MaterialColor supports shade access)
  static const MaterialColor primaryColor = Colors.deepOrange;
  
  /// Primary color shades
  static Color get primary300 => Colors.deepOrange[300]!;
  static Color get primary400 => Colors.deepOrange[400]!;
  static Color get primary600 => Colors.deepOrange[600]!;
  static Color get primary700 => Colors.deepOrange[700]!;
  static Color get primary800 => Colors.deepOrange[800]!;

  /// Background colors
  static const Color backgroundColorLight = Color(0xFFFAFAFA);
  static const Color backgroundColorGrey50 = Color(0xFFFAFAFA);
  static const Color backgroundColorGrey100 = Color(0xFFF5F5F5);
  
  /// Overlay opacity values
  static const double overlayOpacityLight = 0.3;
  static const double overlayOpacityMedium = 0.4;
  static const double overlayOpacityDark = 0.6;

  /// Text colors
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF6B6B6B);
  static const Color textTertiary = Color(0xFF9E9E9E);
  static const Color textWhite = Colors.white;

  /// Border colors
  static const Color borderLight = Color(0xFFE0E0E0);
  static const Color borderMedium = Color(0xFFBDBDBD);
  static Color get borderError => Colors.red[300]!;
  static Color get borderErrorFocused => Colors.red[400]!;

  /// Shadow colors
  static Color shadowLight = Colors.black.withOpacity(0.05);
  static Color shadowMedium = Colors.black.withOpacity(0.1);
  static Color shadowPrimaryColor = primaryColor.withOpacity(0.15);
  static Color shadowPrimaryStrong = primaryColor.withOpacity(0.4);

  // ==================== Spacing ====================
  
  /// Base spacing unit (4px)
  static const double spacingUnit = 4.0;
  
  /// Spacing scale
  static double spacing(double multiplier) => spacingUnit * multiplier;
  
  static const double spacingXS = 4.0;   // 1x
  static const double spacingSM = 8.0;    // 2x
  static const double spacingMD = 12.0;   // 3x
  static const double spacingLG = 16.0;    // 4x
  static const double spacingXL = 20.0;   // 5x
  static const double spacing2XL = 24.0;  // 6x
  static const double spacing3XL = 32.0;  // 8x
  static const double spacing4XL = 40.0;  // 10x
  static const double spacing5XL = 48.0;  // 12x
  static const double spacing6XL = 60.0;  // 15x

  // ==================== Sizes ====================
  
  /// Logo sizes
  static const double logoSmall = 60.0;
  static const double logoMedium = 100.0;
  static const double logoLarge = 150.0;

  /// Button sizes
  static const double buttonHeight = 56.0;
  static const double buttonHeightSmall = 44.0;
  static const double buttonHeightLarge = 64.0;
  static const double buttonBorderRadius = 16.0;
  static const double buttonIconSize = 24.0;
  
  /// Card sizes
  static const double cardBorderRadius = 16.0;

  /// Input field sizes
  static const double inputHeight = 56.0;
  static const double inputBorderRadius = 16.0;
  static const double inputIconSize = 22.0;
  static const double inputBorderWidth = 1.0;
  static const double inputBorderWidthFocused = 2.0;

  /// Social button sizes
  static const double socialButtonSize = 56.0;
  static const double socialButtonIconSize = 24.0;
  static const double socialButtonBorderWidth = 1.5;

  // ==================== Typography ====================
  
  /// Font sizes
  static const double fontSizeXS = 12.0;
  static const double fontSizeSM = 14.0;
  static const double fontSizeMD = 16.0;
  static const double fontSizeLG = 18.0;
  static const double fontSizeXL = 24.0;
  static const double fontSize2XL = 28.0;
  static const double fontSize3XL = 36.0;
  static const double fontSize4XL = 48.0;

  /// Font weights
  static const FontWeight fontWeightRegular = FontWeight.w400;
  static const FontWeight fontWeightMedium = FontWeight.w500;
  static const FontWeight fontWeightSemiBold = FontWeight.w600;
  static const FontWeight fontWeightBold = FontWeight.w700;
  static const FontWeight fontWeightExtraBold = FontWeight.w800;
  static const FontWeight fontWeightBlack = FontWeight.w900;

  /// Letter spacing
  static const double letterSpacingTight = -0.5;
  static const double letterSpacingNormal = 0.0;
  static const double letterSpacingWide = 0.5;

  // ==================== Shadows ====================
  
  /// Standard shadow
  static List<BoxShadow> get shadowStandard => [
        BoxShadow(
          color: shadowMedium,
          blurRadius: 10,
          offset: const Offset(0, 4),
          spreadRadius: 0,
        ),
      ];

  /// Elevated shadow
  static List<BoxShadow> get shadowElevated => [
        BoxShadow(
          color: shadowMedium,
          blurRadius: 10,
          offset: const Offset(0, 4),
          spreadRadius: 0,
        ),
        BoxShadow(
          color: shadowLight,
          blurRadius: 20,
          offset: const Offset(0, 8),
          spreadRadius: 0,
        ),
      ];

  /// Primary shadow (for buttons)
  static List<BoxShadow> get shadowPrimary => [
        BoxShadow(
          color: shadowPrimaryStrong,
          blurRadius: 20,
          offset: const Offset(0, 8),
          spreadRadius: 0,
        ),
        BoxShadow(
          color: shadowMedium,
          blurRadius: 10,
          offset: const Offset(0, 4),
          spreadRadius: 0,
        ),
      ];

  /// Focus shadow (for input fields)
  static List<BoxShadow> shadowFocus({bool isFocused = false}) => [
        BoxShadow(
          color: isFocused ? shadowPrimaryColor : shadowLight,
          blurRadius: isFocused ? 20 : 10,
          offset: const Offset(0, 4),
          spreadRadius: isFocused ? 2 : 0,
        ),
      ];

  // ==================== Animations ====================
  
  /// Animation durations
  static const Duration animationDurationFast = Duration(milliseconds: 100);
  static const Duration animationDurationMedium = Duration(milliseconds: 300);
  static const Duration animationDurationSlow = Duration(milliseconds: 600);
  static const Duration animationDurationPage = Duration(milliseconds: 1200);
  static const Duration animationDurationCarouselTransition = Duration(milliseconds: 800);

  /// Animation curves
  static const Curve animationCurveDefault = Curves.easeInOut;
  static const Curve animationCurveEaseOut = Curves.easeOut;
  static const Curve animationCurveEaseOutCubic = Curves.easeOutCubic;

  // ==================== Gradients ====================
  
  /// Primary button gradient
  static LinearGradient get primaryGradient => LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          primary600,
          primary700,
          primary800,
        ],
      );

  /// Background gradient (fallback)
  static LinearGradient get backgroundGradient => LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          backgroundColorGrey50,
          backgroundColorGrey100,
          backgroundColorGrey50,
        ],
      );
}

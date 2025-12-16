import 'app_theme.dart';

/// Centralized size constants for widgets
/// This provides a scalable way to manage widget sizes
class AppSizes {
  AppSizes._(); // Private constructor to prevent instantiation

  // Logo sizes
  static const double logoSmall = AppTheme.logoSmall;
  static const double logoMedium = AppTheme.logoMedium;
  static const double logoLarge = AppTheme.logoLarge;

  // Button sizes
  static const double buttonHeight = AppTheme.buttonHeight;
  static const double buttonHeightSmall = AppTheme.buttonHeightSmall;
  static const double buttonHeightLarge = AppTheme.buttonHeightLarge;
  static const double buttonBorderRadius = AppTheme.buttonBorderRadius;
  static const double buttonIconSize = AppTheme.buttonIconSize;

  // Input field sizes
  static const double inputHeight = AppTheme.inputHeight;
  static const double inputBorderRadius = AppTheme.inputBorderRadius;
  static const double inputIconSize = AppTheme.inputIconSize;
  static const double inputBorderWidth = AppTheme.inputBorderWidth;
  static const double inputBorderWidthFocused = AppTheme.inputBorderWidthFocused;

  // Social button sizes
  static const double socialButtonSize = AppTheme.socialButtonSize;
  static const double socialButtonIconSize = AppTheme.socialButtonIconSize;
  static const double socialButtonBorderWidth = AppTheme.socialButtonBorderWidth;
}

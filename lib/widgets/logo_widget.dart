import 'package:flutter/material.dart';
import '../config/app_assets.dart';
import '../config/app_theme.dart';
import '../config/app_sizes.dart';

/// A scalable logo widget that displays the GAMEON ACTIVE logo
/// Supports different sizes and maintains aspect ratio
/// All sizes use centralized theme constants for scalability
class LogoWidget extends StatelessWidget {
  /// The height of the logo. Width will be calculated to maintain aspect ratio.
  final double? height;
  
  /// The width of the logo. Height will be calculated to maintain aspect ratio.
  final double? width;
  
  /// How the image should be fitted within its bounds
  final BoxFit fit;
  
  /// Optional color filter to apply to the logo
  final ColorFilter? colorFilter;

  const LogoWidget({
    super.key,
    this.height,
    this.width,
    this.fit = BoxFit.contain,
    this.colorFilter,
  });

  /// Factory constructor for a small logo
  factory LogoWidget.small({Key? key}) {
    return LogoWidget(
      key: key,
      height: AppSizes.logoSmall,
    );
  }

  /// Factory constructor for a medium logo (default)
  factory LogoWidget.medium({Key? key}) {
    return LogoWidget(
      key: key,
      height: AppSizes.logoMedium,
    );
  }

  /// Factory constructor for a large logo
  factory LogoWidget.large({Key? key}) {
    return LogoWidget(
      key: key,
      height: AppSizes.logoLarge,
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget imageWidget = Image.asset(
      AppAssets.logoWhite,
      height: height,
      width: width,
      fit: fit,
      errorBuilder: (context, error, stackTrace) {
        debugPrint('Error loading logo: ${AppAssets.logoWhite}');
        debugPrint('Error: $error');
        // Fallback to a simple text logo if image fails to load
        return Container(
          height: height ?? AppSizes.logoMedium,
          alignment: Alignment.center,
          child: Text(
            'GAMEON ACTIVE',
            style: TextStyle(
              fontSize: AppTheme.fontSizeXL,
              fontWeight: AppTheme.fontWeightBold,
              color: AppTheme.textWhite,
            ),
          ),
        );
      },
    );

    // Apply color filter if provided
    if (colorFilter != null) {
      return ColorFiltered(
        colorFilter: colorFilter!,
        child: imageWidget,
      );
    }

    return imageWidget;
  }
}

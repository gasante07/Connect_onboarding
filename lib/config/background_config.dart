import 'package:flutter/material.dart';
import 'app_assets.dart';
import 'app_theme.dart';

/// Configuration class for background images
/// This provides a scalable way to manage background settings across the app
class BackgroundConfig {
  /// The image path (asset, network, or file)
  final String imagePath;
  
  /// Image source type
  final ImageSourceType sourceType;
  
  /// Overlay color for text readability
  final Color? overlayColor;
  
  /// Overlay opacity (0.0 to 1.0)
  final double overlayOpacity;
  
  /// How the image should be sized
  final BoxFit fit;
  
  /// Fallback gradient colors if image fails to load
  final List<Color>? fallbackGradientColors;

  const BackgroundConfig({
    required this.imagePath,
    this.sourceType = ImageSourceType.asset,
    this.overlayColor,
    this.overlayOpacity = 0.4,
    this.fit = BoxFit.cover,
    this.fallbackGradientColors,
  });

  /// Default landing page background configuration
  factory BackgroundConfig.landingPage() {
    return BackgroundConfig(
      imagePath: AppAssets.basketball,
      overlayColor: Colors.black,
      overlayOpacity: 0.45,
      fit: BoxFit.cover,
      fallbackGradientColors: [
        AppTheme.backgroundColorGrey50,
        AppTheme.backgroundColorGrey100,
        AppTheme.backgroundColorGrey50,
      ],
    );
  }

  /// Create a custom background configuration
  factory BackgroundConfig.custom({
    required String imagePath,
    ImageSourceType sourceType = ImageSourceType.asset,
    Color? overlayColor,
    double overlayOpacity = 0.4,
    BoxFit fit = BoxFit.cover,
    List<Color>? fallbackGradientColors,
  }) {
    return BackgroundConfig(
      imagePath: imagePath,
      sourceType: sourceType,
      overlayColor: overlayColor,
      overlayOpacity: overlayOpacity,
      fit: fit,
      fallbackGradientColors: fallbackGradientColors,
    );
  }

  /// Create a network image background configuration
  factory BackgroundConfig.network({
    required String imageUrl,
    Color? overlayColor,
    double overlayOpacity = 0.4,
    BoxFit fit = BoxFit.cover,
    List<Color>? fallbackGradientColors,
  }) {
    return BackgroundConfig(
      imagePath: imageUrl,
      sourceType: ImageSourceType.network,
      overlayColor: overlayColor,
      overlayOpacity: overlayOpacity,
      fit: fit,
      fallbackGradientColors: fallbackGradientColors,
    );
  }
}

/// Enum for image source types
enum ImageSourceType {
  asset,
  network,
  file,
}

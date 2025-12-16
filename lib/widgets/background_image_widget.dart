import 'package:flutter/material.dart';
import '../config/background_config.dart';
import '../config/app_theme.dart';

/// A scalable, reusable widget that displays a background image with optional overlay
/// Supports multiple image sources (asset, network, file) and provides fallback handling
/// 
/// Usage examples:
/// ```dart
/// // Using configuration object (recommended)
/// BackgroundImageWidget.fromConfig(
///   config: BackgroundConfig.landingPage(),
///   child: YourContent(),
/// )
/// 
/// // Direct usage
/// BackgroundImageWidget(
///   imagePath: 'assets/images/background.jpg',
///   overlayColor: Colors.black,
///   overlayOpacity: 0.4,
///   child: YourContent(),
/// )
/// ```
class BackgroundImageWidget extends StatelessWidget {
  /// The path/URL to the background image
  final String imagePath;
  
  /// Image source type (asset, network, or file)
  final ImageSourceType sourceType;
  
  /// Optional overlay color to darken/lighten the background
  final Color? overlayColor;
  
  /// Opacity of the overlay (0.0 to 1.0)
  final double overlayOpacity;
  
  /// How the image should be sized
  final BoxFit fit;
  
  /// Fallback gradient colors if image fails to load
  final List<Color>? fallbackGradientColors;
  
  /// The child widget to display on top of the background
  final Widget child;

  const BackgroundImageWidget({
    super.key,
    required this.imagePath,
    required this.child,
    this.sourceType = ImageSourceType.asset,
    this.overlayColor,
    this.overlayOpacity = 0.4,
    this.fit = BoxFit.cover,
    this.fallbackGradientColors,
  });

  /// Factory constructor using BackgroundConfig (recommended for scalability)
  factory BackgroundImageWidget.fromConfig({
    required BackgroundConfig config,
    required Widget child,
    Key? key,
  }) {
    return BackgroundImageWidget(
      key: key,
      imagePath: config.imagePath,
      sourceType: config.sourceType,
      overlayColor: config.overlayColor,
      overlayOpacity: config.overlayOpacity,
      fit: config.fit,
      fallbackGradientColors: config.fallbackGradientColors,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background image
        Positioned.fill(
          child: _buildImage(),
        ),
        // Overlay
        if (overlayColor != null)
          Positioned.fill(
            child: Container(
              color: overlayColor!.withOpacity(overlayOpacity),
            ),
          ),
        // Content
        child,
      ],
    );
  }

  Widget _buildImage() {
    switch (sourceType) {
      case ImageSourceType.asset:
        return Image.asset(
          imagePath,
          fit: fit,
          errorBuilder: _errorBuilder,
        );
      case ImageSourceType.network:
        return Image.network(
          imagePath,
          fit: fit,
          errorBuilder: _errorBuilder,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return _buildFallback();
          },
        );
      case ImageSourceType.file:
        return Image.asset(
          imagePath, // Note: For file paths, you'd use Image.file() in a real implementation
          fit: fit,
          errorBuilder: _errorBuilder,
        );
    }
  }

  Widget _errorBuilder(BuildContext context, Object error, StackTrace? stackTrace) {
    debugPrint('Error loading background image: $imagePath');
    debugPrint('Error: $error');
    return _buildFallback();
  }

  Widget _buildFallback() {
    if (fallbackGradientColors != null && fallbackGradientColors!.isNotEmpty) {
      return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: fallbackGradientColors!,
          ),
        ),
      );
    }
    // Default fallback using theme
    return Container(
      decoration: BoxDecoration(
        gradient: AppTheme.backgroundGradient,
      ),
    );
  }
}

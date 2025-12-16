import 'package:flutter/material.dart';

/// A modern glassmorphism card widget
/// Provides a sleek, modern glass effect with blur and transparency
/// Also supports solid white card mode for forms and onboarding
class GlassCardWidget extends StatelessWidget {
  /// The child widget to display inside the card
  final Widget child;
  
  /// Border radius for the card
  final double borderRadius;
  
  /// Padding inside the card
  final EdgeInsetsGeometry padding;
  
  /// Background color opacity (0.0 to 1.0)
  /// When set to 1.0, creates a solid white card
  final double opacity;
  
  /// Blur intensity (not used when opacity is 1.0)
  final double blurIntensity;
  
  /// Whether to show border (defaults to true for glass effect, false for solid)
  final bool? showBorder;

  const GlassCardWidget({
    super.key,
    required this.child,
    this.borderRadius = 20.0,
    this.padding = const EdgeInsets.all(28.0),
    this.opacity = 0.12,
    this.blurIntensity = 10.0,
    this.showBorder,
  });

  @override
  Widget build(BuildContext context) {
    final isSolid = opacity >= 1.0;
    final effectiveShowBorder = showBorder ?? !isSolid;
    
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: isSolid ? Colors.white : Colors.white.withOpacity(opacity),
        gradient: isSolid
            ? LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white,
                  Colors.white.withOpacity(0.98),
                ],
              )
            : null,
        border: effectiveShowBorder
            ? Border.all(
                color: isSolid
                    ? Colors.transparent
                    : Colors.white.withOpacity(0.25),
                width: 1,
              )
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isSolid ? 0.08 : 0.08),
            blurRadius: isSolid ? 20 : 24,
            offset: const Offset(0, 8),
            spreadRadius: 0,
          ),
          if (isSolid)
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 2),
              spreadRadius: 0,
            ),
        ],
      ),
      child: child,
    );
  }
}

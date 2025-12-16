import 'package:flutter/material.dart';

/// A scalable success icon widget
/// Displays a green checkmark in a circular background
class SuccessIconWidget extends StatelessWidget {
  /// Size of the icon container
  final double size;
  
  /// Color of the checkmark
  final Color? checkmarkColor;
  
  /// Color of the circular background
  final Color? backgroundColor;

  const SuccessIconWidget({
    super.key,
    this.size = 80.0,
    this.checkmarkColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveCheckmarkColor = checkmarkColor ?? const Color(0xFF4CAF50);
    final effectiveBackgroundColor = backgroundColor ?? const Color(0xFFE8F5E9);

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: effectiveBackgroundColor,
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.check_circle,
        size: size * 0.6,
        color: effectiveCheckmarkColor,
      ),
    );
  }
}

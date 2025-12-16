import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../config/app_theme.dart';
import '../config/app_sizes.dart';

/// A scalable outlined button widget for secondary actions
/// Matches the design language of PremiumButton but with outlined style
class OutlinedButtonWidget extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final Color? borderColor;
  final Color? textColor;

  const OutlinedButtonWidget({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.borderColor,
    this.textColor,
  });

  @override
  State<OutlinedButtonWidget> createState() => _OutlinedButtonWidgetState();
}

class _OutlinedButtonWidgetState extends State<OutlinedButtonWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: AppTheme.animationDurationFast,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: AppTheme.animationCurveDefault,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    _animationController.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    _animationController.reverse();
  }

  void _handleTapCancel() {
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final effectiveBorderColor = widget.borderColor ?? AppTheme.primary600;
    final effectiveTextColor = widget.textColor ?? AppTheme.primary600;

    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      onTap: widget.onPressed,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          width: double.infinity,
          height: AppSizes.buttonHeight,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppSizes.buttonBorderRadius),
            border: Border.all(
              color: effectiveBorderColor,
              width: 1.5,
            ),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.onPressed,
              borderRadius: BorderRadius.circular(AppSizes.buttonBorderRadius),
              splashColor: effectiveBorderColor.withOpacity(0.1),
              highlightColor: effectiveBorderColor.withOpacity(0.05),
              child: Center(
                child: widget.isLoading
                    ? SizedBox(
                        width: AppSizes.buttonIconSize,
                        height: AppSizes.buttonIconSize,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            effectiveTextColor,
                          ),
                        ),
                      )
                    : Text(
                        widget.text,
                        style: GoogleFonts.inter(
                          fontSize: AppTheme.fontSizeMD,
                          fontWeight: AppTheme.fontWeightBold,
                          color: effectiveTextColor,
                          letterSpacing: AppTheme.letterSpacingWide,
                        ),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

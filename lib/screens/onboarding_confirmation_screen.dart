import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/success_icon_widget.dart';
import '../widgets/premium_button.dart';
import '../widgets/glass_card_widget.dart';
import '../config/app_theme.dart';
import '../config/app_copy.dart';

/// Modern confirmation screen after onboarding completion
/// Features a clean, scalable design with success icon and welcome message
/// Maintains consistent design language with previous steps
class OnboardingConfirmationScreen extends StatefulWidget {
  const OnboardingConfirmationScreen({super.key});

  @override
  State<OnboardingConfirmationScreen> createState() => _OnboardingConfirmationScreenState();
}

class _OnboardingConfirmationScreenState extends State<OnboardingConfirmationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: AppTheme.animationDurationPage,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.6, curve: AppTheme.animationCurveEaseOut),
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.2, 1.0, curve: AppTheme.animationCurveEaseOutCubic),
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.2, 1.0, curve: AppTheme.animationCurveEaseOutCubic),
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleGoToDashboard() {
    // Navigate to dashboard or home screen
    // For now, just show a message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Navigating to dashboard...'),
        duration: Duration(seconds: 2),
      ),
    );
    
    // Uncomment when dashboard screen is ready:
    // Navigator.of(context).pushReplacement(
    //   MaterialPageRoute(
    //     builder: (context) => const DashboardScreen(),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final isSmall = media.size.width < 380;
    final horizontalPadding =
        isSmall ? AppTheme.spacingLG : AppTheme.spacing2XL;
    final cardPadding =
        EdgeInsets.all(isSmall ? AppTheme.spacing3XL : AppTheme.spacing5XL);
    final titleSize =
        isSmall ? AppTheme.fontSize2XL : AppTheme.fontSize3XL;
    final bodySize =
        isSmall ? AppTheme.fontSizeSM : AppTheme.fontSizeMD;

    return Scaffold(
      backgroundColor: AppTheme.backgroundColorGrey100,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: GlassCardWidget(
                    borderRadius: AppTheme.cardBorderRadius,
                    padding: cardPadding,
                    opacity: 1.0,
                    blurIntensity: 0.0,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Success icon
                        const SuccessIconWidget(
                          size: 100.0,
                        ),
                        SizedBox(height: AppTheme.spacing4XL),
                        // Title
                        Text(
                          AppCopy.confirmationTitle,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontSize: titleSize,
                            fontWeight: AppTheme.fontWeightBold,
                            color: AppTheme.textPrimary,
                            letterSpacing: AppTheme.letterSpacingTight,
                            height: 1.2,
                          ),
                        ),
                        SizedBox(height: AppTheme.spacingLG),
                        // Description
                        Text(
                          AppCopy.confirmationDescription,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontSize: bodySize,
                            fontWeight: AppTheme.fontWeightRegular,
                            color: AppTheme.textSecondary,
                            letterSpacing: AppTheme.letterSpacingNormal,
                            height: 1.5,
                          ),
                        ),
                        SizedBox(height: AppTheme.spacing3XL),
                        // Motivational copy
                        Container(
                          padding: EdgeInsets.all(AppTheme.spacingXL),
                          decoration: BoxDecoration(
                            color: AppTheme.primary600.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
                            border: Border.all(
                              color: AppTheme.primary600.withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.celebration,
                                color: AppTheme.primary600,
                                size: 24,
                              ),
                              SizedBox(width: AppTheme.spacingMD),
                              Expanded(
                                child: Text(
                                  AppCopy.confirmationMotivation,
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.inter(
                                    fontSize: bodySize,
                                    fontWeight: AppTheme.fontWeightMedium,
                                    color: AppTheme.textPrimary,
                                    letterSpacing: AppTheme.letterSpacingNormal,
                                    height: 1.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: AppTheme.spacing5XL),
                        // Go to Dashboard button
                        PremiumButton(
                          text: AppCopy.goToDashboardButton,
                          onPressed: _handleGoToDashboard,
                        ),
                      ],
                    ),
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

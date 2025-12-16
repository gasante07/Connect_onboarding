import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/progress_indicator_widget.dart';
import '../widgets/labeled_text_field_widget.dart';
import '../widgets/premium_button.dart';
import '../widgets/glass_card_widget.dart';
import '../widgets/carousel_background_widget.dart';
import '../widgets/motivational_text_widget.dart';
import '../config/app_theme.dart';
import '../config/app_copy.dart';
import '../config/app_validation.dart';
import '../config/app_assets.dart';
import 'onboarding_step2_screen.dart';

/// Modern onboarding screen for account creation (Step 1 of 3)
/// Features a clean, scalable design with progress indicator and form fields
class OnboardingStep1Screen extends StatefulWidget {
  const OnboardingStep1Screen({super.key});

  @override
  State<OnboardingStep1Screen> createState() => _OnboardingStep1ScreenState();
}

class _OnboardingStep1ScreenState extends State<OnboardingStep1Screen>
    with SingleTickerProviderStateMixin {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
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
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleContinue() {
    if (_formKey.currentState!.validate()) {
      // Navigate to step 2
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const OnboardingStep2Screen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      body: CarouselBackgroundWidget(
        imagePaths: AppAssets.onboardingCarouselImages,
        overlayColor: Colors.black,
        overlayOpacity: AppTheme.overlayOpacityLight,
        child: SafeArea(
          child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: AppTheme.spacing2XL),
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: AppTheme.spacing3XL),
                  // Progress indicator
                  const ProgressIndicatorWidget(
                    currentStep: 1,
                    totalSteps: 3,
                  ),
                  SizedBox(height: AppTheme.spacing2XL),
                  // Motivational text
                  MotivationalTextWidget(
                    text: AppCopy.onboardingStep1Motivation,
                  ),
                  SizedBox(height: AppTheme.spacing4XL),
                  // Main form card
                  GlassCardWidget(
                    borderRadius: AppTheme.cardBorderRadius,
                    padding: EdgeInsets.all(AppTheme.spacing3XL),
                    opacity: 1.0,
                    blurIntensity: 0.0,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Title
                          Text(
                            AppCopy.onboardingStep1Title,
                            style: GoogleFonts.inter(
                              fontSize: AppTheme.fontSize3XL,
                              fontWeight: AppTheme.fontWeightBold,
                              color: AppTheme.textPrimary,
                              letterSpacing: AppTheme.letterSpacingTight,
                              height: 1.2,
                            ),
                          ),
                          SizedBox(height: AppTheme.spacingMD),
                          // Subtitle
                          Text(
                            AppCopy.onboardingStep1Subtitle,
                            style: GoogleFonts.inter(
                              fontSize: AppTheme.fontSizeMD,
                              fontWeight: AppTheme.fontWeightRegular,
                              color: AppTheme.textSecondary,
                              letterSpacing: AppTheme.letterSpacingNormal,
                              height: 1.5,
                            ),
                          ),
                          SizedBox(height: AppTheme.spacing5XL),
                          // Email field
                          LabeledTextFieldWidget(
                            label: AppCopy.emailAddressLabel,
                            hintText: AppCopy.emailAddressPlaceholder,
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: AppValidation.getEmailError,
                            icon: Icons.email_outlined,
                          ),
                          SizedBox(height: AppTheme.spacing3XL),
                          // Password field
                          LabeledTextFieldWidget(
                            label: AppCopy.passwordLabel,
                            hintText: AppCopy.passwordPlaceholderOnboarding,
                            controller: _passwordController,
                            isPassword: true,
                            validator: AppValidation.getPasswordError,
                            icon: Icons.lock_outlined,
                          ),
                          SizedBox(height: AppTheme.spacing5XL),
                          // Continue button
                          PremiumButton(
                            text: AppCopy.continueButton,
                            onPressed: _handleContinue,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: AppTheme.spacing4XL),
                ],
              ),
            ),
          ),
        ),
      ),
      ),
    );
  }
}

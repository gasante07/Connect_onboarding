import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/progress_indicator_widget.dart';
import '../widgets/labeled_text_field_widget.dart';
import '../widgets/premium_button.dart';
import '../widgets/outlined_button_widget.dart';
import '../widgets/glass_card_widget.dart';
import '../widgets/carousel_background_widget.dart';
import '../widgets/motivational_text_widget.dart';
import '../config/app_theme.dart';
import '../config/app_copy.dart';
import '../config/app_assets.dart';
import '../config/app_validation.dart';
import 'onboarding_step3_screen.dart';

/// Modern onboarding screen for user profile information (Step 2 of 3)
/// Features a clean, scalable design with progress indicator and form fields
/// Maintains consistent design language with Step 1
class OnboardingStep2Screen extends StatefulWidget {
  const OnboardingStep2Screen({super.key});

  @override
  State<OnboardingStep2Screen> createState() => _OnboardingStep2ScreenState();
}

class _OnboardingStep2ScreenState extends State<OnboardingStep2Screen>
    with SingleTickerProviderStateMixin {
  final _usernameController = TextEditingController();
  final _cityController = TextEditingController();
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
    _usernameController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  void _handleBack() {
    Navigator.of(context).pop();
  }

  void _handleContinue() {
    if (_formKey.currentState!.validate()) {
      // Navigate to step 3
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const OnboardingStep3Screen(),
        ),
      );
    }
  }

  String? _validateUsername(String? value) {
    return AppValidation.getUsernameError(value);
  }

  String? _validateCity(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your city';
    }
    return null;
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
                    currentStep: 2,
                    totalSteps: 3,
                  ),
                  SizedBox(height: AppTheme.spacing2XL),
                  // Motivational text
                  MotivationalTextWidget(
                    text: AppCopy.onboardingStep2Motivation,
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
                            AppCopy.onboardingStep2Title,
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
                            AppCopy.onboardingStep2Subtitle,
                            style: GoogleFonts.inter(
                              fontSize: AppTheme.fontSizeMD,
                              fontWeight: AppTheme.fontWeightRegular,
                              color: AppTheme.textSecondary,
                              letterSpacing: AppTheme.letterSpacingNormal,
                              height: 1.5,
                            ),
                          ),
                          SizedBox(height: AppTheme.spacing5XL),
                          // Username field
                          LabeledTextFieldWidget(
                            label: AppCopy.usernameLabel,
                            hintText: AppCopy.usernamePlaceholder,
                            controller: _usernameController,
                            keyboardType: TextInputType.text,
                            validator: _validateUsername,
                            icon: Icons.person_outlined,
                          ),
                          SizedBox(height: AppTheme.spacing3XL),
                          // City field
                          LabeledTextFieldWidget(
                            label: AppCopy.cityLabel,
                            hintText: AppCopy.cityPlaceholder,
                            controller: _cityController,
                            keyboardType: TextInputType.text,
                            validator: _validateCity,
                            icon: Icons.location_city_outlined,
                          ),
                          SizedBox(height: AppTheme.spacing5XL),
                          // Navigation buttons
                          Row(
                            children: [
                              // Back button
                              Expanded(
                                child: OutlinedButtonWidget(
                                  text: AppCopy.backButton,
                                  onPressed: _handleBack,
                                ),
                              ),
                              SizedBox(width: AppTheme.spacingLG),
                              // Continue button
                              Expanded(
                                child: PremiumButton(
                                  text: AppCopy.continueButton,
                                  onPressed: _handleContinue,
                                ),
                              ),
                            ],
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

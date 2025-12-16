import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/progress_indicator_widget.dart';
import '../widgets/premium_button.dart';
import '../widgets/outlined_button_widget.dart';
import '../widgets/glass_card_widget.dart';
import '../widgets/sport_selection_item_widget.dart';
import '../widgets/carousel_background_widget.dart';
import '../widgets/motivational_text_widget.dart';
import '../config/app_theme.dart';
import '../config/app_copy.dart';
import '../config/app_assets.dart';
import '../config/sports_data.dart';
import 'onboarding_confirmation_screen.dart';

/// Modern onboarding screen for sport selection (Step 3 of 3)
/// Features a clean, scalable design with progress indicator and sport selection
/// Maintains consistent design language with previous steps
class OnboardingStep3Screen extends StatefulWidget {
  const OnboardingStep3Screen({super.key});

  @override
  State<OnboardingStep3Screen> createState() => _OnboardingStep3ScreenState();
}

class _OnboardingStep3ScreenState extends State<OnboardingStep3Screen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  
  // Map to store sport ratings (0-3) - initialized from SportsData
  late final Map<String, int> _sportRatings = SportsData.initializeRatings();
  
  // Sport icons - initialized from SportsData
  late final Map<String, String> _sportIcons = SportsData.initializeIcons();

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
    super.dispose();
  }

  void _handleBack() {
    Navigator.of(context).pop();
  }

  void _handleRegister() {
    // Get selected sports (sports with rating > 0)
    final selectedSports = _sportRatings.entries
        .where((entry) => entry.value > 0)
        .map((entry) => entry.key)
        .toList();
    
    if (selectedSports.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select at least one sport'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }
    
    // Navigate to confirmation screen
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const OnboardingConfirmationScreen(),
      ),
    );
  }

  void _handleRatingChanged(String sportName, int rating) {
    setState(() {
      _sportRatings[sportName] = rating;
    });
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
          child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Column(
              children: [
                // Top section with progress indicator
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppTheme.spacing2XL),
                  child: Column(
                    children: [
                      SizedBox(height: AppTheme.spacing3XL),
                      // Progress indicator
                      const ProgressIndicatorWidget(
                        currentStep: 3,
                        totalSteps: 3,
                      ),
                      SizedBox(height: AppTheme.spacing2XL),
                      // Motivational text
                      MotivationalTextWidget(
                        text: AppCopy.onboardingStep3Motivation,
                      ),
                      SizedBox(height: AppTheme.spacing4XL),
                    ],
                  ),
                ),
                // Main content card with scrollable list
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppTheme.spacing2XL),
                    child: GlassCardWidget(
                      borderRadius: AppTheme.cardBorderRadius,
                      padding: EdgeInsets.all(AppTheme.spacing3XL),
                      opacity: 1.0,
                      blurIntensity: 0.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title
                          Text(
                            AppCopy.onboardingStep3Title,
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
                            AppCopy.onboardingStep3Subtitle,
                            style: GoogleFonts.inter(
                              fontSize: AppTheme.fontSizeMD,
                              fontWeight: AppTheme.fontWeightRegular,
                              color: AppTheme.textSecondary,
                              letterSpacing: AppTheme.letterSpacingNormal,
                              height: 1.5,
                            ),
                          ),
                          SizedBox(height: AppTheme.spacing5XL),
                          // Scrollable sport list
                          Expanded(
                            child: ListView.builder(
                              itemCount: _sportRatings.length,
                              itemBuilder: (context, index) {
                                final sportName = _sportRatings.keys.elementAt(index);
                                final rating = _sportRatings[sportName]!;
                                final icon = _sportIcons[sportName]!;
                                
                                return SportSelectionItemWidget(
                                  sportName: sportName,
                                  icon: icon,
                                  rating: rating,
                                  onRatingChanged: (newRating) {
                                    _handleRatingChanged(sportName, newRating);
                                  },
                                );
                              },
                            ),
                          ),
                          SizedBox(height: AppTheme.spacing3XL),
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
                              // Register button
                              Expanded(
                                child: PremiumButton(
                                  text: AppCopy.registerButton,
                                  onPressed: _handleRegister,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: AppTheme.spacing2XL),
              ],
            ),
          ),
        ),
      ),
      ),
    );
  }
}

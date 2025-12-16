import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/premium_input_field.dart';
import '../widgets/social_login_button.dart';
import '../widgets/premium_button.dart';
import '../widgets/logo_widget.dart';
import '../widgets/carousel_background_widget.dart';
import '../widgets/landing_copy_widget.dart';
import '../widgets/glass_card_widget.dart';
import '../config/app_theme.dart';
import '../config/app_copy.dart';
import '../config/app_validation.dart';
import '../config/app_assets.dart';
import 'onboarding_step1_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
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
      begin: const Offset(0, 0.3),
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

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      // Handle login logic here
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppCopy.loginNotImplemented),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final isSmall = media.size.width < 380;
    final horizontalPadding =
        isSmall ? AppTheme.spacingLG : AppTheme.spacing2XL;
    final cardPadding =
        EdgeInsets.all(isSmall ? AppTheme.spacing3XL : AppTheme.spacing4XL);
    final titleSize =
        isSmall ? AppTheme.fontSizeXL : AppTheme.fontSize2XL;
    final bodySize =
        isSmall ? AppTheme.fontSizeSM : AppTheme.fontSizeMD;
    final topSpacing =
        isSmall ? AppTheme.spacing3XL : AppTheme.spacing4XL;

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      body: CarouselBackgroundWidget(
        imagePaths: AppAssets.onboardingCarouselImages,
        overlayColor: Colors.black,
        overlayOpacity: AppTheme.overlayOpacityDark,
        imagesPerCollage: media.size.width < 500 ? 2 : 4,
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: topSpacing),
                        LogoWidget.small(),
                        SizedBox(height: AppTheme.spacing3XL),
                        // Clean copy
                        const LandingCopyWidget(),
                        SizedBox(height: AppTheme.spacing5XL),
                        // Modern form card
                        GlassCardWidget(
                          borderRadius: AppTheme.cardBorderRadius,
                          padding: cardPadding,
                          opacity: 1.0,
                          blurIntensity: 0.0,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Form title
                              Text(
                                'Welcome back',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                  fontSize: titleSize,
                                  fontWeight: AppTheme.fontWeightBold,
                                  color: AppTheme.textPrimary,
                                  letterSpacing: AppTheme.letterSpacingTight,
                                  height: 1.2,
                                ),
                              ),
                              SizedBox(height: AppTheme.spacingSM),
                              Text(
                                'Sign in to continue',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                  fontSize: bodySize,
                                  fontWeight: AppTheme.fontWeightRegular,
                                  color: AppTheme.textSecondary,
                                  letterSpacing: AppTheme.letterSpacingNormal,
                                ),
                              ),
                              SizedBox(height: AppTheme.spacing4XL),
                              // Email field
                              PremiumInputField(
                                controller: _emailController,
                                hintText: AppCopy.emailHint,
                                icon: Icons.email_outlined,
                                keyboardType: TextInputType.emailAddress,
                                validator: AppValidation.getEmailError,
                              ),
                              SizedBox(height: AppTheme.spacingXL),
                              // Password field
                              PremiumInputField(
                                controller: _passwordController,
                                hintText: AppCopy.passwordHint,
                                icon: Icons.lock_outline,
                                isPassword: true,
                                validator: AppValidation.getPasswordError,
                              ),
                              SizedBox(height: AppTheme.spacingMD),
                              // Forgot password
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {
                                    // Handle forgot password
                                  },
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: AppTheme.spacingSM,
                                      vertical: AppTheme.spacingXS,
                                    ),
                                    minimumSize: Size.zero,
                                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  child: Text(
                                    AppCopy.forgotPassword,
                                    style: GoogleFonts.inter(
                                      fontSize: AppTheme.fontSizeSM,
                                      fontWeight: AppTheme.fontWeightSemiBold,
                                      color: AppTheme.primary600,
                                      letterSpacing: AppTheme.letterSpacingNormal,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: AppTheme.spacing3XL),
                              // Login button
                              PremiumButton(
                                text: AppCopy.loginButton,
                                onPressed: _handleLogin,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: AppTheme.spacing3XL),
                        // Social login section
                        Text(
                          AppCopy.socialLoginDivider,
                          style: GoogleFonts.inter(
                            fontSize: AppTheme.fontSizeSM,
                            color: AppTheme.textWhite,
                            fontWeight: AppTheme.fontWeightMedium,
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(0.5),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: AppTheme.spacingLG),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SocialLoginButton(
                              icon: Icons.g_mobiledata,
                              onPressed: () {
                                // Handle Google login
                              },
                            ),
                            SizedBox(width: AppTheme.spacingLG),
                            SocialLoginButton(
                              icon: Icons.facebook,
                              onPressed: () {
                                // Handle Facebook login
                              },
                            ),
                            SizedBox(width: AppTheme.spacingLG),
                            SocialLoginButton(
                              icon: Icons.favorite,
                              onPressed: () {
                                // Handle other login
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: AppTheme.spacing3XL),
                        // Sign up section
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppCopy.signUpPrompt,
                              style: GoogleFonts.inter(
                                fontSize: AppTheme.fontSizeSM,
                                color: AppTheme.textWhite,
                                shadows: [
                                  Shadow(
                                    color: Colors.black.withOpacity(0.5),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                // Navigate to onboarding step 1
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const OnboardingStep1Screen(),
                                  ),
                                );
                              },
                              child: Text(
                                AppCopy.signUpLink,
                                style: GoogleFonts.inter(
                                  fontSize: AppTheme.fontSizeSM,
                                  fontWeight: AppTheme.fontWeightSemiBold,
                                  color: AppTheme.primary700,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black.withOpacity(0.3),
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: AppTheme.spacing2XL),
                        Text(
                          AppCopy.appVersion,
                          style: GoogleFonts.inter(
                            fontSize: AppTheme.fontSizeXS,
                            color: AppTheme.textWhite.withOpacity(0.9),
                            fontWeight: AppTheme.fontWeightRegular,
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(0.5),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
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
        ),
      ),
    );
  }
}


/// Centralized copy/text content for the app
/// This makes it easy to manage and update all text content across the app
/// All copy should be defined here for scalability and easy localization
class AppCopy {
  AppCopy._(); // Private constructor to prevent instantiation

  // ==================== Landing Page ====================
  
  /// Main headline for the landing page
  static const String landingHeadline = 'Your Local Sports Community';
  
  /// Subheadline/description for the landing page
  static const String landingSubheadline = 
      'Discover and organize sports activities in your area. Connect with athletes, join games, and stay active.';
  
  /// Tagline or value proposition
  static const String landingTagline = 'Where Sports Meet Community';

  // ==================== Login Screen ====================
  
  /// Email input placeholder
  static const String emailHint = 'Email';
  
  /// Password input placeholder
  static const String passwordHint = 'Password';
  
  /// Forgot password link text
  static const String forgotPassword = 'Forgot password?';
  
  /// Login button text
  static const String loginButton = 'Log In';
  
  /// Social login divider text
  static const String socialLoginDivider = 'Or log in with';
  
  /// Sign up prompt text
  static const String signUpPrompt = "Don't have an account? ";
  
  /// Sign up link text
  static const String signUpLink = 'Sign up';
  
  /// Get started call to action
  static const String getStarted = 'Get Started';
  
  /// Join the community text
  static const String joinCommunity = 'Join thousands of athletes in your area';

  // ==================== Onboarding Screen ====================
  
  /// Onboarding step 1 title
  static const String onboardingStep1Title = 'Create your account';
  
  /// Onboarding step 1 subtitle
  static const String onboardingStep1Subtitle = 
      "Let's start with the basics. We'll have you set up in no time.";
  
  /// Motivational copy for step 1
  static const String onboardingStep1Motivation = 
      'Join thousands of athletes in your area. Discover games, organize matches, and build your sports community.';
  
  /// Email address label
  static const String emailAddressLabel = 'Email address';
  
  /// Email address placeholder
  static const String emailAddressPlaceholder = 'you@example.com';
  
  /// Password label
  static const String passwordLabel = 'Password';
  
  /// Password placeholder for onboarding
  static const String passwordPlaceholderOnboarding = 'At least 8 characters';
  
  /// Continue button text
  static const String continueButton = 'Continue';
  
  /// Back button text
  static const String backButton = 'Back';
  
  /// Onboarding step 2 title
  static const String onboardingStep2Title = 'Tell us about yourself';
  
  /// Onboarding step 2 subtitle
  static const String onboardingStep2Subtitle = 
      'This helps us personalize your experience and connect you with local athletes.';
  
  /// Motivational copy for step 2
  static const String onboardingStep2Motivation = 
      'Connect with players who share your passion. Find your perfect match and start playing today!';
  
  /// Username label
  static const String usernameLabel = 'Username';
  
  /// Username placeholder
  static const String usernamePlaceholder = 'Choose a unique username.';
  
  /// City label
  static const String cityLabel = 'City';
  
  /// City placeholder
  static const String cityPlaceholder = 'Where are you based?';
  
  /// Onboarding step 3 title
  static const String onboardingStep3Title = 'What sports do you play?';
  
  /// Onboarding step 3 subtitle
  static const String onboardingStep3Subtitle = 
      'Select all the recreational sports you enjoy. You can always add more later.';
  
  /// Motivational copy for step 3
  static const String onboardingStep3Motivation = 
      'Your journey to an active lifestyle starts here. Get ready to play, compete, and have fun!';
  
  /// Register button text
  static const String registerButton = 'Register';
  
  /// Confirmation screen title
  static const String confirmationTitle = 'Welcome to GameOn Active! 🥳';
  
  /// Confirmation screen description
  static const String confirmationDescription = 
      'Your account has been created successfully. Get ready to connect with athletes in your area!';
  
  /// Confirmation screen motivational copy
  static const String confirmationMotivation = 
      'You\'re all set! Start discovering games, organizing matches, and connecting with players who share your passion. Your active lifestyle journey begins now!';
  
  /// Go to dashboard button text
  static const String goToDashboardButton = 'Go to Dashboard';

  // ==================== Validation Messages ====================
  
  /// Email validation - empty
  static const String emailRequired = 'Please enter your email';
  
  /// Email validation - invalid format
  static const String emailInvalid = 'Please enter a valid email';
  
  /// Password validation - empty
  static const String passwordRequired = 'Please enter your password';
  
  /// Password validation - too short
  static const String passwordTooShort = 'Password must be at least 6 characters';

  // ==================== Features/Benefits ====================
  
  /// Feature 1 title
  static const String feature1Title = 'Discover Activities';
  
  /// Feature 1 description
  static const String feature1Description = 'Find sports events and games happening near you';
  
  /// Feature 2 title
  static const String feature2Title = 'Organize Games';
  
  /// Feature 2 description
  static const String feature2Description = 'Create and manage your own sports activities';
  
  /// Feature 3 title
  static const String feature3Title = 'Connect & Play';
  
  /// Feature 3 description
  static const String feature3Description = 'Meet local athletes and build your sports community';

  // ==================== System Messages ====================
  
  /// Login functionality not implemented message
  static const String loginNotImplemented = 'Login functionality to be implemented';
  
  /// App version
  static const String appVersion = 'v0.0059';
  
  /// App name/title
  static const String appName = 'GAMEON ACTIVE';
  
  /// App description
  static const String appDescription = 'A premium Flutter app for GAMEON ACTIVE';
}

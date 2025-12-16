/// Centralized asset path configuration
/// This makes it easy to manage and update asset paths across the app
class AppAssets {
  AppAssets._(); // Private constructor to prevent instantiation

  // Base paths
  static const String imagesBasePath = 'assets/images';

  // Background images
  static const String volleyballBackground = '$imagesBasePath/volleyball background.jpeg';
  static const String volleyball2 = '$imagesBasePath/volleyball 2.jpeg';
  static const String volleyball3 = '$imagesBasePath/volleyball 3.jpeg';
  static const String basketball = '$imagesBasePath/basketball.jpeg';
  static const String bball1 = '$imagesBasePath/bball1.jpeg';
  static const String baseball = '$imagesBasePath/baseball.jpeg';
  static const String rugby = '$imagesBasePath/rugby.jpeg';
  static const String soccer = '$imagesBasePath/soccer.jpeg';
  static const String tennis1 = '$imagesBasePath/tennis 1.jpeg';
  static const String tennis2 = '$imagesBasePath/tennis 2.jpeg';
  static const String tennis3 = '$imagesBasePath/tennis 3.jpeg';
  
  // Onboarding carousel images - all available sports images for collage
  // Organized for maximum variety in collage combinations
  static List<String> get onboardingCarouselImages => [
    // Volleyball images
    volleyball2,
    volleyball3,
    volleyballBackground,
    // Basketball images
    basketball,
    bball1,
    // Tennis images
    tennis1,
    tennis2,
    tennis3,
    // Other sports
    baseball,
    rugby,
    soccer,
  ];

  // Logo images
  static const String logoWhite = '$imagesBasePath/logo-white.png';
}

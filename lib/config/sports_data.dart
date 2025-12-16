/// Centralized sports data configuration
/// This makes it easy to manage and update sports list across the app
class SportsData {
  SportsData._(); // Private constructor to prevent instantiation

  /// List of available sports with their display names and icons
  static const List<Map<String, String>> sports = [
    {'name': 'Basketball', 'icon': '🏀'},
    {'name': 'Football', 'icon': '⚽'},
    {'name': 'Badminton', 'icon': '🏸'},
    {'name': 'Tennis', 'icon': '🎾'},
    {'name': 'Fitness Class', 'icon': '🏃'},
    {'name': 'Netball', 'icon': '🏐'},
    {'name': 'Volleyball', 'icon': '🏐'},
  ];

  /// Get sport names as a list
  static List<String> get sportNames => 
      sports.map((sport) => sport['name']!).toList();

  /// Get sport icon by name
  static String? getSportIcon(String sportName) {
    try {
      return sports.firstWhere(
        (sport) => sport['name'] == sportName,
      )['icon'];
    } catch (e) {
      return null;
    }
  }

  /// Initialize ratings map with all sports set to 0
  static Map<String, int> initializeRatings() {
    return Map.fromEntries(
      sportNames.map((name) => MapEntry(name, 0)),
    );
  }

  /// Initialize icons map
  static Map<String, String> initializeIcons() {
    return Map.fromEntries(
      sports.map((sport) => MapEntry(
        sport['name']!,
        sport['icon']!,
      )),
    );
  }
}

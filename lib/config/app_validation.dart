/// Centralized validation constants and rules
/// This makes it easy to update validation rules across the app
class AppValidation {
  AppValidation._(); // Private constructor to prevent instantiation

  // Password validation
  static const int passwordMinLength = 8;
  static const int passwordMaxLength = 128;

  // Username validation
  static const int usernameMinLength = 3;
  static const int usernameMaxLength = 20;

  // Email validation (handled by regex in getEmailError)

  // Validation error messages
  static String? getEmailError(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
  }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }
  
  static String? getPasswordError(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < passwordMinLength) {
      return 'Password must be at least $passwordMinLength characters';
    }
    if (value.length > passwordMaxLength) {
      return 'Password must be less than $passwordMaxLength characters';
    }
    return null;
  }
  
  static String? getUsernameError(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a username';
    }
    if (value.length < usernameMinLength) {
      return 'Username must be at least $usernameMinLength characters';
    }
    if (value.length > usernameMaxLength) {
      return 'Username must be less than $usernameMaxLength characters';
    }
    return null;
  }
}

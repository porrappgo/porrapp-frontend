/*
  Util functions for format validation
*/
class FormatValidator {
  // Validate email format
  static bool isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  // Return error message if email is invalid, otherwise null.
  static String? isValidEmailReturnErrorMessage(String email) {
    if (email.isEmpty) {
      return 'Email cannot be empty';
    }
    if (!isValidEmail(email)) {
      return 'Invalid email format';
    }
    return null;
  }

  // Validate password strength
  static bool isValidPassword(String password) {
    // At least 8 characters.
    if (password.length < 8) return false;
    return true;
  }

  // Return error message if password is invalid, otherwise null.
  static String? isValidPasswordReturnErrorMessage(String password) {
    if (password.isEmpty) {
      return 'Password cannot be empty';
    }
    if (!isValidPassword(password)) {
      return 'Password must be at least 8 characters long.';
    }
    return null;
  }

  // Check if passwords match
  static String? doPasswordsMatch(String password, String confirmPassword) {
    if (password != confirmPassword) {
      return 'Passwords do not match';
    }
    return null;
  }

  // Validate name
  static String? isValidName(String name) {
    if (name.isEmpty) {
      return 'Name cannot be empty';
    }
    if (name.length < 2) {
      return 'Name must be at least 2 characters long';
    }
    return null;
  }
}

class FormValidators {
  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter an email address';
    }
// Define a regular expression for a basic email pattern
    final RegExp emailRegex = RegExp(
      r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$',
    );

    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }

    // Return null if the email is valid
    return null;
  }

  String? validateFullName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your full name';
    }

    // Split the full name into separate words
    List<String> nameParts = value.split(' ');

    // Check if there are at least two words (first name and last name)
    if (nameParts.length < 2) {
      return 'Please enter your full first and last name';
    }

    // Return null if the full name is valid
    return null;
  }

  String? validatePhoneNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your phone number';
    }

    // Remove any non-digit characters from the phone number
    String digits = value.replaceAll(RegExp(r'\D'), '');

    // Check if the resulting string has at least 10 digits
    if (digits.length != 10) {
      return 'Please enter a valid 10-digit phone number';
    }

    // Return null if the phone number is considered valid
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }

    // Add any specific password criteria you require
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }

    // Return null if the password is considered valid
    return null;
  }

  String? validateConfirmPassword(String? value, String? password) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }

    // Check if the confirm password matches the original password
    if (value != password) {
      return 'Passwords do not match';
    }

    // Return null if the confirm password is considered valid
    return null;
  }
}

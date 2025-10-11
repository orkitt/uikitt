part of 'package:orkitt/orkitt.dart';

/// A utility class that provides common form field validators.
/// All validators return `null` if the input is valid, otherwise return a string error message.
class Validator {
  /// Validates that the field is not empty.
  static String? required(String? value, {String fieldName = 'This field'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  /// Validates if the input is a valid email address.
  static String? email(String? value) {
    if (value == null || value.isEmpty) return 'Email is required';

    // More comprehensive email regex
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
    );

    if (!emailRegex.hasMatch(value.trim())) {
      return 'Please enter a valid email address';
    }

    // Additional checks for common issues
    if (value.contains('..')) return 'Email contains consecutive dots';
    if (value.startsWith('.') || value.endsWith('.')) {
      return 'Email cannot start or end with a dot';
    }

    return null;
  }

  /// Validates a strong password with optional rules.
  static String? password(
    String? value, {
    int minLength = 8,
    bool requireSpecialChar = true,
    bool requireUppercase = true,
    bool requireLowercase = true,
    bool requireNumber = true,
  }) {
    if (value == null || value.isEmpty) return 'Password is required';

    if (value.length < minLength) {
      return 'Password must be at least $minLength characters';
    }

    if (requireUppercase && !RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    }

    if (requireLowercase && !RegExp(r'[a-z]').hasMatch(value)) {
      return 'Password must contain at least one lowercase letter';
    }

    if (requireNumber && !RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password must contain at least one number';
    }

    if (requireSpecialChar &&
        !RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'Password must contain at least one special character';
    }

    // Check for common weak patterns
    if (RegExp(
      r'^(123456|password|admin|qwerty|111111|abc123)',
    ).hasMatch(value.toLowerCase())) {
      return 'Password is too common, please choose a stronger one';
    }

    return null;
  }

  /// Validates that the input is a valid phone number.
  static String? phone(String? value, {int min = 8, int max = 15}) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required';
    }

    final cleaned = value.replaceAll(RegExp(r'[\s\-\(\)\+]'), '');

    if (cleaned.length < min) {
      return 'Phone number must be at least $min digits';
    }

    if (cleaned.length > max) {
      return 'Phone number must be at most $max digits';
    }

    if (!RegExp(r'^[0-9]+$').hasMatch(cleaned)) {
      return 'Phone number can only contain digits and formatting characters';
    }

    return null;
  }

  /// Validates that the input is a number.
  static String? number(String? value, {double? min, double? max}) {
    if (value == null || value.trim().isEmpty) return 'This field is required';

    final number = double.tryParse(value);
    if (number == null) return 'Invalid number';

    if (min != null && number < min) {
      return 'Number must be at least $min';
    }

    if (max != null && number > max) {
      return 'Number must be at most $max';
    }

    return null;
  }

  /// Validates that two fields are equal (e.g., password and confirm password).
  static String? match(
    String? value,
    String? otherValue, {
    String fieldName = 'Fields',
  }) {
    if (value == null || otherValue == null) return '$fieldName are required';
    if (value != otherValue) return '$fieldName do not match';
    return null;
  }

  /// Validates that the input meets a minimum length.
  static String? minLength(
    String? value,
    int length, {
    String fieldName = 'This field',
  }) {
    if (value == null || value.length < length) {
      return '$fieldName must be at least $length characters';
    }
    return null;
  }

  /// Validates that the input does not exceed a maximum length.
  static String? maxLength(
    String? value,
    int length, {
    String fieldName = 'This field',
  }) {
    if (value != null && value.length > length) {
      return '$fieldName must be at most $length characters';
    }
    return null;
  }

  /// Validates that the input is a valid URL.
  static String? url(String? value, {bool requireHttps = false}) {
    if (value == null || value.isEmpty) return 'URL is required';

    try {
      final uri = Uri.parse(value);
      if (!uri.isAbsolute) return 'Please enter a complete URL';

      if (requireHttps && !uri.scheme.startsWith('https')) {
        return 'URL must use HTTPS';
      }

      return null;
    } catch (e) {
      return 'Invalid URL format';
    }
  }

  /// Validates that the input contains only alphabetic characters.
  static String? alphabetic(String? value, {String fieldName = 'This field'}) {
    if (value == null || value.isEmpty) return '$fieldName is required';
    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
      return '$fieldName can only contain letters and spaces';
    }
    return null;
  }

  /// Validates that the input contains only alphanumeric characters.
  static String? alphanumeric(
    String? value, {
    String fieldName = 'This field',
  }) {
    if (value == null || value.isEmpty) return '$fieldName is required';
    if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value)) {
      return '$fieldName can only contain letters and numbers';
    }
    return null;
  }

  /// Validates a credit card number using Luhn algorithm.
  static String? creditCard(String? value) {
    if (value == null || value.isEmpty) return 'Credit card number is required';

    final cleaned = value.replaceAll(RegExp(r'[\s\-]'), '');

    if (!RegExp(r'^[0-9]{13,19}$').hasMatch(cleaned)) {
      return 'Invalid credit card number length';
    }

    // Luhn algorithm
    int sum = 0;
    bool alternate = false;
    for (int i = cleaned.length - 1; i >= 0; i--) {
      int digit = int.parse(cleaned[i]);
      if (alternate) {
        digit *= 2;
        if (digit > 9) digit -= 9;
      }
      sum += digit;
      alternate = !alternate;
    }

    return (sum % 10 == 0) ? null : 'Invalid credit card number';
  }

  /// Validates a date string in various formats.
  static String? date(String? value, {String format = 'yyyy-MM-dd'}) {
    if (value == null || value.isEmpty) return 'Date is required';

    try {
      final date = DateTime.parse(value);
      if (date.isAfter(DateTime.now())) {
        return 'Date cannot be in the future';
      }
      return null;
    } catch (e) {
      return 'Invalid date format. Use $format';
    }
  }

  /// Validates that the input is a valid username.
  static String? username(
    String? value, {
    int minLength = 3,
    int maxLength = 20,
  }) {
    if (value == null || value.isEmpty) return 'Username is required';

    if (value.length < minLength) {
      return 'Username must be at least $minLength characters';
    }

    if (value.length > maxLength) {
      return 'Username must be at most $maxLength characters';
    }

    if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value)) {
      return 'Username can only contain letters, numbers, and underscores';
    }

    if (RegExp(r'^[0-9]').hasMatch(value)) {
      return 'Username cannot start with a number';
    }

    return null;
  }

  /// Validates a postal/zip code.
  static String? postalCode(String? value, {String country = 'US'}) {
    if (value == null || value.isEmpty) return 'Postal code is required';

    final cleaned = value.toUpperCase().replaceAll(' ', '');

    switch (country) {
      case 'US':
        if (!RegExp(r'^\d{5}(-\d{4})?$').hasMatch(cleaned)) {
          return 'Invalid US zip code format';
        }
        break;
      case 'CA':
        if (!RegExp(r'^[A-Z]\d[A-Z]\d[A-Z]\d$').hasMatch(cleaned)) {
          return 'Invalid Canadian postal code format';
        }
        break;
      default:
        if (cleaned.length < 3) return 'Invalid postal code';
    }

    return null;
  }

  /// Validates that the input is within a specific range.
  static String? range(
    String? value, {
    required num min,
    required num max,
    String fieldName = 'Value',
  }) {
    final numberError = number(value);
    if (numberError != null) return numberError;

    final numValue = num.parse(value!);
    if (numValue < min || numValue > max) {
      return '$fieldName must be between $min and $max';
    }

    return null;
  }

  /// Validates that the input doesn't contain profanity or restricted words.
  static String? noProfanity(
    String? value, {
    List<String> blockedWords = const [],
  }) {
    if (value == null || value.isEmpty) return null;

    final profanityPatterns = [
      ...blockedWords,
      'badword', 'profanity', // Add your own list
    ];

    for (final pattern in profanityPatterns) {
      if (value.toLowerCase().contains(pattern.toLowerCase())) {
        return 'Content contains inappropriate language';
      }
    }

    return null;
  }
}

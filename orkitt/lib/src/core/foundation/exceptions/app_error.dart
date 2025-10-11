part of 'package:orkitt/orkitt.dart';

// Base Error class
class AppError {
  final String error;
  final Exception? exception;
  AppError({required this.error, this.exception});
}

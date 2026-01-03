import 'package:flutter/material.dart';
/// Simple abstraction for creating custom error screens
///
/// Extend this class and override only the methods you need
/// to create custom error screens with minimal boilerplate
abstract class OrkittError extends StatelessWidget {
  final FlutterErrorDetails errorDetails;

  const OrkittError({super.key, required this.errorDetails});

  /// Simplified error message for display
  String get errorMessage => errorDetails.exception.toString();

  /// User-friendly version of the error message
  String get getErrorMessage {
    final message = errorMessage;
    if (message.length > 100) {
      return '${message.substring(0, 100)}...';
    }
    return message;
  }

  /// Main content of the error screen - override this
  Widget buildErrorContent(BuildContext context, FlutterErrorDetails error);

  /// Retry action function - override for custom retry logic
  void retryAction(BuildContext context) {}

  /// Report action function - override for custom report logic
  void reportAction(FlutterErrorDetails error) {
    debugPrint('Error reported: ${error.exception}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: buildErrorContent(context, errorDetails),
        ),
      ),
    );
  }
}

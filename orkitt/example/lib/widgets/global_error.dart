import 'package:flutter/material.dart';
import 'package:orkitt/orkitt.dart';

class GlobalError extends OrkittError {
  const GlobalError({super.key, required super.errorDetails});

  @override
  Widget buildErrorContent(BuildContext context, FlutterErrorDetails error) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.error_outline, size: 64, color: Colors.red),
        const SizedBox(height: 20),
        const Text(
          'Something went wrong',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text(
          getErrorMessage,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
        const SizedBox(height: 30),
        // User creates their own button and uses retryAction
        ElevatedButton(
          onPressed: () => reportAction(error),
          child: const Text('Debug Print'),
        ),
      ],
    );
  }
}

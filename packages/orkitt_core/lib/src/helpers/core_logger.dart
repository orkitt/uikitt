import 'package:orkitt_foundation/orkitt_foundation.dart';

OrkittLogger? _logger;

void setLogger(OrkittLogger logger) {
  _logger = logger;
}

void logInfo(String message) {
  _logger?.info(message);
}

import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as p;

/// Load snippets from JSON file and interpolate variables.
///
/// - [relativePath] : Path relative to the CLI package lib folder,
///   e.g., 'snippets/snippets.json'.
/// - [variables] : Map of placeholders to replace in the content.
///   For example: {'AppName': 'MyApp', 'feature': 'auth'}
///
/// Returns a map of snippet key -> snippet content with variables replaced.
Map<String, String> loadSnippets(String relativePath,
    {required Map<String, String> variables}) {
  final file = _getPackageFile(relativePath);

  final jsonStr = file.readAsStringSync();
  final data = jsonDecode(jsonStr) as Map<String, dynamic>;

  final Map<String, String> snippets = {};

  data.forEach((key, value) {
    var content = value['content'] as String;

    // Replace all variables in the form {{VarName}}
    variables.forEach((placeholder, replacement) {
      content = content.replaceAll('{{$placeholder}}', replacement);
    });

    snippets[key] = content;
  });

  return snippets;
}

// -----------------------------
// HELPER: Get file inside package
// -----------------------------
File _getPackageFile(String relativePath) {
  // Get the folder of the currently running script
  final scriptDir = p.dirname(Platform.script.toFilePath());

  // Calculate path relative to lib folder of the package
  final path = p.normalize(p.join(scriptDir, '../lib', relativePath));
  final file = File(path);

  if (!file.existsSync()) {
    throw Exception('Snippets file not found: ${file.path}');
  }

  return file;
}

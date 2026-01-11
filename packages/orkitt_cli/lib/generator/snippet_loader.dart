import 'dart:convert';
import 'dart:io';
/// Load snippets from JSON file and interpolate variables.
///
/// - [path] : Path to the snippets.json file.
/// - [variables] : Map of placeholders to replace in the content.
///   For example: {'AppName': 'MyApp', 'feature': 'auth'}
///
/// Returns a map of snippet key -> snippet content with variables replaced.
Map<String, String> loadSnippets(String path,
    {required Map<String, String> variables}) {
  final file = File(path);
  if (!file.existsSync()) {
    throw Exception('Snippets file not found: $path');
  }

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

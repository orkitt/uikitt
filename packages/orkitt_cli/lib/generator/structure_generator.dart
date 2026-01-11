import 'dart:io';
import 'package:path/path.dart' as p;

import 'template_loader.dart';

/// Generate folders and files for a project based on a Template and snippets
void generateStructure(
  Directory srcDir,
  Template template,
  Map<String, String> snippets,
) {
  // -----------------------------
  // CREATE FOLDERS
  // -----------------------------
  for (final folder in template.folders) {
    Directory(p.join(srcDir.path, folder)).createSync(recursive: true);
  }

  // -----------------------------
  // CREATE FILES
  // -----------------------------
  for (final file in template.files) {
    final content = snippets[file.snippet];
    if (content == null) {
      throw Exception('Snippet not found: ${file.snippet}');
    }

    // Full path to file inside project
    final f = File(p.join(srcDir.path, file.path));

    // Always create parent folders
    f.parent.createSync(recursive: true);

    // Write content (overwrite if exists)
    f.writeAsStringSync(content);
  }
}

import 'dart:io';
import 'package:path/path.dart' as p;

import 'template_loader.dart';

void generateStructure(
  Directory srcDir,
  Template template,
  Map<String, String> snippets,
) {
  // folders
  for (final folder in template.folders) {
    Directory(p.join(srcDir.path, folder)).createSync(recursive: true);
  }

  // files
  for (final file in template.files) {
    final content = snippets[file.snippet];
    if (content == null) {
      throw Exception('Snippet not found: ${file.snippet}');
    }

    final f = File(p.join(srcDir.path, file.path));
    if (!f.existsSync()) {
      f.createSync(recursive: true);
      f.writeAsStringSync(content);
    }
  }
}

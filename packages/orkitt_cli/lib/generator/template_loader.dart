import 'dart:convert';
import 'dart:io';

class Template {
  final String name;
  final String? base; // <-- optional base directory
  final List<String> folders;
  final List<TemplateFile> files;

  Template(this.name, this.folders, this.files, {this.base});

  factory Template.fromJson(Map<String, dynamic> json) {
    return Template(
      json['name'] as String,
      List<String>.from(json['folders'] ?? []),
      (json['files'] as List? ?? [])
          .map((e) => TemplateFile(e['path'], e['snippet']))
          .toList(),
      base: json['base'] as String?, // optional
    );
  }
}

class TemplateFile {
  final String path;
  final String snippet;

  TemplateFile(this.path, this.snippet);
}

/// Load template JSON from file
Template loadTemplate(String path) {
  final file = File(path);
  if (!file.existsSync()) {
    throw Exception('Template file not found: $path');
  }

  final jsonStr = file.readAsStringSync();
  final jsonData = jsonDecode(jsonStr) as Map<String, dynamic>;
  return Template.fromJson(jsonData);
}

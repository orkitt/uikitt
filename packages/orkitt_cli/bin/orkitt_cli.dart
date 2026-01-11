/*
 * Copyright (c) 2026 Orkitt
 * All rights reserved.
 */

import 'dart:io';
import 'package:args/args.dart';
import 'package:orkitt_cli/generator/snippet_loader.dart';
import 'package:orkitt_cli/generator/structure_generator.dart';
import 'package:orkitt_cli/generator/template_loader.dart';
import 'package:path/path.dart' as p;
import 'package:process_run/shell.dart';

final shell = Shell();
const orkittVersion = '1.1.3';

Future<void> main(List<String> arguments) async {
  final parser = ArgParser()
    ..addFlag(
      'version',
      abbr: 'v',
      negatable: false,
      help: 'Show the Orkitt CLI version',
    );

  // Define commands before parsing
  parser.addCommand('create').addOption(
    'template',
    abbr: 't',
    defaultsTo: 'lite',
    allowed: ['lite', 'feature'],
  );

  parser.addCommand('add');
  parser.addCommand('feature');

  final argResults = parser.parse(arguments);

  // Version check
  if (argResults['version'] == true) {
    print('Orkitt CLI version $orkittVersion');
    return;
  }

  final cmd = argResults.command;
  if (cmd == null) {
    _usage();
    exit(0);
  }

  switch (cmd.name) {
    case 'create':
      await _create(cmd);
      break;
    case 'add':
      await _add(cmd);
      break;
    case 'feature':
      await _feature(cmd);
      break;
    default:
      _usage();
  }
}

// -----------------------------
// USAGE
// -----------------------------
void _usage() {
  stdout.writeln('''
Usage:
  orkitt create great_app --template lite
  orkitt add <api|auth>
  orkitt feature <feature_name>
''');
}

// -----------------------------
// CREATE COMMAND
// -----------------------------
Future<void> _create(ArgResults args) async {
  if (args.rest.isEmpty) {
    stderr.writeln('❌ Provide app name');
    exit(1);
  }

  final appName = args.rest.first;
  final normalized = _normalize(appName);
  final templateName = args['template'] as String;

  stdout.writeln('🚀 Creating Flutter app "$appName"...');

  try {
    await shell.run('flutter create $normalized --org dev.orkitt');
  } catch (_) {
    stderr.writeln('❌ flutter create failed');
    exit(1);
  }

  try {
    await shell
        .run('cd $normalized && flutter pub add flutter_riverpod dio orkitt');
  } catch (_) {
    stderr.writeln('⚠️ Failed to add some packages, continuing...');
  }

  final template = loadTemplate(
    getPackageFile('templates/$templateName.json').path,
  );

  final snippets = loadSnippets(
    getPackageFile('snippets/snippets.json').path,
    variables: {
      'AppName': appName,
      'app_name': normalized,
      'package_name': normalized,
    },
  );

  final srcDir = Directory(p.join(normalized, 'lib/src'));
  srcDir.createSync(recursive: true);

  generateStructure(srcDir, template, snippets);

  try {
    await shell.run('cd $normalized && git init');
  } catch (_) {}

  stdout.writeln('✅ App created with "$templateName" template');
}

// -----------------------------
// ADD COMMAND
// -----------------------------
Future<void> _add(ArgResults args) async {
  if (args.rest.isEmpty) {
    stderr.writeln('Usage: orkitt add <api|auth>');
    exit(1);
  }

  final name = args.rest.first;
  final templatePath = getPackageFile('templates/add_$name.json').path;

  if (!File(templatePath).existsSync()) {
    stderr.writeln('❌ Unknown add module: $name');
    exit(1);
  }

  final template = loadTemplate(templatePath);
  final snippets = loadSnippets(
    getPackageFile('snippets/snippets.json').path,
    variables: const {},
  );

  final baseDir = Directory(template.base ?? 'lib/src');
  generateStructure(baseDir, template, snippets);

  stdout.writeln('✅ Module "$name" added');
}

// -----------------------------
// FEATURE COMMAND
// -----------------------------
Future<void> _feature(ArgResults args) async {
  if (args.rest.isEmpty) {
    stderr.writeln('Usage: orkitt feature <name>');
    exit(1);
  }

  final feature = args.rest.first;
  final template = loadTemplate(
    getPackageFile('templates/feature.json').path,
  );

  final snippets = loadSnippets(
    getPackageFile('snippets/snippets.json').path,
    variables: {
      'feature': feature,
      'Feature': _capitalize(feature),
    },
  );

  final baseDir = Directory.current;
  generateStructure(baseDir, template, snippets);

  stdout.writeln('✅ Feature "$feature" created in ${baseDir.path}');
}

// -----------------------------
// HELPERS
// -----------------------------
String _normalize(String name) =>
    name.toLowerCase().replaceAll(RegExp(r'[^a-z0-9_]'), '_');

String _capitalize(String s) => s[0].toUpperCase() + s.substring(1);

/// Returns the root directory of the CLI package (lib folder)
String _cliPackageRoot() {
  final scriptDir = p.dirname(Platform.script.toFilePath());
  return p.normalize(p.join(scriptDir, '../lib'));
}

/// Get a file inside the CLI package (templates/snippets)
File getPackageFile(String relativePath) {
  final file = File(p.join(_cliPackageRoot(), relativePath));
  if (!file.existsSync()) {
    throw Exception('Template/snippet file not found: ${file.path}');
  }
  return file;
}

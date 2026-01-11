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
const orkittVersion = '1.1.0';

Future<void> main(List<String> arguments) async {
  final parser = ArgParser()
    ..addFlag(
      'version',
      abbr: 'v',
      negatable: false,
      help: 'Show the Orkitt CLI version',
    );

  // Define commands **before parsing**
  parser.addCommand('create').addOption(
    'template',
    abbr: 't',
    defaultsTo: 'lite',
    allowed: ['lite', 'feature'],
  );

  parser.addCommand('add');
  parser.addCommand('feature');

  // Now parse arguments
  final argResults = parser.parse(arguments);

  // Version check
  if (argResults['version'] == true) {
    print('Orkitt CLI version $orkittVersion');
    return;
  }

  final cmd = argResults.command;
  if (cmd == null) {
    print('Usage: orkitt create|add|feature [options]');
    exit(0);
  }

  switch (cmd.name) {
    case 'create':
      await _create(cmd); // your existing _create function
      break;
    case 'add':
      await _add(cmd); // your existing _add function
      break;
    case 'feature':
      await _feature(cmd); // your existing _feature function
      break;
    default:
      _usage();
  }
}

void _usage() {
  stdout.writeln('''
Usage:
  orkitt create great_app --template lite
  orkitt add <api|auth>
  orkitt feature <feature_name>
''');
}

// --------------------------------------------
// CREATE COMMAND
// --------------------------------------------
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
    await shell.run('cd $normalized && flutter pub add flutter_riverpod dio');
  } catch (_) {
    stderr.writeln('⚠️ Failed to add some packages, continuing...');
  }

  final cliRoot = _cliRoot();

  final template =
      loadTemplate(p.join(cliRoot, 'lib/templates/$templateName.json'));

  final snippets = loadSnippets(
    p.join(cliRoot, 'lib/snippets/snippets.json'),
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

// --------------------------------------------
// ADD COMMAND
// --------------------------------------------
Future<void> _add(ArgResults args) async {
  if (args.rest.isEmpty) {
    stderr.writeln('Usage: orkitt add <api|auth>');
    exit(1);
  }

  final name = args.rest.first;
  final cliRoot = _cliRoot();

  final templatePath = p.join(cliRoot, 'lib/templates/add_$name.json');

  if (!File(templatePath).existsSync()) {
    stderr.writeln('❌ Unknown add module: $name');
    exit(1);
  }

  final template = loadTemplate(templatePath);

  final snippets = loadSnippets(
    p.join(cliRoot, 'lib/snippets/snippets.json'),
    variables: const {},
  );

  final baseDir = Directory(template.base ?? 'lib/src');
  generateStructure(baseDir, template, snippets);

  stdout.writeln('✅ Module "$name" added');
}

// --------------------------------------------
// FEATURE COMMAND
// --------------------------------------------
Future<void> _feature(ArgResults args) async {
  if (args.rest.isEmpty) {
    stderr.writeln('Usage: orkitt feature <name>');
    exit(1);
  }

  final feature = args.rest.first;
  final cliRoot = _cliRoot();

  final template = loadTemplate(
    p.join(cliRoot, 'lib/templates/feature.json'),
  );

  final snippets = loadSnippets(
    p.join(cliRoot, 'lib/snippets/snippets.json'),
    variables: {
      'feature': feature,
      'Feature': _capitalize(feature),
    },
  );

  final baseDir = Directory.current;
  generateStructure(baseDir, template, snippets);

  stdout.writeln('✅ Feature "$feature" created in ${baseDir.path}');
}

// --------------------------------------------
// HELPERS
// --------------------------------------------
String _normalize(String name) =>
    name.toLowerCase().replaceAll(RegExp(r'[^a-z0-9_]'), '_');

String _capitalize(String s) => s[0].toUpperCase() + s.substring(1);

String _cliRoot() => File(Platform.resolvedExecutable).parent.parent.path;

import 'dart:io';
import 'package:args/args.dart';
import 'package:path/path.dart' as p;
import 'package:process_run/shell.dart';

final shell = Shell();

void main(List<String> arguments) async {
  final parser = ArgParser()..addCommand('create');
  final argResults = parser.parse(arguments);

  if (argResults.command == null || argResults.command!.name != 'create') {
    print('Usage: orkitt create "AppName"');
    exit(0);
  }

  if (argResults.command!.rest.isEmpty) {
    print('Please provide an app name: orkitt create "MyApp"');
    exit(1);
  }

  final appName = argResults.command!.rest[0];
  await _createFlutterApp(appName);
}

Future<void> _createFlutterApp(String appName) async {
  final normalizedName = appName.toLowerCase().replaceAll(' ', '_');
  print('🚀 Creating Flutter app "$appName"...');

  // Step 1: flutter create with org
  await shell.run('flutter create $normalizedName --org dev.orkitt');

  final appDir = Directory(normalizedName);
  if (!appDir.existsSync()) {
    print('❌ Failed to create Flutter app.');
    exit(1);
  }

  // Step 2: Add core packages
  print('📦 Adding core packages...');
  await shell.run(
    'cd $normalizedName && flutter pub add flutter_riverpod flutter_addons flutter_animate',
  );

  // Step 3: Create folder structure
  final srcDir = Directory(p.join(normalizedName, 'lib/src'));
  final folders = [
    'core/constants',
    'core/theme',
    'core/colors',
    'data/models',
    'data/repositories',
    'features/auth',
    'features/splash',
    'features/onboarding',
    'l10n',
    'providers',
    'routes',
    'services',
    'shared/widgets',
    'shared/utils',
  ];

  for (final folder in folders) {
    final dir = Directory(p.join(srcDir.path, folder));
    dir.createSync(recursive: true);
    print('📁 Created: ${dir.path}');
  }

  // Step 4: Create files
  _createFile(srcDir, 'app.dart', _appTemplate);
  _createFile(srcDir, 'bootstrap.dart', _bootstrapTemplate);
  _createFile(srcDir, 'core/constants/app_constants.dart', _constantsTemplate);
  _createFile(srcDir, 'core/theme/theme.dart', _themeTemplate);
  _createFile(srcDir, 'core/colors/app_color.dart', _colorsTemplate);
  _createFile(srcDir, 'data/models/example_model.dart', _commonModel);
  _createFile(srcDir, 'data/repositories/example_repository.dart', _commonRepository);

  // Features
  final featureStructure = {
    'auth': ['login_page.dart', 'signup_page.dart'],
    'splash': ['splash_page.dart'],
    'onboarding': ['onboarding_page.dart'],
  };

  for (final feature in featureStructure.entries) {
    final featureDir = Directory(p.join(srcDir.path, 'features', feature.key));
    featureDir.createSync(recursive: true);

    for (final page in feature.value) {
      final file = File(p.join(featureDir.path, page));
      file.createSync();
      file.writeAsStringSync(_featurePageTemplate(page.replaceAll('.dart', '')));
      print('🧱 Created: ${file.path}');
    }
  }

  _createFile(srcDir, 'l10n/messages.dart', _l10nTemplate);
  _createFile(srcDir, 'providers/providers.dart', _providersTemplate);
  _createFile(srcDir, 'routes/app_routes.dart', _routesTemplate);
  _createFile(srcDir, 'services/example_service.dart', _commonService);
  _createFile(srcDir, 'shared/widgets/example_widget.dart', _commonWidget);
  _createFile(srcDir, 'shared/utils/example_utils.dart', _commonUtils);

  // Step 5: Initialize git
  await shell.run('cd $normalizedName && git init');
  print('✅ Flutter app "$appName" created successfully with Orkitt structure!');
  print('Next steps: cd $normalizedName && flutter run');
}

void _createFile(Directory srcDir, String relativePath, String content) {
  final file = File(p.join(srcDir.path, relativePath));
  file.createSync(recursive: true);
  file.writeAsStringSync(content);
  print('🧱 Created: ${file.path}');
}

// ----------------- Templates -----------------

const _appTemplate = '''
import 'package:flutter/material.dart';
import 'bootstrap.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Orkitt App',
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        body: Center(child: Text('Hello from Orkitt!')),
      ),
    );
  }
}
''';

const _bootstrapTemplate = '''
import 'package:flutter/widgets.dart';
import 'app.dart';

Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}
''';

const _constantsTemplate = '''
class AppConstants {
  static const String appName = 'Orkitt App';
}
''';

const _themeTemplate = '''
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get light => ThemeData.light();
  static ThemeData get dark => ThemeData.dark();
}
''';

const _colorsTemplate = '''
import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF4A90E2);
  static const Color secondary = Color(0xFF50E3C2);
  static const Color background = Color(0xFFF5F5F5);
  static const Color text = Color(0xFF333333);
}
''';

const _commonModel = '''
class CommonModel {
  final String name;
  CommonModel({required this.name});
}
''';

const _commonRepository = '''
class CommonRepository {
  Future<String> fetchData() async => "Hello Orkitt!";
}
''';

String _featurePageTemplate(String className) => '''
import 'package:flutter/material.dart';

class ${_capitalize(className)} extends StatelessWidget {
  const ${_capitalize(className)}({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('$className Page')),
    );
  }
}

String _capitalize(String s) => s[0].toUpperCase() + s.substring(1);
''';

const _l10nTemplate = '''
class Messages {
  static String get welcome => 'Welcome to Orkitt App';
}
''';

const _providersTemplate = '''
// Register your providers here
''';

const _routesTemplate = '''
class AppRoutes {
  static const home = '/';
}
''';

const _commonService = '''
class CommonService {
  // Service methods here
}
''';

const _commonWidget = '''
import 'package:flutter/material.dart';

class CommonWidget extends StatelessWidget {
  const CommonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
''';

const _commonUtils = '''
class CommonUtils {
  static String format(String text) => text.toUpperCase();
}
''';

String _capitalize(String s) => s[0].toUpperCase() + s.substring(1);

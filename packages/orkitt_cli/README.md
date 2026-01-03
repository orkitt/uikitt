
![Orkitt](https://github.com/orkitt/core/blob/main/images/brand_sm.png?raw=true)

# `orkitt_cli`

> A powerful Flutter CLI tool to scaffold Orkitt-style Flutter apps with pre-configured folder structure, essential packages, and bootstrap files.

---

## Installation

Activate globally via Dart:

```bash
dart pub global activate orkitt_cli
```


---

## Usage

Create a new Flutter app with Orkitt CLI:

```bash
orkitt create "MyApp"
```

This will:

1. Create a Flutter app named `MyApp` with `--org dev.orkitt`
2. Install core packages
3. Generate the full folder and file structure
4. Initialize Git

---

## Folder Structure Example

```
lib/
 └── src/
     ├── core/colors/app_color.dart
     ├── core/constants/app_constants.dart
     ├── core/theme/theme.dart
     ├── data/models/
     ├── data/repositories/
     ├── features/auth/login_page.dart
     ├── features/auth/signup_page.dart
     ├── features/splash/splash_page.dart
     ├── features/onboarding/onboarding_page.dart
     ├── l10n/messages.dart
     ├── providers/providers.dart
     ├── routes/app_routes.dart
     ├── services/example_service.dart
     ├── shared/widgets/example_widget.dart
     ├── shared/utils/example_utils.dart
     ├── app.dart
     └── bootstrap.dart
```

---

## Contributing

1. Fork the repository
2. Create a new branch (`git checkout -b feature/my-feature`)
3. Make your changes
4. Commit (`git commit -am 'Add new feature'`)
5. Push (`git push origin feature/my-feature`)
6. Create a pull request

---

## License

MIT License © Orkitt Technology


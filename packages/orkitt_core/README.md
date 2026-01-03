# orkitt_core
![Logo Image](https://raw.githubusercontent.com/orkitt/uikit/master/images/brand_sm.png)

Core application logic for the **Orkitt** ecosystem.

This package contains shared business logic, lifecycle management,
and state-related utilities that power Orkitt-based applications.

---

##  Features

- Application lifecycle helpers
- Shared state abstractions
- Core services and controllers
- Business logic utilities

---

##  Installation

```yaml
dependencies:
  orkitt_core: ^0.0.1
```

## 🚀 Getting Started

Initialize the framework globally to enable responsive scaling, orientation handling, and design frame calibration.

```dart
 // Initialize Orkitt Design System
 AppComposer(
      orientation: AppOrientation.portraitUp, // Lock or allow orientations
      designFrame: const DesignFrame(width: 320, height: 812), // Base design frame // Or percent based
      scaleMode: ScaleMode.design, // Design-based scaling
      pixelDebug: false, // Turn on for layout visualization
      gridCount: 12, // Default grid layout (for responsive spacing)
      enableDebugLogging: true, // Logs device metrics & scaling
      errorScreen:  ErrorScreen.sifi, // Custom global error view
      version: '2.0.0', // To show on Development Banner
      appBuilder: (Composer layout) => const MaterialApp(), //Your main material app 
    );
```

---

## 🎨 Theming System

Define your brand identity through scalable color and typography systems.

### 1. Brand Colors

```dart
class AppColors extends BrandKolors {
  @override
  Color get primary => const Color(0xFF4A90E2);
  @override
  Color get accent => const Color(0xFFE24A8D);
}
```

### 2. Typography

```dart
class AppTypo extends BrandTypography {
  @override
  String get fontFamily => 'Montserrat';
  @override
  TextStyle get body => TextStyle(fontSize: 16.sp);
}
```

### 3. Generate and Apply

```dart
final ThemeData lightTheme => ThemeBuilder.build(AppLightColors(), typography: AppFonts());
```

---

## 📏 Responsive Extensions

| Extension | Example | Description                 |
| --------- | ------- | --------------------------- |
| `.ph`     | `24.ph` | Percentage of screen height |
| `.pw`     | `24.pw` | Percentage of screen width  |
| `.sp`     | `16.sp` | Responsive font scaling     |
| `.r`      | `12.r`  | Radius or element scale     |
| `.h`      | `48.h`  | Scaled height               |
| `.w`      | `48.w`  | Scaled width                |




## © Copyright

© 2026 Orkitt. All rights reserved.


# 🪶 Orkitt UI Framework

> The official Flutter design framework by **Orkitt Studio**
> Built for speed, scalability, and visual harmony.

---

**Orkitt UI Framework** is a modern Flutter design system that unifies theming, responsiveness, and developer productivity into one elegant foundation.
It enables you to design **visually consistent, adaptive, and production-ready** Flutter applications — faster, cleaner, and with zero boilerplate.

> ⚡ Empower your Flutter workflow with expressive extensions, responsive layout tools, and a powerful design engine engineered for clarity and creativity.

---

## ✨ Key Highlights

* **🎨 Unified Theming System** – Scalable typography, brand colors, and style layers that adapt to light/dark modes automatically.
* **📐 Responsive Layouts** – Pixel-perfect scaling across all screen sizes with easy-to-use measurement extensions.
* **🧩 Beautiful Components** – Professionally crafted buttons, cards, and layouts that follow Orkitt’s design principles.
* **⚙️ Smart Syntax Extensions** – Intuitive `.m`, `.p`, `.sp`, and `.w` helpers for building beautiful layouts with less code.
* **🧠 Context Utilities** – Access media, theme, and typography directly from `BuildContext`.
* **🪄 Smooth Navigation** – Elegant route transitions and adaptive animation types using the new `shift()` navigation system.
* **🧱 Consistency-Driven** – Built-in DPI handling, debugging, and theming awareness for design precision.

---

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

---

## 🧱 Layout & Spacing Helpers

| Type     | Syntax             | Example |
| -------- | ------------------ | ------- |
| Margin   | `.m`, `.mt`, `.mx` | `16.mx` |
| Padding  | `.p`, `.pb`, `.py` | `12.p`  |
| Combined | `.px`, `.my`       | `8.my`  |

These expressive shortcuts help maintain design consistency and readability across widgets.

---

## 🧭 Navigation System

Version `1.0.0` introduces the **new Orkitt Navigation API** — built around the concept of *shifting* between views.

### Available Animation Types

```dart
enum AnimationType { fade, slideFromRight, slideFromLeft, scale, rotate, rotateScale }
```

| Method                       | Description                             |
| ---------------------------- | --------------------------------------- |
| `shift(Widget page)`         | Navigates to a new page with animation. |
| `shiftName(String name)`     | Navigates to a named route.             |
| `shiftReplaced(Widget page)` | Replaces the current route.             |
| `shiftBack()`                | Pops the current route.                 |
| `shiftToRoot()`              | Returns to the first route.             |



---

## 🔁 Async & Utility Extensions

| Method                            | Description                                             |
| --------------------------------- | ------------------------------------------------------- |
| `safe(fallback: T)`               | Safely execute async operations with fallback handling. |
| `retry(retries, delay)`           | Retries failed async operations.                        |
| `withTimeout(duration, fallback)` | Sets timeout with fallback.                             |
| `collect()`                       | Collects stream results into a list.                    |
| `batch(int)`                      | Processes stream data in chunks.                        |

---

## 📅 Date & Time Extensions

```dart
final tomorrow = DateTime.now().tomorrow;
final greeting = DateTime.now().greeting; // Morning, Afternoon, Evening
```

| Method           | Description                        |
| ---------------- | ---------------------------------- |
| `.timeAgo`       | Returns a “time ago” string.       |
| `.formattedDate` | Formats a readable date.           |
| `.daysInMonth`   | Returns days in the current month. |
| `.isToday`       | Checks if the date is today.       |

---

## 💱 Currency Extensions

| Method                 | Output Example |
| ---------------------- | -------------- |
| `.toDollar()`          | `$1234.57`     |
| `.toEuro()`            | `€1234.57`     |
| `.toBangladeshiTaka()` | `৳1234.57`     |

---

## 🧩 Logging System

Use structured logging instead of `print()`:

```dart
Debug.info('App initialized');
Debug.error('Network error');
Debug.success('User logged in');
```

| Level             | Description        |
| ----------------- | ------------------ |
| `Debug.info()`    | Informational logs |
| `Debug.warning()` | Warnings           |
| `Debug.error()`   | Errors             |
| `Debug.success()` | Success messages   |

---

## 📚 Documentation

* [🎨 Theming System](./docs/theming.md)
* [📐 Responsive Layout](./docs/responsive.md)
* [🧭 Navigation System](./docs/navigation.md)
* [🧩 Widget Extensions](./docs/widget.md)

---

## 🤝 Contributing

Contributions and ideas are welcome.
Submit pull requests or open issues at:

👉 [github.com/orkitt/uikit](https://github.com/orkitt/uikit)

---

### 🏷️ License

**Apache License 2.0**
Copyright © 2025 **Orkitt Empire**
All rights reserved.

Use of this source code is governed by the Apache License, Version 2.0, which permits usage, modification, and distribution under specific conditions.
See the [LICENSE](./LICENSE) file for full details.


---

### 🌐 Connect

🌍 Website: [orkitt.dev](https://orkitt.dev)
🐙 GitHub: [github.com/orkitt](https://github.com/orkitt)
💬 Twitter/X: [@orkittdev](https://twitter.com/orkittdev)


> Part of the **Orkitt Design Ecosystem** — empowering developers to design fast and build beautifully.


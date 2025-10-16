# Orkitt JS Injector

> A robust, domain-aware JavaScript injector for Flutter WebViews  
> Built for `flutter_inappwebview`, designed for safety, reliability, and scale.

---

### Features

- **Global and per-domain scripts** — inject different JS logic based on hostname.
- **Safe timeouts and retries** — never hang your WebView due to bad scripts.
- **Metadata-driven** — each script has a name, description, timeout, and retry policy.
- **Exponential backoff** — automatic retry delay for transient injection issues.
- **Pluggable logging** — use your own logger (Sentry, Crashlytics, etc.) or fallback to `debugPrint`.
- **Clean API design** — ideal for production-level WebView integrations.

---

### 🚀 Installation
Add to your `pubspec.yaml`:
```yaml
dependencies:
  webvue_injector: ^1.0.0

```
### Example
```dart
final jsInjector = JSInjector(logger: (msg) => debugPrint(msg));

// Register a global script
jsInjector.registerGlobal(
  const DomainScript(
    name: 'remove_ads',
    description: 'Remove annoying banners',
    source: """
      (function(){
        const ad = document.querySelector('.ad-banner');
        if (ad) ad.remove();
        return 'removed';
      })();
    """,
    timeout: Duration(seconds: 2),
    retries: 1,
  ),
);

// Register a domain-specific script
jsInjector.registerForDomain(
  'example.com',
  const DomainScript(
    name: 'hide_cookie_popup',
    description: 'Hide cookie consent popup',
    source: """
      (function(){
        const popup = document.getElementById('cookie-consent');
        if (popup) popup.style.display = 'none';
        return 'hidden';
      })();
    """,
    timeout: Duration(seconds: 3),
    retries: 2,
  ),
);

// Inject scripts during WebView load
onLoadStop: (controller, url) async {
  await jsInjector.injectForUrl(controller, url);
}
```
---

### ⚙️ API Reference

| Method                                  | Purpose                                  |
| --------------------------------------- | ---------------------------------------- |
| `registerForDomain(domain, script)`     | Add domain-specific scripts              |
| `registerGlobal(script)`                | Add scripts for all URLs                 |
| `injectForUrl(controller, url)`         | Injects all relevant scripts             |
| `injectNamed(controller, domain, name)` | Inject a specific script manually        |
| `clearAll()`                            | Remove all registered scripts            |
| `listDomains()`                         | List all domains with registered scripts |

---

### 🪪 License

This project is licensed under the **Orkitt Open License** —
Free for personal, commercial, and open-source use **with attribution retained**.

Copyright © 2025
Developed by [Orkitt](https://orkitt.github.io)


# Minimals — Trading App (021_trade)

> **Master Boilerplate for Flutter projects with GetX, Firebase, and more.**

`Minimals` is a Flutter-based **trading application** that provides a complete mobile trading experience including a live (simulated) market feed, watchlists, holdings, funds, order placement, and portfolio management. It is built on a robust boilerplate with multi-environment support (dev / uat / prod), Firebase integration, multi-language localization (including RTL), and a large library of reusable UI components.

---

## Table of Contents

- [Features](#features)
- [Tech Stack](#tech-stack)
- [Project Structure](#project-structure)
- [Prerequisites](#prerequisites)
- [Getting Started](#getting-started)
  - [1. Install Dependencies](#1-install-dependencies)
  - [2. Firebase Setup](#2-firebase-setup)
  - [3. Run the App](#3-run-the-app)
- [Environments & Flavors](#environments--flavors)
- [Build & Release](#build--release)
  - [Android APK](#android-apk)
  - [iOS](#ios)
- [Localization](#localization)
- [Key Services](#key-services)
- [Project Configuration](#project-configuration)
- [Testing](#testing)
- [Helper Scripts](#helper-scripts)
- [Troubleshooting](#troubleshooting)
- [Additional Documentation](#additional-documentation)

---

## Features

- 🔐 **Authentication** — Login with remember-me, OTP generation & verification, SMS auto-fill, forgot password, and biometric authentication (`local_auth`).
- 📈 **Dashboard** — Live portfolio overview with real-time market data.
- 💼 **Holdings** — Track owned positions, quantity, average price, and live P&L.
- ⭐ **Watchlist** — Create and manage multiple watchlists with grouped stocks.
- 💰 **Funds** — View and manage available funds.
- 🛒 **Orders** — Place buy/sell orders, view order history.
- 🌐 **Live Market Feed** — Simulated real-time price updates (random-walk ticker, 2s interval) shared app-wide through a single source of truth.
- 🗂️ **Offline Persistence** — SQLite database (`trading_app.db`) with migrations for watchlists, holdings, transactions, and more.
- 🌍 **Multi-language** — English, French, Vietnamese, Chinese, Arabic (RTL), and Hindi.
- 🎨 **Theme System** — Light & dark mode with Material 3, custom fonts (CircularStd, Roboto).
- 📱 **Cross-platform** — Android & iOS.
- 🛡️ **Error Handling** — Global error handlers, Firebase Crashlytics in release builds, `DevicePreview` in debug builds.
- 🔔 **Notifications** — Firebase Cloud Messaging (FCM) + local notifications with a high-importance channel.
- 🧩 **Reusable Components** — 30+ generic Flutter widgets (buttons, forms, tables, charts, accordions, modals, pagination, etc.).

---

## Tech Stack

| Category          | Technology                                                        |
| ----------------- | ----------------------------------------------------------------- |
| Framework         | Flutter / Dart (`sdk: ^3.6.1`)                                    |
| State Management  | [GetX](https://pub.dev/packages/get) (`^4.6.6`)                   |
| DI                | GetIt + Injectable (with `build_runner`)                          |
| Networking        | Dio (`^5.8.0`) — modular API service layer                         |
| Local Storage     | GetStorage, SharedPreferences, sqflite (SQLite)                   |
| Backend / Cloud   | Firebase Core, Analytics, Crashlytics, Remote Config, Messaging   |
| Localization      | `flutter_localizations` + GetX translations                        |
| Charts / UI       | fl_chart, syncfusion_flutter_pdfviewer, carousel_slider, shimmer, etc. |
| Notifications     | firebase_messaging, flutter_local_notifications                   |
| Biometrics        | local_auth                                                        |
| Maps              | google_maps_flutter, geocoding                                    |

---

## Project Structure

```
021_trade/
├── android/                  # Android platform code (flavors: dev/uat/prod)
├── ios/                      # iOS platform code
├── assets/
│   ├── background/           # Background images
│   ├── icons/                # SVG/PNG icons
│   ├── illustrations/        # Illustrations & characters
│   ├── images/               # General images
│   ├── langs/                # Localization JSON files (en, fr, vi, cn, ar, hi)
│   ├── png/                  # PNG assets & app logo
│   └── sounds/               # Audio assets
├── fonts/
│   ├── circular_std/         # CircularStd font family
│   └── roboto/               # Roboto font family
├── lib/
│   ├── main.dart             # App entry point (env detection, Firebase init, services)
│   ├── firebase_options.dart # Firebase options per environment (dev/uat/prod)
│   ├── injection.dart        # GetIt / Injectable DI setup
│   ├── injection.config.dart # Generated DI config (run build_runner)
│   ├── app/                  # MyApp widget, bindings, app controller
│   ├── asset/                # Asset helpers
│   ├── components/           # Generic reusable UI components (30+)
│   ├── config/               # App configuration (base URLs, timeouts, env configs)
│   ├── constants/            # App-wide constants
│   ├── controllers/          # Global GetX controllers
│   ├── enum/                 # Enums (AppEnvironment, Environment, etc.)
│   ├── hooks/                # Custom hooks
│   ├── layouts/              # Layout wrappers / demo screens
│   ├── locale/               # Language configuration (config_lang.dart)
│   ├── models/               # Data models (UserModel, StockModel, etc.)
│   ├── routes/               # GetX route definitions (app_pages, auth_routes)
│   ├── screens/              # Feature screens
│   │   ├── dashboard/        # Dashboard (controller, main, widgets)
│   │   ├── funds/            # Funds
│   │   ├── holdings/         # Holdings
│   │   ├── initial/          # Splash / initial screen
│   │   ├── login/            # Login, OTP verification, forgot password
│   │   ├── order/            # Order placement (Buy/Sell)
│   │   ├── orders/           # Order history
│   │   ├── profile/          # User profile
│   │   └── watchlist/        # Watchlists
│   ├── sections/             # Section-level widgets (auth, dashboard)
│   ├── services/             # Services
│   │   ├── api_services/     # Modular API service (models, interceptors, etc.)
│   │   ├── biometric_services/ # Biometric auth
│   │   ├── firebase_services/  # Analytics, Crashlytics, Notifications, Remote Config
│   │   ├── database_service.dart   # SQLite database (migrations)
│   │   ├── device_service.dart     # Device info
│   │   ├── localization_service.dart
│   │   ├── log_out_services.dart
│   │   └── market_feed_service.dart # Simulated live price feed
│   ├── settings/             # Settings page & controller (theme, locale)
│   ├── theme/                # Light/dark theme definitions
│   ├── utils/                # Global utils, snackbar utils, formatters
│   ├── widget/               # Custom widgets (bottom tabs, OTP, buy/sell ticket, etc.)
│   └── wrappers/             # Localization wrapper, etc.
├── test/                     # Unit/widget tests
├── tools/                    # Helper shell scripts (APK build, icons, SHA, deps)
└── pubspec.yaml              # Package manifest & dependencies
```

---

## Prerequisites

Before you begin, make sure you have the following installed:

| Tool                                        | Version / Notes                                  |
| ------------------------------------------- | ------------------------------------------------ |
| [Flutter SDK](https://flutter.dev)          | Latest stable (`sdk: ^3.6.1`)                    |
| Dart SDK                                    | `^3.6.1` (bundled with Flutter)                  |
| Android Studio                               | For Android builds (with Android SDK / NDK)      |
| Xcode + CocoaPods                            | For iOS builds (macOS only)                      |
| A connected device or emulator               | Physical device or emulator                      |
| [Firebase CLI](https://firebase.google.com/docs/cli) | For Firebase setup (optional)         |

Verify your setup:

```bash
flutter doctor
flutter --version
```

---

## Getting Started

### 1. Install Dependencies

```bash
# Clone / open the project, then fetch dependencies
flutter pub get
```

If you modify any `injectable` dependencies or add new annotated services, regenerate the DI code:

```bash
dart run build_runner build --delete-conflicting-outputs
```

### 2. Firebase Setup

The app initializes Firebase with environment-specific options defined in `lib/firebase_options.dart`:

| Environment | Firebase Project      |
| ----------- | --------------------- |
| `dev`       | `minimals-dev`        |
| `uat`       | `minimals-uat`        |
| `prod`      | `minimalsprod`        |

- **Android**: The `google-services` Gradle plugin is already applied in `android/app/build.gradle`. Make sure each build flavor has its corresponding `google-services.json` configured (Firebase uses the application ID / package name to match projects).
- The app is resilient — if Firebase initialization fails it continues in offline mode (errors are re-thrown only in debug mode).

### 3. Run the App

Run the app on a connected device/emulator (defaults to the **dev** environment):

```bash
flutter run
```

To run a specific environment explicitly:

```bash
# Development
flutter run --flavor dev --dart-define=ENV=dev

# UAT / staging
flutter run --flavor uat --dart-define=ENV=uat

# Production
flutter run --flavor prod --dart-define=ENV=prod
```

> **Note:** When running with flavors, use `-t lib/main.dart` if needed. On iOS you must use the `--flavor` flag with the scheme matching the flavor name.

---

## Environments & Flavors

The app supports three environments controlled by the `ENV` dart-define (`dev`, `uat`, `prod`) and Android product flavors with distinct application IDs and app names:

| Flavor | App Name         | Application ID (suffix) | `--dart-define=ENV=` | Firebase Project |
| ------ | ---------------- | ----------------------- | -------------------- | ---------------- |
| `dev`  | `Minimals-DEV`   | `com.minimals.dev`      | `dev`                | `minimals-dev`   |
| `uat`  | `Minimals-UAT`   | `com.minimals.uat`      | `uat`                | `minimals-uat`   |
| `prod` | `Minimals`       | `com.minimals.app`      | `prod`               | `minimalsprod`   |

Each environment has its own default configuration in `lib/config/config_data.dart` (base URL, S3 URL, timeouts, retries, and feature flags). Config can also be overridden at runtime via **Firebase Remote Config** (`config` key) with a retry/fallback mechanism.

Environment selection happens in `lib/main.dart`:

```dart
const String envString = String.fromEnvironment('ENV', defaultValue: 'dev');
```

Invalid values fall back to `dev` automatically.

---

## Build & Release

### Android APK

Use the provided script to build release APKs per flavor:

```bash
./tools/generate_flutter_android_apk.sh dev    # or uat / prod
```

Or run the underlying commands directly:

```bash
# Development release APK
flutter build apk --release --flavor dev --dart-define=ENV=dev -t lib/main.dart

# UAT release APK
flutter build apk --release --flavor uat --dart-define=ENV=uat -t lib/main.dart

# Production release APK
flutter build apk --release --flavor prod --dart-define=ENV=prod -t lib/main.dart
```

**Signing:** Release builds are signed using per-flavor keystore credentials read from `android/key.properties`. This file is **not** committed to version control — create it locally:

```properties
# android/key.properties (example)
devkeyAlias=...
devkeyPassword=...
devstoreFile=...
devstorePassword=...

uatkeyAlias=...
uatkeyPassword=...
uatstoreFile=...
uatstorePassword=...

prodkeyAlias=...
prodkeyPassword=...
prodstoreFile=...
prodstorePassword=...
```

Production and UAT release builds also enable `--obfuscate` and `--split-debug-info` for iOS.

### iOS

```bash
# Development
flutter build ios --flavor dev -t lib/main.dart

# UAT / Production (with obfuscation & symbol split)
flutter build ios --flavor uat -t lib/main.dart --shrink --obfuscate --split-debug-info=build/app/outputs/symbols
flutter build ios --flavor prod -t lib/main.dart --shrink --obfuscate --split-debug-info=build/app/outputs/symbols
```

> Building iOS requires macOS with Xcode and CocoaPods installed (`pod install` is handled automatically by Flutter).

---

## Localization

The app supports **6 languages** (configured in `lib/locale/config_lang.dart`):

| Language          | Locale   | RTL  | File             |
| ----------------- | -------- | ---- | ---------------- |
| English           | `en_US`  | No   | `assets/langs/en.json` |
| French            | `fr_FR`  | No   | `assets/langs/fr.json` |
| Vietnamese        | `vi_VN`  | No   | `assets/langs/vi.json` |
| Chinese           | `zh_CN`  | No   | `assets/langs/cn.json` |
| Arabic (Sudan)    | `ar_SA`  | **Yes** | `assets/langs/ar.json` |
| Hindi             | `hi_IN`  | No   | `assets/langs/hi.json` |

- The default language is **English**.
- The UI direction automatically flips to RTL for Arabic.
- Change language from the **Settings** page; the selected locale is persisted.

---

## Key Services

| Service                                  | Responsibility                                                        |
| ---------------------------------------- | --------------------------------------------------------------------- |
| `MarketFeedService`                      | Simulated live price feed (random-walk ticker every 2s), single source of truth for all price data |
| `DatabaseService`                        | SQLite database (`trading_app.db`, version 4) with migrations for watchlists, holdings, transactions |
| `DeviceService`                          | Device info & permissions                                              |
| `NotificationService`                    | FCM push notifications + local notifications (high-importance channel) |
| `RemoteConfigService`                    | Firebase Remote Config (used to override app config at runtime)       |
| `AnalyticsService` / `CrashlyticsService`| Firebase analytics & crash reporting                                   |
| `LocalizationService`                    | Loads and serves translations                                          |
| `Config` (GetIt)                         | Environment-aware app configuration (base URL, S3 URL, timeouts)       |
| API service layer (`api_services/`)      | Modular Dio-based HTTP client with interceptors, models, and exceptions |

---

## Project Configuration

Key configuration files:

| File                                  | Purpose                                                          |
| ------------------------------------- | ---------------------------------------------------------------- |
| `pubspec.yaml`                        | Dependencies, assets, fonts, launcher icon config                |
| `lib/config/config_data.dart`         | Per-environment defaults (base URL, S3, timeouts, feature flags) |
| `lib/firebase_options.dart`           | Firebase project options per environment                         |
| `android/app/build.gradle`            | Flavors, signing configs, minify/multidex settings               |
| `android/key.properties`              | Keystore credentials per flavor (local only, not committed)      |
| `analysis_options.yaml`               | Dart analyzer / linter rules                                     |

---

## Testing

Run all tests:

```bash
flutter test
```

Test files live under `test/` (e.g., `test/widget_test.dart`, `test/sections/`).

Run static analysis:

```bash
flutter analyze
```

Format the code:

```bash
dart format .
```

---

## Helper Scripts

The `tools/` directory contains shell scripts (bash):

| Script                              | Purpose                                            |
| ----------------------------------- | -------------------------------------------------- |
| `generate_flutter_android_apk.sh`   | Build release APK for a flavor (`dev` / `uat` / `prod`) |
| `generate_flutter_depencies.sh`     | Regenerate project dependencies                    |
| `generate_flutter_icons.sh`         | Regenerate launcher icons from `assets/png/logos/logo_single.png` |
| `generate_sha.sh`                   | Generate SHA certificate fingerprints (debug/release) |

Example:

```bash
./tools/generate_flutter_android_apk.sh prod
```

---

## Troubleshooting

| Problem                                             | Solution                                                                  |
| --------------------------------------------------- | ------------------------------------------------------------------------- |
| `flutter pub get` fails                             | Ensure Flutter/Dart SDK version matches `pubspec.yaml` (`sdk: ^3.6.1`)     |
| Missing generated DI file (`injection.config.dart`) | Run `dart run build_runner build --delete-conflicting-outputs`             |
| Firebase not initialized                            | Verify `google-services.json` per flavor / `firebase_options.dart` values  |
| Release build fails on signing                      | Create `android/key.properties` with valid per-flavor keystore credentials |
| App name / ID wrong                                 | Confirm flavor used: `dev`, `uat`, or `prod`                               |
| OTP / SMS autofill not working                      | Ensure SMS permissions and OTP signature match (see `LoginController.getSignature`) |

---

## Additional Documentation

- [THEME_ARCHITECTURE_GUIDE.md](./THEME_ARCHITECTURE_GUIDE.md) — Theme architecture & customization.
- [ACCORDION_IMPLEMENTATION.md](./ACCORDION_IMPLEMENTATION.md) — Accordion component implementation details.
- [TASK_COMPLETION_SUMMARY.md](./TASK_COMPLETION_SUMMARY.md) — Migration / task completion summary.

---

## License

This project is proprietary / internal. See your organization's licensing policy for usage terms.

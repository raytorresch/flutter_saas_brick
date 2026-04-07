# Changelog

All notable changes to this brick will be documented in this file.

The format follows [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).
This project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [0.1.0+1] — 2026-04-07

### Added
- Initial release of `flutter_saas_brick` Mason brick
- **Routing** — `go_router` with named routes, auth redirect guard, deep linking support, fade transitions, and 404 error screen
- **Auth state** — `AuthNotifier` (`ChangeNotifier`) with `flutter_secure_storage` backend; session restored on startup
- **Secure storage** — `SecureStorageService` wrapping `FlutterSecureStorage` (AES on Android, Keychain on iOS)
- **DI** — `get_it` + `injectable` with pre-configured module for `Dio`, `SharedPreferences`, `FlutterSecureStorage`, `PackageInfo`
- **Flavors** — `development`, `staging`, `production` with isolated entry points (`main_development.dart`, etc.)
- **Network layer** — `Dio` with async `TokenInterceptor`, `TimeoutInterceptor`, `PrettyDioLogger`, and `dio_smart_retry`
- **BLoC** — `AppBlocObserver` for logging create/event/transition/error/close; `ExampleBloc` demonstrating `BaseEvent`/`BaseState` pattern
- **Freezed models** — `Result<S, F>`, `AppFailure`, `AppException`, `BaseEvent<T>`, `BaseState<T>`
- **l10n** — `flutter_localizations` + `intl` with English and Spanish ARB files
- **Hooks** — `pre_gen` validates `projectName`, `bundleId`, `flutterVersion` format before generation; `post_gen` runs `fvm use` + `flutter pub get` + `make init`
- **Linting** — `very_good_analysis` with `public_member_api_docs` disabled
- **Smoke tests** — 3 widget tests covering `LoginScreen` render, `HomeScreen` initial state, and BLoC transition
- **Variables** — `projectName`, `projectDescription`, `appName`, `bundleId`, `flutterVersion`

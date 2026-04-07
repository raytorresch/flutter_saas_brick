# {{appName}}

> {{projectDescription}}

Generated with [app_template](https://github.com/raytorresch/app_template) — a production-ready Flutter SaaS brick.

---

## Requirements

- [FVM](https://fvm.app) — `dart pub global activate fvm`
- Flutter `{{flutterVersion}}` (activated automatically by the post-gen hook)

---

## Getting started

```bash
fvm use {{flutterVersion}}
make init
```

---

## Running the app

```bash
# Development
fvm flutter run --flavor development -t lib/main_development.dart

# Staging
fvm flutter run --flavor staging -t lib/main_staging.dart

# Production
fvm flutter run --flavor production -t lib/main_production.dart
```

---

## Make commands

| Command | Description |
|---------|-------------|
| `make init` | `flutter pub get` + `build_runner build` |
| `make watch` | `flutter pub get` + `build_runner watch` |
| `make bundle_dev` | Android App Bundle — development flavor |
| `make bundle_stg` | Android App Bundle — staging flavor |
| `make bundle_prod` | Android App Bundle — production flavor |
| `make apk_dev` | Android APK — development |
| `make apk_stg` | Android APK — staging |
| `make apk_prod` | Android APK — production |
| `make ipa_dev` | iOS IPA — development |
| `make ipa_stg` | iOS IPA — staging |
| `make ipa_prod` | iOS IPA — production |
| `make fix_pods` | `pod repo update && pod update && pod install` |

---

## Project structure

```
lib/
├── core/
│   ├── dependency_injection/   # get_it + injectable modules
│   ├── l10n/                   # Localization (EN + ES)
│   ├── observers/              # AppBlocObserver
│   ├── router/                 # go_router + AuthNotifier
│   │   ├── app_router.dart     # Routes, auth guard, transitions
│   │   └── auth_notifier.dart  # ChangeNotifier — drives auth redirects
│   ├── shared/
│   │   └── freezed/            # Result<S,F>, AppFailure, AppException, BaseEvent/BaseState
│   └── utils/
│       ├── extensions/         # BuildContext, String, AppFailure extensions
│       ├── helpers/            # ValidatorsHelper, AppInfoHelper
│       ├── mixins/             # NetworkMixin, RequestMixin
│       └── services/           # PreferencesService, SecureStorageService, NetworkService
├── features/
│   ├── auth/                   # LoginScreen — replace with your auth UI
│   └── home/                   # HomeScreen + ExampleBloc
├── app.dart                    # App entry, BlocObserver, DI bootstrap
├── main_development.dart
├── main_staging.dart
└── main_production.dart
```

---

## Auth flow

```dart
// After a successful login:
await getIt<AuthNotifier>().setAuthenticated(token);
// → go_router automatically redirects to '/'

// Logout from anywhere:
await getIt<AuthNotifier>().logout();
// → go_router automatically redirects to '/login'
```

Token is stored encrypted via `flutter_secure_storage` (AES on Android, Keychain on iOS). On next cold start, `AuthNotifier.initialize()` restores the session automatically.

---

## Adding a feature

1. Create `lib/features/<name>/` with `blocs/`, `presentation/`, and a barrel `<name>.dart`
2. Export it from `lib/features/features.dart`
3. Add routes to `AppRoutes` and `AppRouter._routes` in `lib/core/router/app_router.dart`
4. Register any new services/repositories in `lib/core/dependency_injection/modules.dart` and re-run `make init`

---

## Deep linking

go_router handles deep linking for any path defined in `AppRouter`. Native setup required per platform:

- **Android** — add `<intent-filter>` with your scheme in `android/app/src/main/AndroidManifest.xml`
- **iOS** — add `CFBundleURLTypes` (custom scheme) or Associated Domains (Universal Links) in `ios/Runner/Info.plist`

---

## Flavor API URLs

Set per-environment base URLs in `lib/core/dependency_injection/flavors.dart`:

```dart
@Environments.production
class Production implements Flavor {
  @override
  String get apiUrl => 'https://api.myapp.com';
}
```

---

## License

MIT

# app_template

[![Powered by Mason](https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge)](https://github.com/felangel/mason)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![CI](https://github.com/raytorresch/app_template/actions/workflows/ci.yml/badge.svg)](https://github.com/raytorresch/app_template/actions/workflows/ci.yml)

A production-ready Flutter SaaS project template generated with [Mason](https://github.com/felangel/mason).

Generates a fully wired Flutter app with routing, auth, dependency injection, localization, and a clean feature-based architecture — ready to build on from day one.

---

## What it generates

```
my_saas_app/
├── lib/
│   ├── core/
│   │   ├── dependency_injection/   # get_it + injectable (Dio, SecureStorage, PackageInfo…)
│   │   ├── l10n/                   # flutter_localizations (EN + ES)
│   │   ├── observers/              # AppBlocObserver
│   │   ├── router/                 # go_router + AuthNotifier (auth guard, deep links)
│   │   ├── shared/                 # Result<S,F>, AppFailure, AppException, BaseBloc types
│   │   └── utils/                  # Extensions, helpers, mixins, services
│   ├── features/
│   │   ├── auth/                   # LoginScreen placeholder
│   │   └── home/                   # HomeScreen + ExampleBloc
│   ├── app.dart
│   ├── main_development.dart
│   ├── main_staging.dart
│   └── main_production.dart
├── test/
│   └── widget_test.dart            # 3 smoke tests
├── hooks/                          # pre_gen (validation) + post_gen (fvm + pub get + make)
└── makefile                        # gen, build, and release shortcuts
```

---

## Requirements

- [Mason CLI](https://docs.brickhub.dev) — `dart pub global activate mason_cli`
- [FVM](https://fvm.app) — `dart pub global activate fvm`

---

## Usage

### From brickhub.dev

```bash
mason add app_template
mason make app_template
```

### From this repository

```bash
mason add app_template --git-url https://github.com/raytorresch/app_template
mason make app_template
```

### Locally (for development)

```bash
git clone https://github.com/raytorresch/flutter_saas_brick
cd flutter_saas_brick
make use                        # interactive prompts → ./output
make use dir=../my_saas_app     # interactive prompts → custom path
```

**Skip prompts with a config file:**

```bash
cp config.example.json config.json   # create your local config (git-ignored)
# edit config.json with your values
make use-config                      # no prompts → ./output
make use-config dir=../my_saas_app   # no prompts → custom path
```

---

## Variables

| Variable | Type | Default | Description |
|----------|------|---------|-------------|
| `projectName` | `string` | `my_app` | Dart package name (snake_case). Used in `pubspec.yaml` and all imports. |
| `projectDescription` | `string` | `A new Flutter project…` | Description for `pubspec.yaml`. |
| `appName` | `string` | `My awesome app` | Display name shown when the app is installed. |
| `bundleId` | `string` | `com.awesome.app` | iOS bundle ID / Android application ID (e.g. `com.company.app`). |
| `flutterVersion` | `string` | `3.13.6` | Flutter version that FVM will activate (e.g. `3.24.5`). |

### `config.json` (optional, git-ignored)

Copy `config.example.json` to `config.json` and fill in your values to use `make use-config` without prompts:

```json
{
  "projectName": "my_saas_app",
  "projectDescription": "A production-ready Flutter SaaS application.",
  "appName": "My SaaS App",
  "bundleId": "com.company.myapp",
  "flutterVersion": "3.24.5"
}
```

> `config.json` is listed in `.gitignore` — never committed.

---

## Key decisions

| Concern | Choice | Why |
|---------|--------|-----|
| Routing | `go_router` | Deep linking, named routes, auth redirect guard |
| Auth state | `AuthNotifier` + `flutter_secure_storage` | Reactive, session-persistent, OS-level encryption |
| DI | `get_it` + `injectable` | Compile-safe, minimal boilerplate |
| State management | `flutter_bloc` | Predictable, testable, widely adopted |
| Code generation | `freezed` + `json_serializable` + `build_runner` | Immutable models, exhaustive pattern matching |
| Linting | `very_good_analysis` | Strict, production-grade ruleset |
| Flavors | development / staging / production | Isolated entry points and API URLs from day one |

---

## Development

```bash
make hooks    # install hook dependencies
make analyze  # dart analyze on hooks
make bundle   # bundle brick for brickhub.dev
make publish  # publish to brickhub.dev (requires mason login)
```

---

## Contributing

1. Fork the repository
2. Create a branch: `git checkout -b feat/your-feature`
3. Commit following [Conventional Commits](https://www.conventionalcommits.org): `feat:`, `fix:`, `docs:`, `chore:`
4. Open a Pull Request

---

## License

MIT — see [LICENSE](LICENSE).

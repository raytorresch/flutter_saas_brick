import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Stores non-sensitive user preferences.
/// Sensitive data (tokens, credentials) lives in [SecureStorageService].
@lazySingleton
class PreferencesService {
  const PreferencesService(this._prefs);

  final SharedPreferences _prefs;

  // ---------------------------------------------------------------------------
  // Example preference — add project-specific keys here.
  // ---------------------------------------------------------------------------

  bool get onboardingCompleted =>
      _prefs.getBool('onboarding_completed') ?? false;

  set onboardingCompleted(bool value) =>
      _prefs.setBool('onboarding_completed', value);

  Future<void> clear() => _prefs.clear();
}

import 'package:{{projectName}}/core/utils/services/secure_storage_service.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

/// Notifies [GoRouter] of authentication state changes so the redirect
/// guard re-evaluates on every login / logout.
@lazySingleton
class AuthNotifier extends ChangeNotifier {
  AuthNotifier(this._secureStorage);

  final SecureStorageService _secureStorage;

  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;

  /// Call once at startup (after DI is ready) to restore persisted auth state.
  Future<void> initialize() async {
    _isAuthenticated = await _secureStorage.hasToken;
    notifyListeners();
  }

  /// Persists [token] and marks the session as authenticated.
  Future<void> setAuthenticated(String token) async {
    await _secureStorage.setToken(token);
    _isAuthenticated = true;
    notifyListeners();
  }

  /// Clears stored credentials and marks the session as unauthenticated.
  Future<void> logout() async {
    await _secureStorage.clear();
    _isAuthenticated = false;
    notifyListeners();
  }
}

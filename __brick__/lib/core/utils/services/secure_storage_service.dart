import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SecureStorageService {
  const SecureStorageService(this._storage);

  final FlutterSecureStorage _storage;

  static const _tokenKey = 'auth_token';

  Future<String?> get token => _storage.read(key: _tokenKey);

  Future<void> setToken(String value) =>
      _storage.write(key: _tokenKey, value: value);

  Future<void> deleteToken() => _storage.delete(key: _tokenKey);

  Future<bool> get hasToken async {
    final value = await _storage.read(key: _tokenKey);
    return value != null && value.isNotEmpty;
  }

  Future<void> clear() => _storage.deleteAll();
}

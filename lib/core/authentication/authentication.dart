import 'package:oulun_energia_mobile/core/storage/secure_storage.dart';

class Authentication {
  static const String _accessTokenStorageKey = "access_token";
  static const String _userAuthStorageKey = "user_auth";
  final SecureStorage _storage = SecureStorage();

  Future<String?> getAuthenticationToken() async {
    return await _storage.read(_accessTokenStorageKey);
  }

  Future<void> setAuthenticationToken(String token) async {
    return await _storage.write(_accessTokenStorageKey, token);
  }

  Future<String?> getUserAuth() async {
    return await _storage.read(_userAuthStorageKey);
  }

  Future<void> setUserAuth(String? auth) async {
    return await _storage.write(_userAuthStorageKey, auth ?? "");
  }
}

enum AuthenticationError { unauthorized }

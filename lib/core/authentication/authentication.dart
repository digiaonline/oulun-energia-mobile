import 'package:oulun_energia_mobile/core/storage/secure_storage.dart';

class Authentication {
  static const String _accessTokenStorageKey = "access_token";
  final SecureStorage _storage = SecureStorage();

  Future<String?> getAuthenticationToken() async {
    return await _storage.read(_accessTokenStorageKey);
  }

  Future<void> setAuthenticationToken(String token) async {
    return await _storage.write(_accessTokenStorageKey, token);
  }
}

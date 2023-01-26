import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// This class can't be tested since flutter_secure_storage will crash the process
// coverage:ignore-file
class SecureStorage {
  final _storage = const FlutterSecureStorage();

  IOSOptions _getIosOptions() =>
      const IOSOptions(accountName: /* TODO */ "OmaMobiAccountName");

  AndroidOptions _getAndroidOptions() =>
      const AndroidOptions(encryptedSharedPreferences: true);

  Future<void> write(String key, String value) async {
    final result = await _storage.write(
      key: key,
      value: value,
      iOptions: _getIosOptions(),
      aOptions: _getAndroidOptions(),
    );
    return result;
  }

  Future<String?> read(String key) async {
    final value = await _storage.read(
      key: key,
      iOptions: _getIosOptions(),
      aOptions: _getAndroidOptions(),
    );
    return value;
  }
}

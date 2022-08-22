import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../authentication/authentication_method.dart';

class SecureStorageMethods {
  final _storage = const FlutterSecureStorage();

  Future<void> writeSecureUserData({
    required String email,
    required String password,
    required String userName,
  }) async {
    await _storage.write(key: "KEY_EMAIL", value: email);
    await _storage.write(key: "KEY_PASSWORD", value: password);
    await _storage.write(key: "KEY_USER_NAME", value: userName);
  }

  Future<String> getUserNameFromSecureStorage() async {
    String? a = await _storage.read(key: "KEY_USER_NAME");
    return a ?? "UNKNOWN";
  }

  Future<String> getUserPasswordFromSecureStorage() async {
    String? a = await _storage.read(key: "KEY_PASSWORD");
    return a ?? "UNKNOWN";
  }

  Future<String> getUserEmailromSecureStorage() async {
    String? a = await _storage.read(key: "KEY_EMAIL");
    return a ?? "UNKNOWN";
  }

  Future<void> deleteAll() async {
    temporaryUserImage = null;
    temporaryWeightValue = 0;
    temporaryAgeValue = 0;
    temporaryHeightValue = 0;
    temporaryGender = "male";
    await _storage.deleteAll();
  }
}

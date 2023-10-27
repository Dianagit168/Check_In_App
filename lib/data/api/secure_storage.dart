import 'package:check_in_app/index.dart';

class SecureStorage {

  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  static Future<String>? readSecure(String key) async {

    String? res = await _storage.read(key: key);
    return res!;
  }
  static Future<void> writeSecure(String key, dynamic value) async {
    await _storage.write(key: key, value: value);
  }
  
  static Future<void> writeSecureList(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  static Future<void> clearByKeySecure(String key) async {
    await _storage.delete(key: key);
  }

  static Future<void> clearAllSecure() async {
    await _storage.deleteAll();
  }

  static Future<bool> isKeyAvailable(String key) async {
    return await _storage.containsKey(key: key);
  }
  
}
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Credentials {
  static Future<void> saveTokens(
      String accessToken, String refreshToken) async {
    final storage = FlutterSecureStorage();
    await storage.deleteAll();
    await storage.write(key: 'accessToken', value: accessToken);
    await storage.write(key: 'refreshToken', value: accessToken);
  }

  static Future<String> getAccessToken() async {
    final storage = FlutterSecureStorage();
    return await storage.read(key: 'accessToken');
  }

  static Future<String> getRefreshToken() async {
    final storage = FlutterSecureStorage();
    return await storage.read(key: 'refreshToken');
  }
}

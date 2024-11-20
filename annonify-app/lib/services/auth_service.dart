import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class AuthService extends GetxService {
  final _storage = const FlutterSecureStorage();
  String? userId;

  // Save userId and JWT token
  Future<void> saveLoginData(String userId, String token) async {
    await _storage.write(key: 'user_id', value: userId);
    await _storage.write(key: 'jwt_token', value: token);
  }

  // Get userId
  Future<String?> getUserId() async {
    userId = await _storage.read(key: 'user_id');
    return userId;
  }

  // Get JWT token
  Future<String?> getToken() async {
    return await _storage.read(key: 'jwt_token');
  }

  // Remove login data
  Future<void> removeLoginData() async {
    await _storage.delete(key: 'user_id');
    await _storage.delete(key: 'jwt_token');
  }

  // Check if user is authenticated
  Future<bool> isAuthenticated() async {
    final token = await getToken();
    getUserId();
    return token != null && token.isNotEmpty;
  }
}

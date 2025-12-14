import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';

class AuthService extends ChangeNotifier {
  static const _tokenKey = 'auth_token';

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  Future<void> _setToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
    notifyListeners();
  }

  Future<void> saveToken(String token) async {
    await _setToken(token);
  }

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final client = DioClient();

    try {
      final Response res = await client.post('/auth/login', {
        'email': email,
        'password': password,
      });

      final Map<String, dynamic> body =
          res.data is Map ? Map<String, dynamic>.from(res.data) : {};

      final token = body['data']?['token'] as String?;

      if (token != null) {
        await _setToken(token);
        if (kDebugMode) print('TOKEN SAVED: $token');
      } else {
        print("⚠️ TOKEN NOT FOUND IN LOGIN RESPONSE");
      }

      return body;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    String? phone,
    required String password,
    required String passwordConfirmation,
    required int gender,
  }) async {
    final client = DioClient();

    try {
      final Response res = await client.post('/auth/register', {
        'name': name,
        'email': email,
        if (phone != null) 'phone': phone,
        'gender': gender,
        'password': password,
        'password_confirmation': passwordConfirmation,
      });

      final Map<String, dynamic> body =
          res.data is Map ? Map<String, dynamic>.from(res.data) : {};

      final token = body['data']?['token'] as String?;

      if (token != null) {
        await _setToken(token);
      } else {
        print("⚠️ TOKEN NOT FOUND IN REGISTER RESPONSE");
      }

      return body;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }
}

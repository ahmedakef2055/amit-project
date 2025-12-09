import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';

class AuthService extends ChangeNotifier {
  static const _tokenKey = 'auth_token';

  // ---------------- GET TOKEN ----------------
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_tokenKey);

    if (kDebugMode) print("💾 READ TOKEN: $token");

    return token;
  }

  // ---------------- SAVE TOKEN ----------------
  Future<void> _setToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);

    if (kDebugMode) print("💾 SAVED TOKEN: $token");

    notifyListeners();
  }

  // PUBLIC saveToken
  Future<void> saveToken(String token) async {
    await _setToken(token);
  }

  // ---------------- LOGIN ----------------
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

      final Map<String, dynamic> body = Map<String, dynamic>.from(res.data);

      final token = body['data']?['token'];

      if (token != null) {
        await _setToken(token);
      } else {
        print("❌ TOKEN NOT FOUND IN LOGIN RESPONSE");
      }

      return body;

    } catch (e) {
      print("❌ LOGIN ERROR: $e");
      rethrow;
    }
  }

  // ---------------- REGISTER ----------------
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

      final Map<String, dynamic> body = Map<String, dynamic>.from(res.data);
      final token = body['data']?['token'];

      if (token != null) {
        await _setToken(token);
      }

      return body;

    } catch (e) {
      print("❌ REGISTER ERROR: $e");
      rethrow;
    }
  }

  // ---------------- LOGOUT ----------------
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    print("🔒 TOKEN REMOVED");
  }
}

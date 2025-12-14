import 'dart:convert';
import 'package:http/http.dart' as http;

class UserService {
  static const String baseUrl =
      "https://vcare.integration25.com/api";

  static Future<Map<String, dynamic>?> getProfile(String token) async {
    final response = await http.get(
      Uri.parse("$baseUrl/user/profile"),
      headers: {
        "Authorization": "Bearer $token",
        "Accept": "application/json",
      },
    );

    final body = jsonDecode(response.body);

    if (response.statusCode == 200 && body["status"] == true) {
      return body["data"][0]; 
    }

    print("❌ GET PROFILE ERROR: ${response.body}");
    return null;
  }

  static Future<bool> updateProfile({
    required String token,
    required String name,
    required String email,
    required String phone,
    required int gender,
    String? password,
  }) async {
    final Map<String, String> body = {
      "name": name,
      "email": email,
      "phone": phone,
      "gender": gender.toString(),
    };

    if (password != null && password.isNotEmpty) {
      body["password"] = password;
      body["password_confirmation"] = password;
    }

    final response = await http.post(
      Uri.parse("$baseUrl/user/update"),
      headers: {
        "Authorization": "Bearer $token",
        "Accept": "application/json",
      },
      body: body,
    );

    final resBody = jsonDecode(response.body);

    print("📌 UPDATE PROFILE BODY: $body");
    print("📌 UPDATE PROFILE RESPONSE: $resBody");

    return response.statusCode == 200 && resBody["status"] == true;
  }
}

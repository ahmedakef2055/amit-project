import 'dart:convert';
import 'package:http/http.dart' as http;

class HomeService {
  static const String baseUrl =
      "https://vcare.integration25.com/api";

  static Future<List<dynamic>> getHomeDoctors(String token) async {
    final response = await http.get(
      Uri.parse("$baseUrl/home/index"),
      headers: {
        "Authorization": "Bearer $token",
        "Accept": "application/json",
      },
    );

    final body = jsonDecode(response.body);

    if (response.statusCode == 200 && body["status"] == true) {
      List<dynamic> allDoctors = [];

      for (var spec in body["data"]) {
        if (spec["doctors"] != null) {
          allDoctors.addAll(spec["doctors"]);
        }
      }

      return allDoctors;
    } else {
      print("❌ HOME ERROR: ${response.body}");
      return [];
    }
  }
}

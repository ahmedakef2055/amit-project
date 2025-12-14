import 'dart:convert';
import 'package:http/http.dart' as http;

class DoctorService {
  static const String baseUrl = "https://vcare.integration25.com/api";
  static Future<List<dynamic>> getAllDoctors(String token) async {
    final response = await http.get(
      Uri.parse("$baseUrl/doctor/index"),
      headers: {
        "Authorization": "Bearer $token",
        "Accept": "application/json",
      },
    );

    final body = jsonDecode(response.body);

    if (response.statusCode == 200 && body["status"] == true) {
      return body["data"];
    } else {
      print("Doctors Error: ${response.body}");
      return [];
    }
  }

  static Future<List<dynamic>> getSpecializations(String token) async {
    final response = await http.get(
      Uri.parse("$baseUrl/specialization/index"),
      headers: {
        "Authorization": "Bearer $token",
        "Accept": "application/json",
      },
    );

    final body = jsonDecode(response.body);

    if (response.statusCode == 200 && body["status"] == true) {
      return body["data"];
    } else {
      print("Specialization Error: ${response.body}");
      return [];
    }
  }

  static Future<List<dynamic>> getCities(String token) async {
    final response = await http.get(
      Uri.parse("$baseUrl/city/index"),
      headers: {
        "Authorization": "Bearer $token",
        "Accept": "application/json",
      },
    );

    final body = jsonDecode(response.body);

    if (response.statusCode == 200 && body["status"] == true) {
      return body["data"];
    } else {
      print("City Error: ${response.body}");
      return [];
    }
  }
}

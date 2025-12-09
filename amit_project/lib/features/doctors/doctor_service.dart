import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/doctor.dart';

class DoctorService {
  static const String baseUrl = "https://vcare.integration25.com/api";

  static Future<List<Doctor>> getAllDoctors(String token) async {
    print("🔑 USING TOKEN IN HTTP: $token");

    final response = await http.get(
      Uri.parse("$baseUrl/doctor/index"),
      headers: {
        "Authorization": "Bearer $token",
        "Accept": "application/json",
      },
    );

    print("🌐 STATUS CODE: ${response.statusCode}");
    print("📩 BODY: ${response.body}");

    if (response.statusCode != 200) {
      print("❌ Error: status != 200");
      return [];
    }

    final body = json.decode(response.body);

    if (body["status"] == false) {
      print("❌ API returned status:false");
      return [];
    }

    List data = body["data"];
    return data.map((e) => Doctor.fromJson(e)).toList();
  }
}
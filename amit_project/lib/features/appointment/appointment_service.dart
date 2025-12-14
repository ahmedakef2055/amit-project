import 'dart:convert';
import 'package:http/http.dart' as http;

class AppointmentService {
  static const String baseUrl = "https://vcare.integration25.com/api";

  static Future<bool> storeAppointment({
  required String token,
  required int doctorId,
  required String startTime,
  String? notes,
}) async {
  final response = await http.post(
    Uri.parse("$baseUrl/appointment/store"),
    headers: {
      "Authorization": "Bearer $token",
      "Accept": "application/json",
    },
    body: {
      "doctor_id": doctorId.toString(),
      "start_time": startTime,
      if (notes != null && notes.isNotEmpty) "notes": notes,
    },
  );

  final body = jsonDecode(response.body);

  print("📌 STORE APPOINTMENT STATUS CODE: ${response.statusCode}");
  print("📌 STORE APPOINTMENT RESPONSE: $body");

  return body["status"] == true;
}
}

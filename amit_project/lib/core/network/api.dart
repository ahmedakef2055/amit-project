// api.dart
class Api {
  // -------------------------
  // BASE URL (Postman URL)
  // -------------------------
  static const String baseUrl = "https://vcare.integration25.com/api";

  // -------------------------
  // AUTH ENDPOINTS (طبقاً للـ Postman)
  // -------------------------
  static const String login = "$baseUrl/auth/login";
  static const String register = "$baseUrl/auth/register";

  // -------------------------
  // DOCTORS ENDPOINTS
  // -------------------------
  static const String getDoctors = "$baseUrl/doctor/list";
  static const String getDoctorById = "$baseUrl/doctor/"; // + id

  // -------------------------
  // APPOINTMENTS ENDPOINTS
  // -------------------------
  static const String createAppointment = "$baseUrl/appointment/book";
  static const String userAppointments = "$baseUrl/appointment/user/"; // + userId
  static const String doctorAppointments = "$baseUrl/appointment/doctor/"; // + doctorId
}

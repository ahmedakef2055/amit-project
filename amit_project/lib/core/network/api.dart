
class Api {
  static const String baseUrl = "https://vcare.integration25.com/api";
  static const String login = "$baseUrl/auth/login";
  static const String register = "$baseUrl/auth/register";
  static const String getDoctors = "$baseUrl/doctor/list";
  static const String getDoctorById = "$baseUrl/doctor/"; 
  static const String createAppointment = "$baseUrl/appointment/book";
  static const String userAppointments = "$baseUrl/appointment/user/"; 
  static const String doctorAppointments = "$baseUrl/appointment/doctor/"; 
}

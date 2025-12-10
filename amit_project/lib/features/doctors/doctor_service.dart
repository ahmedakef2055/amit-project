import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../models/doctor.dart';

class DoctorService {
  static Future<List<Doctor>> getAllDoctors() async {
    final Response res = await DioClient().get("/doctor/index");

    print("📥 DOCTORS RES: ${res.data}");

    if (res.data["status"] == false) return [];

    List list = res.data["data"];
    return list.map((e) => Doctor.fromJson(e)).toList();
  }
}

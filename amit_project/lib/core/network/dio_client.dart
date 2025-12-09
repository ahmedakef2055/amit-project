import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../features/auth/auth_service.dart';
import 'api.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();
  factory DioClient() => _instance;

  late Dio dio;

  DioClient._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: Api.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // هات التوكن بشكل مباشر
          final token = await AuthService().getToken();

          if (token != null && token.isNotEmpty) {
            options.headers["Authorization"] = "Bearer $token";
            if (kDebugMode) print("🔐 USING TOKEN: $token");
          } else {
            if (kDebugMode) print("❌ NO TOKEN FOUND");
          }

          return handler.next(options);
        },

        onResponse: (response, handler) {
          if (kDebugMode) {
            print("📥 RESPONSE: ${response.data}");
          }
          return handler.next(response);
        },

        onError: (DioException e, handler) {
          if (kDebugMode) {
            print("❌ ERROR: ${e.response?.data}");
          }
          return handler.next(e);
        },
      ),
    );
  }

  Future<Response> get(String endpoint) => dio.get(endpoint);

  Future<Response> post(String endpoint, Map<String, dynamic> data) =>
      dio.post(endpoint, data: data);
}
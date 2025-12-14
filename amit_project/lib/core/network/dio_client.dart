import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import '../../features/auth/auth_service.dart';
import '../global/global.dart';
import 'api.dart';
import 'package:provider/provider.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();
  factory DioClient() => _instance;

  late Dio dio;

  DioClient._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: Api.baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {
          "Content-Type": "application/json",
        },
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          try {
            final context = navigatorKey.currentContext;

            if (context != null) {
              final auth = Provider.of<AuthService>(context, listen: false);
              final token = await auth.getToken();

              if (token != null && token.isNotEmpty) {
                options.headers["Authorization"] = "Bearer $token";
                print("🔐 USING TOKEN: $token");
              } else {
                print("⚠️ NO TOKEN FOUND");
              }
            }
          } catch (e) {
            print("⚠️ TOKEN READ ERROR: $e");
          }

          return handler.next(options);
        },

        onResponse: (response, handler) {
          print("📥 RESPONSE: ${response.data}");
          return handler.next(response);
        },

        onError: (e, handler) {
          print("❌ ERROR: ${e.response?.data}");
          return handler.next(e);
        },
      ),
    );
  }

  Future<Response> get(String endpoint) => dio.get(endpoint);

  Future<Response> post(String endpoint, Map<String, dynamic> data) =>
      dio.post(endpoint, data: data);
}

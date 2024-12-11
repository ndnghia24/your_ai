import 'package:dio/dio.dart';
import 'package:your_ai/configs/service_locator.dart';
import 'package:your_ai/core/network/dio_client.dart';

class KnowledgeAuthService {
  final Dio dio = locator<DioClient>().dio;
  String? accessToken;
  String? refreshToken;

  Future<Response> signInWithEmailAndPassword(String email, String password) async {
    final payload = {
      "email": email,
      "password": password,
      "remember": true
    };

    final res = await dio.post(
      'https://knowledge-api.jarvis.cx/kb-core/v1/auth/sign-in',
      data: payload,
    );

    if (res.statusCode == 200) {
      accessToken = res.data['token']['accessToken'];
      refreshToken = res.data['token']['refreshToken'];
    }

    return res;
  }
}
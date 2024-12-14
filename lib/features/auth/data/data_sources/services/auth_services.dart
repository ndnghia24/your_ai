import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:your_ai/core/network/dio_clients/jarvis_dio_client.dart';
import 'package:your_ai/core/storage/spref/spref.dart';
import 'package:your_ai/features/auth/presentation/ui/login_or_register_screen.dart';

final String? baseUrl = dotenv.env['API_URL'];

class AuthService {
  String? accessToken;
  String? refreshToken;
  final Dio _dio = getIt<JarvisDioClient>().dio;

  AuthService._privateConstructor() {
    _initializeTokens();
  }

  static final AuthService _instance = AuthService._privateConstructor();

  factory AuthService() {
    return _instance;
  }

  Future<void> _initializeTokens() async {
    accessToken = await SPref.instance.getJarvisAccessToken();
    refreshToken = await SPref.instance.getJarvisRefreshToken();
  }

  Future<Response> login(Map<String, dynamic> credentials) async {
    final res = await _dio.post(
      '$baseUrl/auth/sign-in',
      data: credentials,
    );

    if (res.statusCode == 200) {
      accessToken = res.data['token']['accessToken'];
      refreshToken = res.data['token']['refreshToken'];
    }

    return res;
  }

  Future<Response> loginWithGoogleToken(String googleToken) async {
    final res = await _dio.post(
      '$baseUrl/auth/google-sign-in',
      data: {'token': googleToken},
    );

    if (res.statusCode == 200) {
      accessToken = res.data['token']['accessToken'];
      refreshToken = res.data['token']['refreshToken'];
    }

    return res;
  }

  Future<Response> signup(Map<String, dynamic> userInfo) async {
    return await _dio.post(
      '$baseUrl/auth/sign-up',
      data: userInfo,
    );
  }

  Future<Response> getUserInfo() async {
    return await _dio.get(
      '$baseUrl/auth/me',
      options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
    );
  }

  Future<Response> getTokenUsage() async {
    return await _dio.get('$baseUrl/tokens/usage',
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}));
  }

  // logout
  Future<Response> logout() async {
    final res = await _dio.get('$baseUrl/auth/sign-out',
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}));

    if (res.statusCode == 200) {
      accessToken = '';
      refreshToken = '';
      await SPref.instance.setJarvisAccessToken('');
      await SPref.instance.setJarvisRefreshToken('');
    }

    return res;
  }
}

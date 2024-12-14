import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:your_ai/core/network/dio_clients/jarvis_dio_client.dart';
import 'package:your_ai/core/storage/spref/spref.dart';
import 'package:your_ai/features/auth/presentation/ui/login_or_register_screen.dart';

final String? baseUrl = dotenv.env['API_URL'];

class ChatPromptService {
  String? accessToken;
  String? refreshToken;
  final Dio _dio = getIt<JarvisDioClient>().dio;

  ChatPromptService._privateConstructor() {
    _initializeTokens();
  }

  static final ChatPromptService _instance =
      ChatPromptService._privateConstructor();

  factory ChatPromptService() {
    return _instance;
  }

  Future<void> _initializeTokens() async {
    accessToken = await SPref.instance.getJarvisAccessToken();
    refreshToken = await SPref.instance.getJarvisRefreshToken();
  }

/*
  Future<Response> createNewChat(Map<String, dynamic> body) async {
    return await _dio.post(
      '$baseUrl/ai-chat/messages',
      data: body,
      options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
    );
  }
*/

  Future<Response> getAllPrompts(Map<String, dynamic> params) async {
    return await _dio.get(
      '$baseUrl/prompts',
      queryParameters: params,
      options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
    );
  }

  Future<Response> createNewPrompt(Map<String, dynamic> body) async {
    return await _dio.post(
      '$baseUrl/prompts',
      data: body,
      options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
    );
  }

  Future<Response> updatePrompt(
      {required String promptId, required Map<String, dynamic> body}) async {
    return await _dio.patch(
      '$baseUrl/prompts/$promptId',
      data: body,
      options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
    );
  }

  Future<Response> deletePrompt({required String promptId}) async {
    return await _dio.delete(
      '$baseUrl/prompts/$promptId',
      options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
    );
  }

  Future<Response> addPromptToFavorite({required String promptId}) async {
    return await _dio.post(
      '$baseUrl/prompts/$promptId/favorite',
      options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
    );
  }

  Future<Response> removePromptFromFavorite({required String promptId}) async {
    return await _dio.delete(
      '$baseUrl/prompts/$promptId/favorite',
      options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
    );
  }
}

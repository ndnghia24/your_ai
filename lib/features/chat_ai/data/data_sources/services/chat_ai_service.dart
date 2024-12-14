import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:your_ai/core/network/dio_clients/jarvis_dio_client.dart';
import 'package:your_ai/core/storage/spref/spref.dart';
import 'package:your_ai/features/auth/presentation/ui/login_or_register_screen.dart';

final String? baseUrl = dotenv.env['API_URL'];

class ChatAIService {
  String? accessToken;
  String? refreshToken;
  final Dio _dio = getIt<JarvisDioClient>().dio;

  ChatAIService._privateConstructor() {
    _initializeTokens();
  }

  static final ChatAIService _instance = ChatAIService._privateConstructor();

  factory ChatAIService() {
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
  Future<Response> getRemainingQuery() async {
    return await _dio.get(
      '$baseUrl/tokens/usage',
      options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
    );
  }

  Future<Response> sendMessage(Map<String, dynamic> body) async {
    return await _dio.post(
      '$baseUrl/ai-chat/messages',
      data: body,
      options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
    );
  }

  Future<Response> getConversationList(Map<String, dynamic> params) async {
    return await _dio.get(
      '$baseUrl/ai-chat/conversations',
      queryParameters: params,
      options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
    );
  }

  Future<Response> getConversationMessages(
      {required String conversationId,
      required Map<String, dynamic> params}) async {
    return await _dio.get(
      '$baseUrl/ai-chat/conversations/$conversationId/messages',
      queryParameters: params,
      options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
    );
  }
}

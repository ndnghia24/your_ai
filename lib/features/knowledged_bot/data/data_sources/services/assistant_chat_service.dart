// Vị trí: lib/services/assistant_chat_service.dart

import 'package:dio/dio.dart';
import 'package:your_ai/configs/service_locator.dart';
import 'package:your_ai/core/network/dio_client.dart';

class AssistantChatService {
  final String token;
  final Dio dio = locator<DioClient>().dio;
  final String baseUrl =
      'https://knowledge-api.jarvis.cx/kb-core/v1/ai-assistant';

  AssistantChatService(this.token);

  // Lấy danh sách các thread của Assistant
  Future<Response> getThreads(String assistantId) async {
    try {
      final response = await dio.get(
        '$baseUrl/$assistantId/threads',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      return response; // Trả về Response từ Dio
    } catch (e) {
      throw Exception('Failed to load thread details: $e');
    }
  }

  // Lấy chi tiết các threads của Assistant
  Future<Response> getThreadDetails(String openAiThreadId) async {
    try {
      final response = await dio.get(
        '$baseUrl/thread/$openAiThreadId/messages',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      return response; // Trả về Response từ Dio
    } catch (e) {
      throw Exception('Failed to load thread details: $e');
    }
  }

  // Tạo thread mới cho Assistant
  Future<Response> createThread(String assistantId, String firstMessage) async {
    try {
      final response = await dio.post(
        '$baseUrl/thread',
        data: {
          'assistantId': assistantId,
          'firstMessage': firstMessage,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );
      return response; // Trả về Response từ Dio
    } catch (e) {
      throw Exception('Failed to create thread: $e');
    }
  }

  // Tiếp tục cuộc trò chuyện
  Future<Response> continueChat(
      String assistantId, String message, String openAiThreadId,
      {String additionalInstruction = ''}) async {
    try {
      final response = await dio.post(
        '$baseUrl/$assistantId/ask',
        data: {
          'message': message,
          'openAiThreadId': openAiThreadId,
          'additionalInstruction': additionalInstruction,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );
      return response; // Trả về Response từ Dio
    } catch (e) {
      throw Exception('Failed to continue chat: $e');
    }
  }
}

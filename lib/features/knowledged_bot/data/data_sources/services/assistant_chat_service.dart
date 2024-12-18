import 'package:dio/dio.dart';
import 'package:your_ai/configs/service_locator.dart';
import 'package:your_ai/core/network/dio_clients/kb_dio_client.dart';

class AssistantChatService {
  final String token;
  final Dio dio = locator<KBDioClient>().dio;

  AssistantChatService(this.token);

  Future<Response> getThreads(String assistantId) async {
    try {
      final response = await dio.get(
        '/ai-assistant/$assistantId/threads',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      return response;
    } catch (e) {
      throw Exception('Failed to load thread details: $e');
    }
  }

  Future<Response> getThreadDetails(String openAiThreadId) async {
    try {
      final response = await dio.get(
        '/ai-assistant/thread/$openAiThreadId/messages',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      return response;
    } catch (e) {
      throw Exception('Failed to load thread details: $e');
    }
  }

  Future<Response> createThread(String assistantId, String firstMessage) async {
    try {
      final response = await dio.post(
        '/ai-assistant/thread',
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
      return response;
    } catch (e) {
      throw Exception('Failed to create thread: $e');
    }
  }

  Future<Response> continueChat(
      String assistantId, String message, String openAiThreadId,
      {String additionalInstruction = ''}) async {
    try {
      final response = await dio.post(
        '/ai-assistant/$assistantId/ask',
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
      return response;
    } catch (e) {
      throw Exception('Failed to continue chat: $e');
    }
  }
}

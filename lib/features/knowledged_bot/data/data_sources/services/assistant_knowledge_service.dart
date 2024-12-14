// Vị trí: lib/services/assistant_knowledge_service.dart

import 'package:dio/dio.dart';
import 'package:your_ai/configs/service_locator.dart';
import 'package:your_ai/core/network/dio_clients/jarvis_dio_client.dart';

class AssistantKnowledgeService {
  final String token;
  final Dio dio = locator<JarvisDioClient>().dio;
  final String baseUrl =
      'https://knowledge-api.jarvis.cx/kb-core/v1/ai-assistant';

  AssistantKnowledgeService(this.token);

  // Lấy danh sách Knowledge gắn với Assistant
  Future<Response> getAttachedKnowledges(String assistantId) async {
    try {
      final response = await dio.get(
        '$baseUrl/$assistantId/knowledges',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      return response; // Trả về Response từ Dio
    } catch (e) {
      throw Exception('Failed to get attached knowledges: $e');
    }
  }

  // Gắn Knowledge cho Assistant
  Future<Response> attachKnowledge(
      String assistantId, String knowledgeId) async {
    try {
      final response = await dio.post(
        '$baseUrl/$assistantId/knowledges/$knowledgeId',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      return response; // Trả về Response từ Dio
    } catch (e) {
      throw Exception('Failed to attach knowledge: $e');
    }
  }

  // Tách Knowledge khỏi Assistant
  Future<Response> detachKnowledge(
      String assistantId, String knowledgeId) async {
    try {
      final response = await dio.delete(
        '$baseUrl/$assistantId/knowledges/$knowledgeId',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      return response; // Trả về Response từ Dio
    } catch (e) {
      throw Exception('Failed to detach knowledge: $e');
    }
  }
}

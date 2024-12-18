import 'package:dio/dio.dart';
import 'package:your_ai/configs/service_locator.dart';
import 'package:your_ai/core/network/dio_clients/jarvis_dio_client.dart';

class AssistantKnowledgeService {
  final String token;
  final Dio dio = locator<JarvisDioClient>().dio;

  AssistantKnowledgeService(this.token);

  Future<Response> getAttachedKnowledges(String assistantId) async {
    try {
      final response = await dio.get(
        '/ai-assistant/$assistantId/knowledges',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      return response; // Trả về Response từ Dio
    } catch (e) {
      throw Exception('Failed to get attached knowledges: $e');
    }
  }

  Future<Response> attachKnowledge(
      String assistantId, String knowledgeId) async {
    try {
      final response = await dio.post(
        '/ai-assistant/$assistantId/knowledges/$knowledgeId',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      return response;
    } catch (e) {
      throw Exception('Failed to attach knowledge: $e');
    }
  }

  Future<Response> detachKnowledge(
      String assistantId, String knowledgeId) async {
    try {
      final response = await dio.delete(
        '/ai-assistant/$assistantId/knowledges/$knowledgeId',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      return response;
    } catch (e) {
      throw Exception('Failed to detach knowledge: $e');
    }
  }
}

import 'package:dio/dio.dart';
import 'package:your_ai/configs/service_locator.dart';
import 'package:your_ai/core/network/dio_clients/kb_dio_client.dart';

class AssistantKnowledgeService {
  final Dio dio = locator<KBDioClient>().dio;

  AssistantKnowledgeService();

  Future<Response> getAttachedKnowledges(String assistantId) async {
    try {
      final response = await dio.get(
        '/knowledge/assistant-relationship/$assistantId?offset=0&limit=10',
      );
      return response;
    } catch (e) {
      throw Exception('Failed to get attached knowledges: $e');
    }
  }

  Future<Response> attachKnowledge(
      String assistantId, String knowledgeId) async {
    try {
      final response = await dio.post(
        '/ai-assistant/$assistantId/knowledges/$knowledgeId',
      );
      print('SER: $response');
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
      );
      return response;
    } catch (e) {
      throw Exception('Failed to detach knowledge: $e');
    }
  }
}

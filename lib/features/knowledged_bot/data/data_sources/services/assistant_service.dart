import 'package:dio/dio.dart';
import 'package:your_ai/configs/service_locator.dart';
import 'package:your_ai/core/network/dio_clients/jarvis_dio_client.dart';

class AssistantService {
  final String token;
  final Dio dio = locator<JarvisDioClient>().dio;

  AssistantService(this.token);

  Future<Response> getAssistants({
    bool? isFavorite,
    bool? isPublished,
    String? order,
    String? orderField,
    int offset = 0,
    int limit = 10,
  }) async {
    try {
      final response = await dio.get(
        '/ai-assistant',
        queryParameters: {
          'is_favorite': isFavorite,
          'is_published': isPublished,
          'order': order,
          'order_field': orderField,
          'offset': offset,
          'limit': limit,
        },
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      return response; // Trả về Response từ Dio
    } catch (e) {
      throw Exception('Failed to load assistants: $e');
    }
  }

  Future<Response> createAssistant(Map<String, dynamic> assistantData) async {
    try {
      final response = await dio.post(
        '/ai-assistant',
        data: assistantData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );
      return response;
    } catch (e) {
      throw Exception('Failed to create assistant: $e');
    }
  }

  Future<Response> updateAssistant(
      String assistantId, Map<String, dynamic> assistantData) async {
    try {
      final response = await dio.patch(
        '/ai-assistant/$assistantId',
        data: assistantData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );
      return response;
    } catch (e) {
      throw Exception('Failed to update assistant: $e');
    }
  }

  Future<Response> deleteAssistant(String assistantId) async {
    try {
      final response = await dio.delete(
        '/ai-assistant/$assistantId',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      return response;
    } catch (e) {
      throw Exception('Failed to delete assistant: $e');
    }
  }
}

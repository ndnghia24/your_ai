// Vị trí: lib/services/assistant_service.dart

import 'package:dio/dio.dart';
import 'package:your_ai/configs/service_locator.dart';
import 'package:your_ai/core/network/dio_clients/jarvis_dio_client.dart';

class AssistantService {
  final String token;
  final Dio dio = locator<JarvisDioClient>().dio;
  final String baseUrl =
      'https://knowledge-api.jarvis.cx/kb-core/v1/ai-assistant';

  AssistantService(this.token);

  // Lấy danh sách Assistants
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
        '$baseUrl',
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

  // Tạo Assistant mới
  Future<Response> createAssistant(Map<String, dynamic> assistantData) async {
    try {
      final response = await dio.post(
        '$baseUrl',
        data: assistantData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );
      return response; // Trả về Response từ Dio
    } catch (e) {
      throw Exception('Failed to create assistant: $e');
    }
  }

  // Cập nhật Assistant
  Future<Response> updateAssistant(
      String assistantId, Map<String, dynamic> assistantData) async {
    try {
      final response = await dio.patch(
        '$baseUrl/$assistantId',
        data: assistantData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );
      return response; // Trả về Response từ Dio
    } catch (e) {
      throw Exception('Failed to update assistant: $e');
    }
  }

  // Xóa Assistant
  Future<Response> deleteAssistant(String assistantId) async {
    try {
      final response = await dio.delete(
        '$baseUrl/$assistantId',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      return response; // Trả về Response từ Dio
    } catch (e) {
      throw Exception('Failed to delete assistant: $e');
    }
  }
}

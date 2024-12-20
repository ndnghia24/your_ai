import 'package:dio/dio.dart';
import 'package:your_ai/configs/service_locator.dart';
import 'package:your_ai/core/network/dio_clients/kb_dio_client.dart';

class AssistantService {
  final Dio dio = locator<KBDioClient>().dio;

  AssistantService();

  Future<Response> getAssistants({
    bool? isFavorite,
    bool? isPublished,
    String? order,
    String? orderField,
    int? offset,
    int? limit,
  }) async {
    try {
      final queryParameters = {
        if (isFavorite != null) 'is_favorite': isFavorite,
        if (isPublished != null) 'is_published': isPublished,
        if (order != null) 'order': order,
        if (orderField != null) 'order_field': orderField,
        if (offset != null) 'offset': offset,
        if (limit != null) 'limit': limit,
      };

      final response = await dio.get(
        '/ai-assistant',
        queryParameters: {
          for (var key in queryParameters.keys)
            if (queryParameters[key] != null) key: queryParameters[key]
        },
      );

      print('SER: ${response.data}');
      return response;
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
      );
      return response;
    } catch (e) {
      throw Exception('Failed to delete assistant: $e');
    }
  }
}

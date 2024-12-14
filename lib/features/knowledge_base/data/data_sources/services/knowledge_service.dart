// Vị trí: lib/features/knowledge/data/services/knowledge_service.dart

import 'package:dio/dio.dart';
import 'package:your_ai/configs/service_locator.dart';
import 'package:your_ai/core/network/dio_client.dart';

class KnowledgeService {
  final Dio dio = locator<DioClient>().dio;

  // Tạo Knowledge
  Future<Response> createKnowledge(
      Map<String, dynamic> knowledgeData, String token) async {
    final response = await dio.post(
      'https://knowledge-api.jarvis.cx/kb-core/v1/knowledge',
      data: knowledgeData,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      ),
    );
    return response;
  }

  // Lấy danh sách Knowledge
  Future<Response> getKnowledgeList(String token) async {
    print('token: $token');
    final response = await dio.get(
      'https://knowledge-api.jarvis.cx/kb-core/v1/knowledge',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      ),
    );
    return response;
  }

  // Cập nhật Knowledge
  Future<Response> updateKnowledge(
      String id, Map<String, dynamic> knowledgeData, String token) async {
    final response = await dio.patch(
      'https://knowledge-api.jarvis.cx/kb-core/v1/knowledge/$id',
      data: knowledgeData,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      ),
    );
    return response;
  }

  // Xóa Knowledge
  Future<Response> deleteKnowledge(String id, String token) async {
    final response = await dio.delete(
      'https://knowledge-api.jarvis.cx/kb-core/v1/knowledge/$id',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      ),
    );
    return response;
  }

  // get KnowledgeUnits
  Future<Response> getKnowledgeUnits(String id, String token) async {
    final response = await dio.get(
      'https://knowledge-api.jarvis.cx/kb-core/v1/knowledge/$id/units',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      ),
    );
    return response;
  }
}

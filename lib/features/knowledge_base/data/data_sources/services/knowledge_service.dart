// Vị trí: lib/features/knowledge/data/services/knowledge_service.dart

import 'package:dio/dio.dart';
import 'package:your_ai/core/network/dio_clients/kb_dio_client.dart';

import '../../../../../configs/service_locator.dart';

class KnowledgeService {
  final Dio dio = locator<KBDioClient>().dio;

  // Tạo Knowledge
  Future<Response> createKnowledge(Map<String, dynamic> knowledgeData) async {
    final response = await dio.post(
      '/knowledge',
      data: knowledgeData,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );
    return response;
  }

  // Lấy danh sách Knowledge
  Future<Response> getKnowledgeList() async {
    final response = await dio.get(
      '/knowledge',
      options: Options(
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );
    return response;
  }

  // Cập nhật Knowledge
  Future<Response> updateKnowledge(
      String id, Map<String, dynamic> knowledgeData) async {
    final response = await dio.patch(
      '/knowledge/$id',
      data: knowledgeData,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );
    return response;
  }

  // Xóa Knowledge
  Future<Response> deleteKnowledge(String id) async {
    final response = await dio.delete(
      '/knowledge/$id',
      options: Options(
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );
    return response;
  }

  // get KnowledgeUnits
  Future<Response> getKnowledgeUnits(String id) async {
    final response = await dio.get(
      '/knowledge/$id/units',
      options: Options(
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );
    return response;
  }

  Future<Response> deleteUnit(String knowledgeID, String id) async {
    final response = await dio.delete(
      '/knowledge/$knowledgeID/units/$id',
      options: Options(
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );
    return response;
  }
}

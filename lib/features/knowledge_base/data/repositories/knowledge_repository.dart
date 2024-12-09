import 'package:your_ai/core/templates/data_sources_result_template.dart';
import 'package:your_ai/features/knowledge_base/data/data_sources/knowledge_remote_data_source.dart';
import 'package:your_ai/features/knowledge_base/domain/entities/knowledge_model.dart';
import 'package:your_ai/features/knowledge_base/domain/entities/unit_model.dart';

class KnowledgeRepository {
  final KnowledgeRemoteDataSource remoteDataSource;

  KnowledgeRepository(this.remoteDataSource);

  /// Helper method to handle responses
  T handleResponse<T>(
      DataSourcesResultTemplate res, T Function(dynamic) parser) {
    if (!res.isSuccess || res.data == null) {
      throw Exception(res.message ?? 'An error occurred');
    }
    return parser(res.data);
  }

  // Tạo Knowledge mới
  Future<Knowledge> createKnowledge(
      Map<String, dynamic> knowledgeData, String token) async {
    final res = await remoteDataSource.createKnowledge(knowledgeData, token);
    return handleResponse(res, (data) => Knowledge.fromMap(data));
  }

  // Lấy danh sách Knowledge
  Future<List<Knowledge>> getKnowledgeList(String token) async {
    final res = await remoteDataSource.getKnowledgeList(token);
    return handleResponse(res, (data) {
      return (data as List).map((item) => Knowledge.fromMap(item)).toList();
    });
  }

  // Lấy danh sách Knowledge Units
  Future<List<UnitModel>> getKnowledgeUnits(String id, String token) async {
    final res = await remoteDataSource.getKnowledgeUnits(id, token);
    return handleResponse(res, (data) {
      return (data as List).map((item) => UnitModel.fromMap(item)).toList();
    });
  }

  // Cập nhật Knowledge
  Future<Knowledge> updateKnowledge(
      String id, Map<String, dynamic> knowledgeData, String token) async {
    final res =
        await remoteDataSource.updateKnowledge(id, knowledgeData, token);
    return handleResponse(res, (data) => Knowledge.fromMap(data));
  }

  // Xóa Knowledge
  Future<void> deleteKnowledge(String id, String token) async {
    final res = await remoteDataSource.deleteKnowledge(id, token);
    handleResponse(res, (data) => null);
  }

  // Upload Local File Unit
  Future<void> uploadLocalFileUnit(
      String id, String filePath, String token) async {
    final res = await remoteDataSource.uploadLocalFileUnit(id, filePath, token);
    handleResponse(res, (data) => null);
  }

  // Upload Website Content Unit
  Future<void> uploadWebsiteContentUnit(
      String id, String unitName, String webUrl, String token) async {
    final res = await remoteDataSource.uploadWebsiteContentUnit(
        id, unitName, webUrl, token);
    handleResponse(res, (data) => null);
  }
}

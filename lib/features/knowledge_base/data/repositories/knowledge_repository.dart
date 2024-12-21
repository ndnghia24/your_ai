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
  Future<KnowledgeBase> createKnowledge(
      Map<String, dynamic> knowledgeData) async {
    final res = await remoteDataSource.createKnowledge(knowledgeData);
    return handleResponse(res, (data) => KnowledgeBase.fromMap(data));
  }

  // Lấy danh sách Knowledge
  Future<List<KnowledgeBase>> getKnowledgeList() async {
    final res = await remoteDataSource.getKnowledgeList();
    return handleResponse(res, (data) {
      return (data as List).map((item) => KnowledgeBase.fromMap(item)).toList();
    });
  }

  // Lấy danh sách Knowledge Units
  Future<List<UnitModel>> getKnowledgeUnits(String id) async {
    final res = await remoteDataSource.getKnowledgeUnits(id);
    return handleResponse(res, (data) {
      return (data as List).map((item) => UnitModel.fromMap(item)).toList();
    });
  }

  Future<void> deleteUnit(String knowledgeId, String id) async {
    final res = await remoteDataSource.deleteKnowledgeUnit(knowledgeId, id);
    handleResponse(res, (data) => null);
  }

  // Cập nhật Knowledge
  Future<KnowledgeBase> updateKnowledge(
      String id, Map<String, dynamic> knowledgeData) async {
    final res = await remoteDataSource.updateKnowledge(id, knowledgeData);
    return handleResponse(res, (data) => KnowledgeBase.fromMap(data));
  }

  // Xóa Knowledge
  Future<void> deleteKnowledge(String id) async {
    final res = await remoteDataSource.deleteKnowledge(id);
    handleResponse(res, (data) => null);
  }

  // Upload Local File Unit
  Future<void> uploadLocalFileUnit(String id, String filePath) async {
    final res = await remoteDataSource.uploadLocalFileUnit(id, filePath);
    handleResponse(res, (data) => null);
  }

  // Upload Website Content Unit
  Future<void> uploadWebsiteContentUnit(
      String id, String unitName, String webUrl) async {
    final res =
        await remoteDataSource.uploadWebsiteContentUnit(id, unitName, webUrl);
    handleResponse(res, (data) => null);
  }

  // Upload Slack Content Unit
  Future<void> uploadSlackContentUnit(String id, String unitName,
      String slackWorkspace, String slackBotToken) async {
    final res = await remoteDataSource.uploadSlackContentUnit(
        id, unitName, slackWorkspace, slackBotToken);
    handleResponse(res, (data) => null);
  }

  // Upload Confluence Content Unit
  Future<void> uploadConfluenceContentUnit(
    String id,
    String unitName,
    String wikiPageUrl,
    String confluenceUsername,
    String confluenceAccessToken,
  ) async {
    final res = await remoteDataSource.uploadConfluenceContentUnit(
        id, unitName, wikiPageUrl, confluenceUsername, confluenceAccessToken);
    handleResponse(res, (data) => null);
  }
}

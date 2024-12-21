import 'package:your_ai/core/templates/data_sources_result_template.dart';
import 'package:your_ai/features/knowledge_base/data/data_sources/services/knowledge_service.dart';
import 'package:your_ai/features/knowledge_base/data/data_sources/services/knowledge_unit_service.dart';

class KnowledgeRemoteDataSource {
  final KnowledgeService service;
  final KnowledgeUnitService unitService;

  KnowledgeRemoteDataSource(this.service, this.unitService);

  // Tạo Knowledge mới
  Future<DataSourcesResultTemplate> createKnowledge(
      Map<String, dynamic> knowledgeData) async {
    try {
      final response = await service.createKnowledge(knowledgeData);
      return DataSourcesResultTemplate(
        isSuccess: true,
        data: response.data,
        message: 'Create knowledge successfully',
      );
    } catch (e) {
      return DataSourcesResultTemplate(
        isSuccess: false,
        data: null,
        message: e.toString(),
      );
    }
  }

  // Lấy danh sách Knowledge
  Future<DataSourcesResultTemplate> getKnowledgeList() async {
    try {
      final response = await service.getKnowledgeList();
      final data = (response.data['data'] as List)
          .map((item) => item as Map<String, dynamic>)
          .toList();
      return DataSourcesResultTemplate(
        isSuccess: true,
        data: data,
        message: 'Fetch knowledge list successfully',
      );
    } catch (e) {
      return DataSourcesResultTemplate(
        isSuccess: false,
        data: null,
        message: e.toString(),
      );
    }
  }

  // Lấy danh sách Knowledge Units
  Future<DataSourcesResultTemplate> getKnowledgeUnits(String id) async {
    try {
      final response = await service.getKnowledgeUnits(id);
      final data = (response.data["data"] as List)
          .map((item) => item as Map<String, dynamic>)
          .toList();
      return DataSourcesResultTemplate(
        isSuccess: true,
        data: data,
        message: 'Fetch knowledge units successfully',
      );
    } catch (e) {
      return DataSourcesResultTemplate(
        isSuccess: false,
        data: null,
        message: e.toString(),
      );
    }
  }

  // Cập nhật Knowledge
  Future<DataSourcesResultTemplate> updateKnowledge(
      String id, Map<String, dynamic> knowledgeData) async {
    try {
      final response = await service.updateKnowledge(id, knowledgeData);
      return DataSourcesResultTemplate(
        isSuccess: true,
        data: response.data,
        message: 'Update knowledge successfully',
      );
    } catch (e) {
      return DataSourcesResultTemplate(
        isSuccess: false,
        data: null,
        message: e.toString(),
      );
    }
  }

  Future<DataSourcesResultTemplate> deleteKnowledgeUnit(
      String knowledgeId, String id) async {
    try {
      await service.deleteUnit(knowledgeId, id);

      return DataSourcesResultTemplate(
        isSuccess: true,
        data: null,
        message: 'Delete unit successfully',
      );
    } catch (e) {
      return DataSourcesResultTemplate(
        isSuccess: false,
        data: null,
        message: e.toString(),
      );
    }
  }

  // Xóa Knowledge
  Future<DataSourcesResultTemplate> deleteKnowledge(String id) async {
    try {
      await service.deleteKnowledge(id);
      return DataSourcesResultTemplate(
        isSuccess: true,
        data: null,
        message: 'Delete knowledge successfully',
      );
    } catch (e) {
      return DataSourcesResultTemplate(
        isSuccess: false,
        data: null,
        message: e.toString(),
      );
    }
  }

  // Upload Local File Unit
  Future<DataSourcesResultTemplate> uploadLocalFileUnit(
      String id, String filePath) async {
    try {
      final response = await unitService.uploadLocalFileUnit(
        id: id,
        filePath: filePath,
      );
      return DataSourcesResultTemplate(
        isSuccess: true,
        data: response.data,
        message: 'Upload local file unit successfully',
      );
    } catch (e) {
      return DataSourcesResultTemplate(
        isSuccess: false,
        data: null,
        message: e.toString(),
      );
    }
  }

  // Upload Website Content Unit
  Future<DataSourcesResultTemplate> uploadWebsiteContentUnit(
      String id, String unitName, String webUrl) async {
    try {
      final response = await unitService.uploadWebsiteContentUnit(
        id: id,
        unitName: unitName,
        webUrl: webUrl,
      );
      return DataSourcesResultTemplate(
        isSuccess: true,
        data: response.data,
        message: 'Upload website content unit successfully',
      );
    } catch (e) {
      return DataSourcesResultTemplate(
        isSuccess: false,
        data: null,
        message: e.toString(),
      );
    }
  }

  // Upload Slack Content Unit
  Future<DataSourcesResultTemplate> uploadSlackContentUnit(
    String id,
    String unitName,
    String slackWorkspace,
    String slackBotToken,
  ) async {
    try {
      final response = await unitService.uploadSlackContentUnit(
        id: id,
        unitName: unitName,
        slackWorkspace: slackWorkspace,
        slackBotToken: slackBotToken,
      );
      return DataSourcesResultTemplate(
        isSuccess: true,
        data: response.data,
        message: 'Upload Slack content unit successfully',
      );
    } catch (e) {
      return DataSourcesResultTemplate(
        isSuccess: false,
        data: null,
        message: e.toString(),
      );
    }
  }

  // Upload Confluence Content Unit
  Future<DataSourcesResultTemplate> uploadConfluenceContentUnit(
      String id,
      String unitName,
      String wikiPageUrl,
      String confluenceUsername,
      String confluenceAccessToken) async {
    try {
      final response = await unitService.uploadConfluenceContentUnit(
        id: id,
        unitName: unitName,
        wikiPageUrl: wikiPageUrl,
        confluenceUsername: confluenceUsername,
        confluenceAccessToken: confluenceAccessToken,
      );
      return DataSourcesResultTemplate(
        isSuccess: true,
        data: response.data,
        message: 'Upload Confluence content unit successfully',
      );
    } catch (e) {
      return DataSourcesResultTemplate(
        isSuccess: false,
        data: null,
        message: e.toString(),
      );
    }
  }
}

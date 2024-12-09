import 'package:your_ai/core/templates/data_sources_result_template.dart';
import 'package:your_ai/features/knowledge_base/data/data_sources/services/knowledge_service.dart';
import 'package:your_ai/features/knowledge_base/data/data_sources/services/knowledge_unit_service.dart';

class KnowledgeRemoteDataSource {
  final KnowledgeService service;
  final KnowledgeUnitService unitService;

  KnowledgeRemoteDataSource(this.service, this.unitService);

  // Tạo Knowledge mới
  Future<DataSourcesResultTemplate> createKnowledge(
      Map<String, dynamic> knowledgeData, String token) async {
    try {
      final response = await service.createKnowledge(knowledgeData, token);
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
  Future<DataSourcesResultTemplate> getKnowledgeList(String token) async {
    try {
      final response = await service.getKnowledgeList(token);
      final data = (response.data as List)
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
  Future<DataSourcesResultTemplate> getKnowledgeUnits(
      String id, String token) async {
    try {
      final response = await service.getKnowledgeUnits(id, token);
      final data = (response.data as List)
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
      String id, Map<String, dynamic> knowledgeData, String token) async {
    try {
      final response = await service.updateKnowledge(id, knowledgeData, token);
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

  // Xóa Knowledge
  Future<DataSourcesResultTemplate> deleteKnowledge(
      String id, String token) async {
    try {
      await service.deleteKnowledge(id, token);
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
      String id, String filePath, String token) async {
    try {
      final response = await unitService.uploadLocalFileUnit(
        id: id,
        filePath: filePath,
        token: token,
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
      String id, String unitName, String webUrl, String token) async {
    try {
      final response = await unitService.uploadWebsiteContentUnit(
        id: id,
        unitName: unitName,
        webUrl: webUrl,
        token: token,
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
}

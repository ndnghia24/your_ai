import 'package:your_ai/core/templates/data_sources_result_template.dart';
import 'package:your_ai/features/knowledged_bot/data/data_sources/services/assistant_knowledge_service.dart';

class AssistantKnowledgeRemoteDataSource {
  final AssistantKnowledgeService _assistantKnowledgeService;
  AssistantKnowledgeRemoteDataSource(this._assistantKnowledgeService);

  Future<DataSourcesResultTemplate> getAttachedKnowledges(
      String assistantId) async {
    try {
      final response =
          await _assistantKnowledgeService.getAttachedKnowledges(assistantId);

      if (response.statusCode == 200) {
        return DataSourcesResultTemplate(
          isSuccess: true,
          data: response.data,
          message: 'Attached knowledges fetched successfully',
        );
      } else {
        return DataSourcesResultTemplate(
          isSuccess: false,
          data: response.data,
          message: 'Error occurred during fetching attached knowledges',
        );
      }
    } catch (e) {
      return DataSourcesResultTemplate(
        isSuccess: false,
        data: e.toString(),
        message: 'Error occurred: ${e.toString()}',
      );
    }
  }

  Future<DataSourcesResultTemplate> attachKnowledge(
      String assistantId, String knowledgeId) async {
    try {
      final response = await _assistantKnowledgeService.attachKnowledge(
          assistantId, knowledgeId);

      if (response.statusCode == 200) {
        return DataSourcesResultTemplate(
          isSuccess: true,
          data: response.data,
          message: 'Knowledge attached successfully',
        );
      } else {
        return DataSourcesResultTemplate(
          isSuccess: false,
          data: response.data,
          message: 'Error occurred during attaching knowledge',
        );
      }
    } catch (e) {
      return DataSourcesResultTemplate(
        isSuccess: false,
        data: e.toString(),
        message: 'Error occurred: ${e.toString()}',
      );
    }
  }

  Future<DataSourcesResultTemplate> detachKnowledge(
      String assistantId, String knowledgeId) async {
    try {
      final response = await _assistantKnowledgeService.detachKnowledge(
          assistantId, knowledgeId);

      if (response.statusCode == 200) {
        return DataSourcesResultTemplate(
          isSuccess: true,
          data: response.data,
          message: 'Knowledge detached successfully',
        );
      } else {
        return DataSourcesResultTemplate(
          isSuccess: false,
          data: response.data,
          message: 'Error occurred during detaching knowledge',
        );
      }
    } catch (e) {
      return DataSourcesResultTemplate(
        isSuccess: false,
        data: e.toString(),
        message: 'Error occurred: ${e.toString()}',
      );
    }
  }
}

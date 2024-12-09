// Vị trí: lib/features/assistant/data/data_sources/assistant_remote_data_source.dart

import 'package:your_ai/core/templates/data_sources_result_template.dart';
import 'package:your_ai/features/knowledged_bot/data/data_sources/services/assistant_service.dart';

class AssistantRemoteDataSource {
  final AssistantService _assistantService;
  AssistantRemoteDataSource(this._assistantService);

  // Lấy danh sách Assistants
  Future<DataSourcesResultTemplate> getAssistants({
    bool? isFavorite,
    bool? isPublished,
    String? order,
    String? orderField,
    int offset = 0,
    int limit = 10,
  }) async {
    try {
      final response = await _assistantService.getAssistants(
        isFavorite: isFavorite,
        isPublished: isPublished,
        order: order,
        orderField: orderField,
        offset: offset,
        limit: limit,
      );

      if (response.statusCode == 200) {
        return DataSourcesResultTemplate(
          isSuccess: true,
          data: response.data,
          message: 'Assistants fetched successfully',
        );
      } else {
        return DataSourcesResultTemplate(
          isSuccess: false,
          data: response.data,
          message: 'Error occurred during fetching assistants',
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

  // Tạo Assistant mới
  Future<DataSourcesResultTemplate> createAssistant(
      Map<String, dynamic> assistantData) async {
    try {
      final response = await _assistantService.createAssistant(assistantData);

      if (response.statusCode == 200) {
        return DataSourcesResultTemplate(
          isSuccess: true,
          data: response.data,
          message: 'Assistant created successfully',
        );
      } else {
        return DataSourcesResultTemplate(
          isSuccess: false,
          data: response.data,
          message: 'Error occurred during creating assistant',
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

  // Cập nhật Assistant
  Future<DataSourcesResultTemplate> updateAssistant(
      String assistantId, Map<String, dynamic> assistantData) async {
    try {
      final response =
          await _assistantService.updateAssistant(assistantId, assistantData);

      if (response.statusCode == 200) {
        return DataSourcesResultTemplate(
          isSuccess: true,
          data: response.data,
          message: 'Assistant updated successfully',
        );
      } else {
        return DataSourcesResultTemplate(
          isSuccess: false,
          data: response.data,
          message: 'Error occurred during updating assistant',
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

  // Xóa Assistant
  Future<DataSourcesResultTemplate> deleteAssistant(String assistantId) async {
    try {
      final response = await _assistantService.deleteAssistant(assistantId);

      if (response.statusCode == 200) {
        return DataSourcesResultTemplate(
          isSuccess: true,
          data: response.data,
          message: 'Assistant deleted successfully',
        );
      } else {
        return DataSourcesResultTemplate(
          isSuccess: false,
          data: response.data,
          message: 'Error occurred during deleting assistant',
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

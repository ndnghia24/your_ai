// Vị trí: lib/features/assistant/data/repositories/assistant_repository.dart

import 'package:your_ai/core/templates/data_sources_result_template.dart';
import 'package:your_ai/features/knowledged_bot/data/data_sources/assistant_chat_data_source.dart';
import 'package:your_ai/features/knowledged_bot/data/data_sources/assistant_data_source.dart';
import 'package:your_ai/features/knowledged_bot/data/data_sources/assistant_knowledge_data_source.dart';

class AssistantRepository {
  final AssistantRemoteDataSource _assistantRemoteDataSource;
  final AssistantKnowledgeRemoteDataSource _assistantKnowledgeRemoteDataSource;
  final AssistantChatRemoteDataSource _assistantChatRemoteDataSource;

  AssistantRepository(
    this._assistantRemoteDataSource,
    this._assistantKnowledgeRemoteDataSource,
    this._assistantChatRemoteDataSource,
  );

  // Lấy danh sách Assistants
  Future<DataSourcesResultTemplate> getAssistants({
    bool? isFavorite,
    bool? isPublished,
    String? order,
    String? orderField,
    int offset = 0,
    int limit = 10,
  }) async {
    return await _assistantRemoteDataSource.getAssistants(
      isFavorite: isFavorite,
      isPublished: isPublished,
      order: order,
      orderField: orderField,
      offset: offset,
      limit: limit,
    );
  }

  // Tạo Assistant mới
  Future<DataSourcesResultTemplate> createAssistant(
      Map<String, dynamic> assistantData) async {
    return await _assistantRemoteDataSource.createAssistant(assistantData);
  }

  // Cập nhật Assistant
  Future<DataSourcesResultTemplate> updateAssistant(
      String assistantId, Map<String, dynamic> assistantData) async {
    return await _assistantRemoteDataSource.updateAssistant(
        assistantId, assistantData);
  }

  // Xóa Assistant
  Future<DataSourcesResultTemplate> deleteAssistant(String assistantId) async {
    return await _assistantRemoteDataSource.deleteAssistant(assistantId);
  }

  // Lấy danh sách Knowledge gắn với Assistant
  Future<DataSourcesResultTemplate> getAttachedKnowledges(
      {required String assistantId}) async {
    return await _assistantKnowledgeRemoteDataSource
        .getAttachedKnowledges(assistantId);
  }

  // Gắn Knowledge cho Assistant
  Future<DataSourcesResultTemplate> attachKnowledge(
      {required String assistantId, required String knowledgeId}) async {
    return await _assistantKnowledgeRemoteDataSource.attachKnowledge(
        assistantId, knowledgeId);
  }

  // Tách Knowledge khỏi Assistant
  Future<DataSourcesResultTemplate> detachKnowledge(
      {required String assistantId, required String knowledgeId}) async {
    return await _assistantKnowledgeRemoteDataSource.detachKnowledge(
        assistantId, knowledgeId);
  }

  // Lấy danh sách threads
  Future<DataSourcesResultTemplate> getThreads(String assistantId) async {
    return await _assistantChatRemoteDataSource.getThreads(assistantId);
  }

  // Lấy chi tiết threads
  Future<DataSourcesResultTemplate> getThreadDetails(String assistantId) async {
    return await _assistantChatRemoteDataSource.getThreadDetails(assistantId);
  }

  // Tiếp tục cuộc trò chuyện
  Future<DataSourcesResultTemplate> continueChat(
    String assistantId,
    String message,
    String openAiThreadId, {
    String additionalInstruction = '',
  }) async {
    return await _assistantChatRemoteDataSource.continueChat(
      assistantId,
      message,
      openAiThreadId,
      additionalInstruction: additionalInstruction,
    );
  }
}

import 'package:your_ai/core/templates/data_sources_result_template.dart';
import 'package:your_ai/features/knowledged_bot/data/data_sources/assistant_chat_data_source.dart';
import 'package:your_ai/features/knowledged_bot/data/data_sources/assistant_data_source.dart';
import 'package:your_ai/features/knowledged_bot/data/data_sources/assistant_knowledge_data_source.dart';
import 'package:your_ai/features/knowledged_bot/domain/entities/knowledge_model.dart';
import 'package:your_ai/features/knowledged_bot/domain/entities/thread_model.dart';

import '../../domain/entities/assistant_model.dart';

class AssistantRepository {
  final AssistantRemoteDataSource _assistantRemoteDataSource;
  final AssistantKnowledgeRemoteDataSource _assistantKnowledgeRemoteDataSource;
  final AssistantChatRemoteDataSource _assistantChatRemoteDataSource;

  late final AssistantsRepository assistants;
  late final AssistantKnowledgeRepository knowledge;
  late final AssistantBotChatRepository chat;

  AssistantRepository(
    this._assistantRemoteDataSource,
    this._assistantKnowledgeRemoteDataSource,
    this._assistantChatRemoteDataSource,
  ) {
    assistants = AssistantsRepository(_assistantRemoteDataSource);
    knowledge =
        AssistantKnowledgeRepository(_assistantKnowledgeRemoteDataSource);
    chat = AssistantBotChatRepository(_assistantChatRemoteDataSource);
  }
}

// Sub-repository for assistants
class AssistantsRepository {
  final AssistantRemoteDataSource _dataSource;

  AssistantsRepository(this._dataSource);

  Future<List<Assistant>> getAssistants({
    bool? isFavorite,
    bool? isPublished,
    String? order,
    String? orderField,
    int offset = 0,
    int limit = 10,
  }) async {
    /*return await _dataSource.getAssistants(
      isFavorite: isFavorite,
      isPublished: isPublished,
      order: order,
      orderField: orderField,
      offset: offset,
      limit: limit,
    );*/

    final res = await _dataSource.getAssistants(
      isFavorite: isFavorite,
      isPublished: isPublished,
      order: order,
      orderField: orderField,
      offset: offset,
      limit: limit,
    );

    if (res.isSuccess) {
      final assistantListData = res.data['data'] as List;

      final List<Assistant> assistantList = assistantListData
          .map((assistantData) => Assistant.fromMap(assistantData))
          .toList();

      return assistantList;
    } else {
      throw Exception(res.message);
    }
  }

  Future<Assistant> createAssistant(Map<String, dynamic> assistantData) async {
    /*return await _dataSource.createAssistant(assistantData);*/

    final res = await _dataSource.createAssistant(assistantData);

    if (res.isSuccess) {
      return Assistant.fromMap(res.data);
    } else {
      throw Exception(res.message);
    }
  }

  Future<Assistant> updateAssistant(
      String assistantId, Map<String, dynamic> assistantData) async {
    /*return await _dataSource.updateAssistant(assistantId, assistantData);*/

    final res = await _dataSource.updateAssistant(assistantId, assistantData);

    if (res.isSuccess) {
      return Assistant.fromMap(res.data);
    } else {
      throw Exception(res.message);
    }
  }

  Future<bool> deleteAssistant(String assistantId) async {
    /*return await _dataSource.deleteAssistant(assistantId);*/

    final res = await _dataSource.deleteAssistant(assistantId);

    if (res.isSuccess) {
      return true;
    } else {
      throw Exception(res.message);
    }
  }
}

// Sub-repository for knowledge
class AssistantKnowledgeRepository {
  final AssistantKnowledgeRemoteDataSource _dataSource;

  AssistantKnowledgeRepository(this._dataSource);

  Future<List<Knowledge>> getAttachedKnowledges({
    required String assistantId,
  }) async {
    final res = await _dataSource.getAttachedKnowledges(assistantId);

    if (res.isSuccess) {
      final knowledgeListData = res.data['data'] as List;

      final List<Knowledge> knowledgeList = knowledgeListData
          .map((knowledgeData) => Knowledge.fromMap(knowledgeData))
          .toList();

      return knowledgeList;
    } else {
      throw Exception(res.message);
    }
  }

  Future<String> attachKnowledge({
    required String assistantId,
    required String knowledgeId,
  }) async {
    final res = await _dataSource.attachKnowledge(assistantId, knowledgeId);

    if (!res.isSuccess) {
      throw Exception(res.message);
    }
    return res.data;
  }

  Future<String> detachKnowledge({
    required String assistantId,
    required String knowledgeId,
  }) async {
    final res = await _dataSource.detachKnowledge(assistantId, knowledgeId);

    if (!res.isSuccess) {
      throw Exception(res.message);
    }
    return res.data;
  }
}

// Sub-repository for chat
class AssistantBotChatRepository {
  final AssistantChatRemoteDataSource _dataSource;

  AssistantBotChatRepository(this._dataSource);

  Future<List<Thread>> getThreads(String assistantId) async {
    final res = await _dataSource.getThreads(assistantId);

    if (res.isSuccess) {
      final threadData = res.data['data'] as List;

      final List<Thread> threadList =
          threadData.map((threadData) => Thread.fromMap(threadData)).toList();

      return threadList;
    } else {
      throw Exception(res.message);
    }
  }

  Future<Thread> getThreadDetails(
      Thread currentThread, String openAiThreadId) async {
    /*return await _dataSource.getThreadDetails(assistantId);*/

    final res = await _dataSource.getThreadDetails(openAiThreadId);

    if (res.isSuccess) {
      final threadData = res.data as List;

      final Thread thread = Thread.fromDetailMap(
          currentThread, threadData.cast<Map<String, dynamic>>());

      return thread;
    } else {
      throw Exception(res.message);
    }
  }

  Future<Thread> createThread(String assistantId, String threadName) async {
    /*return await _dataSource.createThread(assistantId, threadName);*/

    final res = await _dataSource.createThread(assistantId, threadName);

    if (res.isSuccess) {
      return Thread.fromMap(res.data);
    } else {
      throw Exception(res.message);
    }
  }

  Future<String> continueChat(
    String assistantId,
    String message,
    String openAiThreadId, {
    String additionalInstruction = '',
  }) async {
    /*return await _dataSource.continueChat(
      assistantId,
      message,
      openAiThreadId,
      additionalInstruction: additionalInstruction,
    );*/

    final res = await _dataSource.continueChat(
      assistantId,
      message,
      openAiThreadId,
      additionalInstruction: additionalInstruction,
    );

    if (res.isSuccess) {
      return res.data;
    } else {
      throw Exception(res.message);
    }
  }
}

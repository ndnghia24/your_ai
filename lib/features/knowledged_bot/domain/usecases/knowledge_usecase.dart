import 'package:your_ai/core/templates/data_sources_result_template.dart';
import 'package:your_ai/core/templates/usecase_result_template.dart';
import 'package:your_ai/features/knowledged_bot/data/repositories/assistant_repository.dart';

import '../entities/knowledge_model.dart';

class GetAttachedKnowledgesUseCase {
  final AssistantRepository _repository;

  GetAttachedKnowledgesUseCase(this._repository);

  Future<UsecaseResultTemplate<List<Knowledge>>> execute({
    required String assistantId,
  }) async {
    try {
      final knowledgeList = await _repository.knowledge.getAttachedKnowledges(
        assistantId: assistantId,
      );

      return UsecaseResultTemplate<List<Knowledge>>(
        isSuccess: true,
        result: knowledgeList,
        message: 'Success',
      );
    } catch (e) {
      return UsecaseResultTemplate<List<Knowledge>>(
        isSuccess: false,
        result: [],
        message: e.toString(),
      );
    }
  }
}

class AttachKnowledgeUseCase {
  final AssistantRepository _repository;

  AttachKnowledgeUseCase(this._repository);

  Future<UsecaseResultTemplate<bool>> execute({
    required String assistantId,
    required String knowledgeId,
  }) async {
    /*return _repository.knowledge.attachKnowledge(
      assistantId: assistantId,
      knowledgeId: knowledgeId,
    );*/
    try {
      final res = await _repository.knowledge.attachKnowledge(
        assistantId: assistantId,
        knowledgeId: knowledgeId,
      );

      print('USE: $res');

      return UsecaseResultTemplate<bool>(
        isSuccess: true,
        result: res == "true",
        message: 'Success',
      );
    } catch (e) {
      return UsecaseResultTemplate<bool>(
        isSuccess: false,
        result: false,
        message: e.toString(),
      );
    }
  }
}

class DetachKnowledgeUseCase {
  final AssistantRepository _repository;

  DetachKnowledgeUseCase(this._repository);

  Future<UsecaseResultTemplate> execute({
    required String assistantId,
    required String knowledgeId,
  }) async {
    /*return _repository.knowledge.detachKnowledge(
      assistantId: assistantId,
      knowledgeId: knowledgeId,
    );*/

    try {
      final res = await _repository.knowledge.detachKnowledge(
        assistantId: assistantId,
        knowledgeId: knowledgeId,
      );

      return UsecaseResultTemplate<bool>(
        isSuccess: true,
        result: res == "true",
        message: 'Success',
      );
    } catch (e) {
      return UsecaseResultTemplate<bool>(
        isSuccess: false,
        result: false,
        message: e.toString(),
      );
    }
  }
}

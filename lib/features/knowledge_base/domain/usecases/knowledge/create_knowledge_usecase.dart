// Vị trí: lib/features/knowledge/domain/usecases/create_knowledge_usecase.dart

import 'package:your_ai/core/templates/usecase_result_template.dart';
import 'package:your_ai/features/knowledge_base/data/repositories/knowledge_repository.dart';
import 'package:your_ai/features/knowledge_base/domain/entities/knowledge_model.dart';

class CreateKnowledgeUseCase {
  final KnowledgeRepository repository;

  CreateKnowledgeUseCase(this.repository);

  Future<UsecaseResultTemplate<KnowledgeBase>> execute(
      Map<String, dynamic> knowledgeData, String token) async {
    try {
      final res = await repository.createKnowledge(knowledgeData, token);

      return UsecaseResultTemplate<KnowledgeBase>(
        isSuccess: true,
        result: res,
        message: 'Knowledge created successfully',
      );
    } catch (e) {
      return UsecaseResultTemplate<KnowledgeBase>(
        isSuccess: false,
        result: KnowledgeBase.initial(),
        message: 'Error creating knowledge: $e',
      );
    }
  }
}

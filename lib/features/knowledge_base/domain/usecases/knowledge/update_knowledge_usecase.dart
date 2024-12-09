// Vị trí: lib/features/knowledge/domain/usecases/update_knowledge_usecase.dart

import 'package:your_ai/core/templates/usecase_result_template.dart';
import 'package:your_ai/features/knowledge_base/data/repositories/knowledge_repository.dart';
import 'package:your_ai/features/knowledge_base/domain/entities/knowledge_model.dart';

class UpdateKnowledgeUseCase {
  final KnowledgeRepository repository;

  UpdateKnowledgeUseCase(this.repository);

  Future<UsecaseResultTemplate<Knowledge>> execute(
      String id, Map<String, dynamic> knowledgeData, String token) async {
    try {
      final res = await repository.updateKnowledge(id, knowledgeData, token);

      return UsecaseResultTemplate<Knowledge>(
        isSuccess: true,
        result: res,
        message: 'Knowledge updated successfully',
      );
    } catch (e) {
      return UsecaseResultTemplate<Knowledge>(
        isSuccess: false,
        result: Knowledge.initial(),
        message: 'Error updating knowledge: $e',
      );
    }
  }
}

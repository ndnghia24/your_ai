// Vị trí: lib/features/knowledge/domain/usecases/delete_knowledge_usecase.dart

import 'package:your_ai/core/templates/usecase_result_template.dart';
import 'package:your_ai/features/knowledge_base/data/repositories/knowledge_repository.dart';

class DeleteKnowledgeUnitUseCase {
  final KnowledgeRepository repository;

  DeleteKnowledgeUnitUseCase(this.repository);

  Future<UsecaseResultTemplate<void>> execute(String knowledgeId, String id, String token) async {
    try {
      await repository.deleteUnit(knowledgeId, id, token);

      return UsecaseResultTemplate<void>(
        isSuccess: true,
        result: null,
        message: 'Unit deleted successfully',
      );
    } catch (e) {
      return UsecaseResultTemplate<void>(
        isSuccess: false,
        result: null,
        message: 'Error deleting unit: $e',
      );
    }
  }
}

// Vị trí: lib/features/knowledge/domain/usecases/delete_knowledge_usecase.dart

import 'package:your_ai/core/templates/usecase_result_template.dart';
import 'package:your_ai/features/knowledge_base/data/repositories/knowledge_repository.dart';

class DeleteKnowledgeUseCase {
  final KnowledgeRepository repository;

  DeleteKnowledgeUseCase(this.repository);

  Future<UsecaseResultTemplate<void>> execute(String id) async {
    try {
      await repository.deleteKnowledge(id);

      return UsecaseResultTemplate<void>(
        isSuccess: true,
        result: null,
        message: 'Knowledge deleted successfully',
      );
    } catch (e) {
      return UsecaseResultTemplate<void>(
        isSuccess: false,
        result: null,
        message: 'Error deleting knowledge: $e',
      );
    }
  }
}

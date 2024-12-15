// Vị trí: lib/features/knowledge/domain/usecases/get_knowledge_list_usecase.dart

import 'package:your_ai/core/templates/usecase_result_template.dart';
import 'package:your_ai/features/knowledge_base/data/repositories/knowledge_repository.dart';
import 'package:your_ai/features/knowledge_base/domain/entities/knowledge_model.dart';

class GetKnowledgeListUseCase {
  final KnowledgeRepository repository;

  GetKnowledgeListUseCase(this.repository);

  Future<UsecaseResultTemplate<List<KnowledgeBase>>> execute(
      String token) async {
    try {
      final res = await repository.getKnowledgeList(token);

      return UsecaseResultTemplate<List<KnowledgeBase>>(
        isSuccess: true,
        result: res,
        message: 'Knowledge list fetched successfully',
      );
    } catch (e) {
      return UsecaseResultTemplate<List<KnowledgeBase>>(
        isSuccess: false,
        result: [],
        message: 'Error fetching knowledge list: $e',
      );
    }
  }
}

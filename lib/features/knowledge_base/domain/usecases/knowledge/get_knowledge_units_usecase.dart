// Vị trí: lib/features/knowledge/domain/usecases/get_knowledge_list_usecase.dart

import 'package:your_ai/core/templates/usecase_result_template.dart';
import 'package:your_ai/features/knowledge_base/data/repositories/knowledge_repository.dart';
import 'package:your_ai/features/knowledge_base/domain/entities/knowledge_model.dart';
import 'package:your_ai/features/knowledge_base/domain/entities/unit_model.dart';

class GetKnowledgeUnitsUseCase {
  final KnowledgeRepository repository;

  GetKnowledgeUnitsUseCase(this.repository);

  Future<UsecaseResultTemplate<List<UnitModel>>> execute(
      String id, String token) async {
    try {
      final res = await repository.getKnowledgeUnits(id, token);

      return UsecaseResultTemplate<List<UnitModel>>(
        isSuccess: true,
        result: res,
        message: 'Knowledge units fetched successfully',
      );
    } catch (e) {
      return UsecaseResultTemplate<List<UnitModel>>(
        isSuccess: false,
        result: [],
        message: 'Error fetching knowledge units: $e',
      );
    }
  }
}

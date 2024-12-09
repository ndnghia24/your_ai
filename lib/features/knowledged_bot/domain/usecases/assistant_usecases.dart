// Vị trí: lib/features/assistant/domain/usecases/assistant_usecases.dart

import 'package:your_ai/core/templates/data_sources_result_template.dart';
import 'package:your_ai/features/knowledged_bot/data/repositories/assistant_repository.dart';

class GetAssistantsUseCase {
  final AssistantRepository _repository;

  GetAssistantsUseCase(this._repository);

  Future<DataSourcesResultTemplate> execute({
    bool? isFavorite,
    bool? isPublished,
    String? order,
    String? orderField,
    int offset = 0,
    int limit = 10,
  }) {
    return _repository.getAssistants(
      isFavorite: isFavorite,
      isPublished: isPublished,
      order: order,
      orderField: orderField,
      offset: offset,
      limit: limit,
    );
  }
}

class CreateAssistantUseCase {
  final AssistantRepository _repository;

  CreateAssistantUseCase(this._repository);

  Future<DataSourcesResultTemplate> execute(
      Map<String, dynamic> assistantData) {
    return _repository.createAssistant(assistantData);
  }
}

class UpdateAssistantUseCase {
  final AssistantRepository _repository;

  UpdateAssistantUseCase(this._repository);

  Future<DataSourcesResultTemplate> execute(
      String assistantId, Map<String, dynamic> assistantData) {
    return _repository.updateAssistant(assistantId, assistantData);
  }
}

class DeleteAssistantUseCase {
  final AssistantRepository _repository;

  DeleteAssistantUseCase(this._repository);

  Future<DataSourcesResultTemplate> execute(String assistantId) {
    return _repository.deleteAssistant(assistantId);
  }
}

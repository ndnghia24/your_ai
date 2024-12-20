import 'package:your_ai/core/templates/data_sources_result_template.dart';
import 'package:your_ai/core/templates/usecase_result_template.dart';
import 'package:your_ai/features/knowledged_bot/data/repositories/assistant_repository.dart';
import 'package:your_ai/features/knowledged_bot/domain/entities/assistant_model.dart';

class GetAssistantsUseCase {
  final AssistantRepository _repository;

  GetAssistantsUseCase(this._repository);

  Future<UsecaseResultTemplate<List<Assistant>>> execute({
    bool? isFavorite,
    bool? isPublished,
    String? order,
    String? orderField,
    int offset = 0,
    int limit = 10,
  }) async {
    /*return _repository.assistants.getAssistants(
      isFavorite: isFavorite,
      isPublished: isPublished,
      order: order,
      orderField: orderField,
      offset: offset,
      limit: limit,
    );*/

    try {
      final assistants = await _repository.assistants.getAssistants(
        isFavorite: isFavorite,
        isPublished: isPublished,
        order: order,
        orderField: orderField,
        offset: offset,
        limit: limit,
      );

      print('USECASE: ${assistants.length}');

      return UsecaseResultTemplate<List<Assistant>>(
        isSuccess: true,
        result: assistants,
        message: 'Success',
      );
    } catch (e) {
      return UsecaseResultTemplate<List<Assistant>>(
        isSuccess: false,
        result: [],
        message: e.toString(),
      );
    }
  }
}

class CreateAssistantUseCase {
  final AssistantRepository _repository;

  CreateAssistantUseCase(this._repository);

  Future<UsecaseResultTemplate<Assistant>> execute({
    required String assistantName,
    required String description,
  }) async {
    /*return _repository.assistants.createAssistant(assistantData);*/

    try {
      final assistantData = {
        'assistantName': assistantName,
        'description': description,
      };

      final newAssistant =
          await _repository.assistants.createAssistant(assistantData);

      return UsecaseResultTemplate<Assistant>(
        isSuccess: true,
        result: newAssistant,
        message: 'Success',
      );
    } catch (e) {
      print("ERROR: $e");

      return UsecaseResultTemplate<Assistant>(
        isSuccess: false,
        result: Assistant.initial(),
        message: e.toString(),
      );
    }
  }
}

class UpdateAssistantUseCase {
  final AssistantRepository _repository;

  UpdateAssistantUseCase(this._repository);

  Future<UsecaseResultTemplate<Assistant>> execute({
    required String assistantId,
    required String assistantName,
    required String description,
  }) async {
    /*return _repository.assistants.updateAssistant(assistantId, assistantData);*/

    try {
      final assistantData = {
        'assistantName': assistantName,
        'description': description,
      };

      final result = await _repository.assistants.updateAssistant(
        assistantId,
        assistantData,
      );

      return UsecaseResultTemplate<Assistant>(
        isSuccess: true,
        result: result,
        message: 'Success',
      );
    } catch (e) {
      return UsecaseResultTemplate<Assistant>(
        isSuccess: false,
        result: Assistant.initial(),
        message: e.toString(),
      );
    }
  }
}

class DeleteAssistantUseCase {
  final AssistantRepository _repository;

  DeleteAssistantUseCase(this._repository);

  Future<UsecaseResultTemplate<bool>> execute({
    required String assistantId,
  }) async {
    /*return _repository.assistants.deleteAssistant(assistantId);*/

    try {
      final result = await _repository.assistants.deleteAssistant(assistantId);

      return UsecaseResultTemplate<bool>(
        isSuccess: true,
        result: result,
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

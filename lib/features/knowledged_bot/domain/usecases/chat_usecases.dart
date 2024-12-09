// Vị trí: lib/features/assistant/domain/usecases/chat_usecases.dart

import 'package:your_ai/core/templates/data_sources_result_template.dart';
import 'package:your_ai/features/knowledged_bot/data/repositories/assistant_repository.dart';

class GetThreadsUseCase {
  final AssistantRepository _repository;

  GetThreadsUseCase(this._repository);

  Future<DataSourcesResultTemplate> execute(String assistantId) {
    return _repository.getThreads(assistantId);
  }
}

class GetThreadDetailsUseCase {
  final AssistantRepository _repository;

  GetThreadDetailsUseCase(this._repository);

  Future<DataSourcesResultTemplate> execute(String openAiThreadId) {
    return _repository.getThreadDetails(openAiThreadId);
  }
}

class ContinueChatUseCase {
  final AssistantRepository _repository;

  ContinueChatUseCase(this._repository);

  Future<DataSourcesResultTemplate> execute(
      String assistantId, String message, String openAiThreadId,
      {String additionalInstruction = ''}) {
    return _repository.continueChat(
      assistantId,
      message,
      openAiThreadId,
      additionalInstruction: additionalInstruction,
    );
  }
}

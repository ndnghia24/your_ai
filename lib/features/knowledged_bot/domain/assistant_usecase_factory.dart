// Vị trí: lib/features/assistant/domain/usecases/usecase_factory.dart

import 'package:your_ai/features/knowledged_bot/data/repositories/assistant_repository.dart';
import 'package:your_ai/features/knowledged_bot/domain/usecases/assistant_usecases.dart';
import 'package:your_ai/features/knowledged_bot/domain/usecases/chat_usecases.dart';

class UseCaseFactory {
  final AssistantRepository _repository;

  UseCaseFactory(this._repository);

  // Assistant Use Cases
  GetAssistantsUseCase getAssistantsUseCase() {
    return GetAssistantsUseCase(_repository);
  }

  CreateAssistantUseCase createAssistantUseCase() {
    return CreateAssistantUseCase(_repository);
  }

  UpdateAssistantUseCase updateAssistantUseCase() {
    return UpdateAssistantUseCase(_repository);
  }

  DeleteAssistantUseCase deleteAssistantUseCase() {
    return DeleteAssistantUseCase(_repository);
  }

  // Chat Use Cases
  GetThreadsUseCase getThreadsUseCase() {
    return GetThreadsUseCase(_repository);
  }

  GetThreadDetailsUseCase getThreadDetailsUseCase() {
    return GetThreadDetailsUseCase(_repository);
  }

  ContinueChatUseCase continueChatUseCase() {
    return ContinueChatUseCase(_repository);
  }
}

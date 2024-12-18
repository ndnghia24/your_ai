import 'package:your_ai/features/knowledged_bot/data/repositories/assistant_repository.dart';
import 'package:your_ai/features/knowledged_bot/domain/usecases/assistant_usecases.dart';
import 'package:your_ai/features/knowledged_bot/domain/usecases/chat_usecases.dart';
import 'package:your_ai/features/knowledged_bot/domain/usecases/knowledge_usecase.dart';

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

  // Knowledge Use Cases
  GetAttachedKnowledgesUseCase getAttachedKnowledgesUseCase() {
    return GetAttachedKnowledgesUseCase(_repository);
  }

  AttachKnowledgeUseCase attachKnowledgeUseCase() {
    return AttachKnowledgeUseCase(_repository);
  }

  DetachKnowledgeUseCase detachKnowledgeUseCase() {
    return DetachKnowledgeUseCase(_repository);
  }
}

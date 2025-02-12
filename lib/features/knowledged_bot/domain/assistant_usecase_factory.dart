import 'package:your_ai/features/knowledged_bot/data/repositories/assistant_repository.dart';
import 'package:your_ai/features/knowledged_bot/domain/usecases/assistant_usecases.dart';
import 'package:your_ai/features/knowledged_bot/domain/usecases/chat_usecases.dart';
import 'package:your_ai/features/knowledged_bot/domain/usecases/integration_usecase.dart';
import 'package:your_ai/features/knowledged_bot/domain/usecases/knowledge_usecase.dart';

class AssistantUseCaseFactory {
  final AssistantRepository _repository;

  AssistantUseCaseFactory(this._repository);

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

  // Chat Use Cases
  GetThreadsUseCase getThreadsUseCase() {
    return GetThreadsUseCase(_repository);
  }

  GetThreadDetailsUseCase getThreadDetailsUseCase() {
    return GetThreadDetailsUseCase(_repository);
  }

  CreateThreadUseCase createThreadUseCase() {
    return CreateThreadUseCase(_repository);
  }

  ContinueChatUseCase continueChatUseCase() {
    return ContinueChatUseCase(_repository);
  }

  // Integration Use Cases
  GetIntegrationConfigurationsUseCase getIntegrationConfigurationsUseCase() {
    return GetIntegrationConfigurationsUseCase(_repository);
  }

  DisconnectIntegrationUseCase disconnectIntegrationUseCase() {
    return DisconnectIntegrationUseCase(_repository);
  }

  VerifyTelegramConfigUseCase verifyTelegramConfigUseCase() {
    return VerifyTelegramConfigUseCase(_repository);
  }

  PublishTelegramBotUseCase publishTelegramBotUseCase() {
    return PublishTelegramBotUseCase(_repository);
  }

  VerifySlackConfigUseCase verifySlackConfigUseCase() {
    return VerifySlackConfigUseCase(_repository);
  }

  PublishSlackBotUseCase publishSlackBotUseCase() {
    return PublishSlackBotUseCase(_repository);
  }

  VerifyMessengerConfigUseCase verifyMessengerConfigUseCase() {
    return VerifyMessengerConfigUseCase(_repository);
  }

  PublishMessengerBotUseCase publishMessengerBotUseCase() {
    return PublishMessengerBotUseCase(_repository);
  }
}

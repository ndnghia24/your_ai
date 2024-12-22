import 'package:equatable/equatable.dart';
import 'package:your_ai/features/chat_prompt/domain/entities/prompt.dart';
import 'package:your_ai/features/knowledged_bot/domain/entities/assistant_model.dart';

abstract class AssistantEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetAllAssistantEvent extends AssistantEvent {

  GetAllAssistantEvent();
}

class CreateAssistantEvent extends AssistantEvent {
  final String assistantName;
  final String description;

  final List<Assistant> assistants;

  CreateAssistantEvent(
    this.assistantName,
    this.description,
    this.assistants,
  );
}


class UpdateAssistantEvent extends AssistantEvent {
  final String assistantId;
  final String assistantName;
  final String description;
  final List<Assistant> assistants;

  UpdateAssistantEvent(
    this.assistantId,
    this.assistantName,
    this.description,
    this.assistants
  );
}

class DeleteAssistantEvent extends AssistantEvent {
  final String assistantId;
  final List<Assistant> assistants;

  DeleteAssistantEvent(
      this.assistantId,
    this.assistants
  );
}


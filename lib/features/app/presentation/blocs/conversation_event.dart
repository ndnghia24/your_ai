import 'package:equatable/equatable.dart';
import 'package:your_ai/features/chat_ai/domain/entities/conversation.dart';

abstract class ConversationEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadConversation extends ConversationEvent {
  final String conversationId;

  LoadConversation(this.conversationId);

  @override
  List<Object?> get props => [conversationId];
}

class UpdateConversation extends ConversationEvent {
  final Conversation conversation;

  UpdateConversation(this.conversation);

  @override
  List<Object?> get props => [conversation];
}

class CreateNewConversation extends ConversationEvent {
  final String content;
  final String assistantId;
  final String assistantModel;

  CreateNewConversation({
    required this.content,
    required this.assistantId,
    required this.assistantModel,
  });

  @override
  List<Object?> get props => [content, assistantId, assistantModel];
}

class ContinueConversation extends ConversationEvent {
  final String content;
  final Map<String, dynamic> assistant;
  final Map<String, dynamic> conversation;

  ContinueConversation({
    required this.content,
    required this.assistant,
    required this.conversation,
  });

  @override
  List<Object?> get props => [content, assistant, conversation];
}
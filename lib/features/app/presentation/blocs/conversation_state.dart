import 'package:equatable/equatable.dart';
import 'package:your_ai/features/chat_ai/domain/entities/conversation.dart';

abstract class ConversationState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ConversationInitial extends ConversationState {}

class ConversationLoading extends ConversationState {}

class ConversationLoaded extends ConversationState {
  final Conversation conversation;

  ConversationLoaded(this.conversation);

  @override
  List<Object?> get props => [conversation];
}

class ConversationError extends ConversationState {
  final String message;

  ConversationError(this.message);

  @override
  List<Object?> get props => [message];
}
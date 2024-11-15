import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_ai/features/chat_ai/domain/chat_usecase_factory.dart';
import 'package:your_ai/features/chat_ai/domain/entities/conversation.dart';
import 'conversation_event.dart';
import 'conversation_state.dart';

class ConversationBloc extends Bloc<ConversationEvent, ConversationState> {
  final ChatAIUseCaseFactory chatAIUseCaseFactory;
  Conversation currentConversation = Conversation(id: '', messages: []);

  ConversationBloc(this.chatAIUseCaseFactory) : super(ConversationInitial()) {
    on<LoadConversation>(_onLoadConversation);
    on<UpdateConversation>(_onUpdateConversation);
    on<CreateNewConversation>(_onCreateNewConversation);
    on<ContinueConversation>(_onContinueConversation);
  }

  Future<void> _onLoadConversation(LoadConversation event, Emitter<ConversationState> emit) async {
    if (currentConversation.id == event.conversationId) {
      return; // Avoid reloading the same conversation
    }

    emit(ConversationLoading());
    try {
      final result = await chatAIUseCaseFactory.getConversationDetailUseCase.execute(
        conversationId: event.conversationId,
        params: {},
      );
      if (result.isSuccess) {
        emit(ConversationLoaded(result.result));
      } else {
        emit(ConversationError(result.message));
      }
    } catch (e) {
      emit(ConversationError(e.toString()));
    }
  }

  void _onUpdateConversation(UpdateConversation event, Emitter<ConversationState> emit) {
    currentConversation = event.conversation;
    emit(ConversationLoaded(event.conversation));
  }

  Future<void> _onCreateNewConversation(CreateNewConversation event, Emitter<ConversationState> emit) async {
    emit(ConversationLoading());
    try {
      final result = await chatAIUseCaseFactory.createNewConversationUseCase.execute(
        content: event.content,
        assistantId: event.assistantId,
        assistantModel: event.assistantModel,
      );
      if (result.isSuccess) {
        currentConversation = result.result;
        emit(ConversationLoaded(result.result));
      } else {
        emit(ConversationError(result.message));
      }
    } catch (e) {
      emit(ConversationError(e.toString()));
    }
  }

  Future<void> _onContinueConversation(ContinueConversation event, Emitter<ConversationState> emit) async {
    try {
      final result = await chatAIUseCaseFactory.continueConversationUseCase.execute(
        content: event.content,
        assistant: event.assistant,
        conversation: event.conversation,
      );
      if (result.isSuccess) {
        currentConversation = result.result;
        emit(ConversationLoaded(result.result));
      } else {
        emit(ConversationError(result.message));
      }
    } catch (e) {
      emit(ConversationError(e.toString()));
    }
  }
}
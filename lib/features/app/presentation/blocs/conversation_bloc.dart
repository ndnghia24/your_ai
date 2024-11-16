import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_ai/features/chat_ai/domain/chat_usecase_factory.dart';
import 'package:your_ai/features/chat_ai/domain/entities/conversation.dart';
import 'package:your_ai/features/chat_ai/domain/entities/message.dart';
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

  Future<void> _onLoadConversation(
      LoadConversation event, Emitter<ConversationState> emit) async {
    if (currentConversation.id == event.conversationId) return;

    emit(ConversationLoading(conversation: currentConversation));
    try {
      final result =
          await chatAIUseCaseFactory.getConversationDetailUseCase.execute(
        conversationId: event.conversationId,
        params: {
          'assistantId': 'gpt-4o-mini',
          'assistantModel': 'dify',
        },
      );
      result.isSuccess
          ? emit(ConversationLoaded(result.result))
          : emit(ConversationError(result.message));
    } catch (e) {
      emit(ConversationError(e.toString()));
    }
  }

  void _onUpdateConversation(
      UpdateConversation event, Emitter<ConversationState> emit) {
    currentConversation = event.conversation;
    emit(ConversationLoaded(event.conversation));
  }

  Future<void> _onCreateNewConversation(
      CreateNewConversation event, Emitter<ConversationState> emit) async {
    emit(ConversationLoading(
        conversation: currentConversation, message: event.content));
    try {
      final result =
          await chatAIUseCaseFactory.createNewConversationUseCase.execute(
        content: event.content,
        assistantId: event.assistantId,
        assistantModel: event.assistantModel,
      );
      if (result.isSuccess) {
        currentConversation = result.result;
        emit(ConversationLoaded(result.result));
      } else {
        _addErrorMessage(event);
        emit(ConversationLoaded(currentConversation));
      }
    } catch (e) {
      _addErrorMessage(event);
      emit(ConversationLoaded(currentConversation));
    }
  }

  Future<void> _onContinueConversation(
      ContinueConversation event, Emitter<ConversationState> emit) async {
    emit(ConversationLoading(
        conversation: currentConversation, message: event.content));
    try {
      final result =
          await chatAIUseCaseFactory.continueConversationUseCase.execute(
        content: event.content,
        assistant: event.assistant,
        conversation: event.conversation,
      );
      if (result.isSuccess) {
        currentConversation = result.result;
        emit(ConversationLoaded(result.result));
      } else {
        _addErrorMessage(event);
        emit(ConversationLoaded(currentConversation));
      }
    } catch (e) {
      _addErrorMessage(event);
      emit(ConversationLoaded(currentConversation));
    }
  }

  void _addErrorMessage(dynamic event) {
    currentConversation.messages.add(Message(
      content: event.content,
      isFromUser: true,
      assistantId: event is CreateNewConversation
          ? event.assistantId
          : event.assistant['id'],
      assistantModel: event is CreateNewConversation
          ? event.assistantModel
          : event.assistant['model'],
    ));
    currentConversation.messages.add(Message(
      content:
          "Sorry, We are unable to process your request at the moment. Please login or check your internet connection and try again.",
      isFromUser: false,
      assistantId: event is CreateNewConversation
          ? event.assistantId
          : event.assistant['id'],
      assistantModel: event is CreateNewConversation
          ? event.assistantModel
          : event.assistant['model'],
    ));
  }
}

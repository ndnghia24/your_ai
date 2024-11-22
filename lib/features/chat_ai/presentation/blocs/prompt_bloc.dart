import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:your_ai/features/chat_prompt/domain/entities/prompt.dart';
import 'package:your_ai/features/chat_prompt/domain/prompt_usecase_factory.dart';
import 'prompt_event.dart';
import 'prompt_state.dart';

class ChatPromptBloc extends Bloc<ChatPromptEvent, ChatPromptState> {
  final ChatPromptUseCaseFactory promptUseCaseFactory;

  ChatPromptBloc(this.promptUseCaseFactory) : super(ChatPromptInitial()) {
    on<GetAllPromptEvent>(_onGetAllPromptEvent);
    on<GetPrivatePromptEvent>(_onGetPrivatePromptEvent);
    on<GetPublicPromptEvent>(_onGetPublicPromptEvent);

  }

  FutureOr<void> _onGetAllPromptEvent(GetAllPromptEvent event, Emitter<ChatPromptState> emit) async{
    emit(ChatPromptLoading(privatePrompts: [], publicPrompts: []));
    try {
      final privateResult = await promptUseCaseFactory.getPrivatePromptsUsecase.execute();
      final publicResult = await promptUseCaseFactory.getPublicPromptsUsecase.execute();

      if (privateResult.isSuccess && publicResult.isSuccess) {
        emit(ChatPromptLoaded(privateResult.result, publicResult.result));
      } else {
        String errorMessage = privateResult.message + publicResult.message;
        emit(ChatPromptError(errorMessage));
      }
    } catch (e) {
      emit(ChatPromptError(e.toString()));
    }
  }

  Future<void> _onGetPrivatePromptEvent(
      GetPrivatePromptEvent event, Emitter<ChatPromptState> emit) async {
    emit(ChatPromptLoading(privatePrompts: [], publicPrompts: []));
    try {
      final usecaseResult =
          await promptUseCaseFactory.getPrivatePromptsUsecase.execute();

      if (usecaseResult.isSuccess) {
        emit(ChatPromptLoaded(usecaseResult.result, event.publicPrompts));
      } else {
        emit(ChatPromptError(usecaseResult.message));
      }
    } catch (e) {
      emit(ChatPromptError(e.toString()));
    }
  }

  Future<void> _onGetPublicPromptEvent(
      GetPublicPromptEvent event, Emitter<ChatPromptState> emit) async {
    emit(ChatPromptLoading(privatePrompts: [], publicPrompts: []));
    try {
      final useCaseResult =
          await promptUseCaseFactory.getPublicPromptsUsecase.execute();

      if (useCaseResult.isSuccess) {
        emit(ChatPromptLoaded(event.privatePrompts, useCaseResult.result));
      } else {
        emit(ChatPromptError(useCaseResult.message));
      }
    } catch (e) {
      emit(ChatPromptError(e.toString()));
    }
  }

  
  
}

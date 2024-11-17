import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:your_ai/features/chat_prompt/domain/prompt_usecase_factory.dart';
import '../../domain/entities/prompt.dart';
import 'prompt_event.dart';
import 'prompt_state.dart';

class PromptBloc extends Bloc<PromptEvent, PromptState> {
  final ChatPromptUseCaseFactory promptUseCaseFactory;

  PromptBloc(this.promptUseCaseFactory) : super(PromptInitial()) {
    on<GetAllPromptEvent>(_onGetAllPromptEvent);
    on<GetPrivatePromptEvent>(_onGetPrivatePromptEvent);
    on<GetPublicPromptEvent>(_onGetPublicPromptEvent);
    on<AddNewPublicPromptEvent>(_onAddNewPublicPromptEvent);
    on<AddNewPrivatePromptEvent>(_onAddNewPrivatePromptEvent);
    on<UpdatePrivatePromptEvent>(_onUpdatePrivatePromptEvent);
    on<DeletePrivatePromptEvent>(_onDeletePrivatePromptEvent);
    on<AddFavoritePromptEvent>(_onAddFavoritePromptEvent);
    on<RemoveFavoritePromptEvent>(_onRemoveFavoritePromptEvent);
  }

  FutureOr<void> _onGetAllPromptEvent(GetAllPromptEvent event, Emitter<PromptState> emit) async{
    emit(PromptLoading(privatePrompts: [], publicPrompts: []));
    try {
      final privateResult = await promptUseCaseFactory.getPrivatePromptsUsecase.execute();
      final publicResult = await promptUseCaseFactory.getPublicPromptsUsecase.execute();

      if (privateResult.isSuccess && publicResult.isSuccess) {
        emit(PromptLoaded(privateResult.result, publicResult.result));
      } else {
        String errorMessage = privateResult.message + publicResult.message;
        emit(PromptError(errorMessage));
      }
    } catch (e) {
      emit(PromptError(e.toString()));
    }
  }

  Future<void> _onGetPrivatePromptEvent(
      GetPrivatePromptEvent event, Emitter<PromptState> emit) async {
    emit(PromptLoading(privatePrompts: [], publicPrompts: []));
    try {
      final usecaseResult =
          await promptUseCaseFactory.getPrivatePromptsUsecase.execute();

      if (usecaseResult.isSuccess) {
        emit(PromptLoaded(usecaseResult.result, event.publicPrompts));
      } else {
        emit(PromptError(usecaseResult.message));
      }
    } catch (e) {
      emit(PromptError(e.toString()));
    }
  }

  Future<void> _onGetPublicPromptEvent(
      GetPublicPromptEvent event, Emitter<PromptState> emit) async {
    emit(PromptLoading(privatePrompts: [], publicPrompts: []));
    try {
      final useCaseResult =
          await promptUseCaseFactory.getPublicPromptsUsecase.execute();

      if (useCaseResult.isSuccess) {
        emit(PromptLoaded(event.privatePrompts, useCaseResult.result));
      } else {
        emit(PromptError(useCaseResult.message));
      }
    } catch (e) {
      emit(PromptError(e.toString()));
    }
  }

  Future<void> _onAddNewPublicPromptEvent(
      AddNewPublicPromptEvent event, Emitter<PromptState> emit) async {
    emit(PromptLoading(privatePrompts: [], publicPrompts: []));
    try {
      final useCaseResult =
          await promptUseCaseFactory.createPublicPromptUsecase.execute(
        title: event.title,
        description: event.description,
        content: event.content,
        category: event.category,
        language: event.language,
      );

      if (useCaseResult.isSuccess) {
        final publicPrompts = event.publicPrompts;
        publicPrompts.add(useCaseResult.result);
        final privatePrompts = event.privatePrompts;
        privatePrompts.add(useCaseResult.result);
        emit(PromptLoaded(privatePrompts, publicPrompts));
      } else {
        emit(PromptError(useCaseResult.message));
      }
    } catch (e) {
      emit(PromptError(e.toString()));
    }
  }

  Future<void> _onAddNewPrivatePromptEvent(
      AddNewPrivatePromptEvent event, Emitter<PromptState> emit) async {
    emit(PromptLoading(privatePrompts: [], publicPrompts: []));
    try {
      final useCaseResult =
          await promptUseCaseFactory.createPrivatePromptUsecase.execute(
        title: event.title,
        description: event.description,
        content: event.content,
      );

      if (useCaseResult.isSuccess) {
        final privatePrompts = event.privatePrompts;
        privatePrompts.add(useCaseResult.result);
        emit(PromptLoaded(privatePrompts, event.publicPrompts));
      } else {
        emit(PromptError(useCaseResult.message));
      }
    } catch (e) {
      emit(PromptError(e.toString()));
    }
  }

  Future<void> _onUpdatePrivatePromptEvent(
      UpdatePrivatePromptEvent event, Emitter<PromptState> emit) async {
    emit(PromptLoading(privatePrompts: [], publicPrompts: []));
    try {
      final useCaseResult =
          await promptUseCaseFactory.updatePrivatePromptUsecase.execute(
        promptId: event.promptId,
        title: event?.title,
        description: event.description,
        content: event?.content,
        category: event.category,
        language: event.language,
        isPublic: event.isPublic,
      );

      if (useCaseResult.isSuccess) {
        final privatePrompts = event.privatePrompts;
        final index = privatePrompts
            .indexWhere((element) => element.id == event.promptId);
        privatePrompts[index] = useCaseResult.result;

        final publicPrompts = event.publicPrompts;
        final indexPublic =
            publicPrompts.indexWhere((element) => element.id == event.promptId);
        publicPrompts[indexPublic] = useCaseResult.result;

        emit(PromptLoaded(privatePrompts, publicPrompts));
      } else {
        emit(PromptError(useCaseResult.message));
      }
    } catch (e) {
      emit(PromptError(e.toString()));
    }
  }

  Future<void> _onDeletePrivatePromptEvent(
      DeletePrivatePromptEvent event, Emitter<PromptState> emit) async {
    emit(PromptLoading(privatePrompts: [], publicPrompts: []));
    try {
      final useCaseResult = await promptUseCaseFactory
          .deletePrivatePromptUsecase
          .execute(promptId: event.promptId);

      if (useCaseResult.isSuccess) {
        final privatePrompts = event.privatePrompts;
        privatePrompts.removeWhere((element) => element.id == event.promptId);
        final publicPrompts = event.publicPrompts;
        publicPrompts.removeWhere((element) => element.id == event.promptId);
        emit(PromptLoaded(privatePrompts, publicPrompts));
      } else {
        emit(PromptError(useCaseResult.message));
      }
    } catch (e) {
      emit(PromptError(e.toString()));
    }
  }

  Future<void> _onAddFavoritePromptEvent(
      AddFavoritePromptEvent event, Emitter<PromptState> emit) async {
    emit(PromptLoading(privatePrompts: [], publicPrompts: []));
    try {
      final useCaseResult = await promptUseCaseFactory.addFavouritePromptUsecase
          .execute(promptId: event.promptId);

      if (useCaseResult.isSuccess) {
        final publicPrompts = event.publicPrompts;
        final index =
            publicPrompts.indexWhere((element) => element.id == event.promptId);
        Prompt updatePrompt = new Prompt(
          id: publicPrompts[index].id,
          title: publicPrompts[index].title,
          description: publicPrompts[index].description,
          content: publicPrompts[index].content,
          category: publicPrompts[index].category,
          isFavorite: true,
          isPublic: publicPrompts[index].isPublic,
          userName: publicPrompts[index].userName,
          language: publicPrompts[index].language,
        );
        publicPrompts[index] = updatePrompt;
        emit(PromptLoaded(event.privatePrompts, publicPrompts));
      } else {
        emit(PromptError(useCaseResult.message));
      }
    } catch (e) {
      emit(PromptError(e.toString()));
    }
  }

  Future<void> _onRemoveFavoritePromptEvent(
      RemoveFavoritePromptEvent event, Emitter<PromptState> emit) async {
    emit(PromptLoading(privatePrompts: [], publicPrompts: []));
    try {
      final useCaseResult = await promptUseCaseFactory
          .removeFavouritePromptUsecase
          .execute(promptId: event.promptId);

      if (useCaseResult.isSuccess) {
        final publicPrompts = event.publicPrompts;
        final index =
            publicPrompts.indexWhere((element) => element.id == event.promptId);
        Prompt updatePrompt = new Prompt(
          id: publicPrompts[index].id,
          title: publicPrompts[index].title,
          description: publicPrompts[index].description,
          content: publicPrompts[index].content,
          category: publicPrompts[index].category,
          isFavorite: false,
          isPublic: publicPrompts[index].isPublic,
          userName: publicPrompts[index].userName,
        );
        publicPrompts[index] = updatePrompt;
        emit(PromptLoaded(event.privatePrompts, publicPrompts));
      } else {
        emit(PromptError(useCaseResult.message));
      }
    } catch (e) {
      emit(PromptError(e.toString()));
    }
  }

  
}

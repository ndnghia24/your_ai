import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:your_ai/features/knowledged_bot/domain/assistant_usecase_factory.dart';
import 'package:your_ai/features/knowledged_bot/presentation/blocs/assistant_event.dart';
import 'package:your_ai/features/knowledged_bot/presentation/blocs/assistant_state.dart';


class AssistantBloc extends Bloc<AssistantEvent, AssistantState> {
  final AssistantUseCaseFactory assistantUseCaseFactory;

  AssistantBloc(this.assistantUseCaseFactory) : super(AssistantInitial()) {
    on<GetAllAssistantEvent>(_onGetAllAssistantEvent);
    on<CreateAssistantEvent>(_onCreateAssistantEvent);
    on<UpdateAssistantEvent>(_onUpdateAssistantEvent);
    on<DeleteAssistantEvent>(_onDeleteAssistantEvent);
  }

  FutureOr<void> _onGetAllAssistantEvent(GetAllAssistantEvent event, Emitter<AssistantState> emit) async{
    emit(AssistantLoading(assistants: [], message: ''));
    try {
      final result = await assistantUseCaseFactory.getAssistantsUseCase().execute();
      if (result.isSuccess) {
        emit(AssistantLoaded(result.result));
      } else {
        String errorMessage = result.message;
        emit(AssistantError(errorMessage));
      }
    } catch (e) {
      emit(AssistantError(e.toString()));
    }
  }

  Future<void> _onCreateAssistantEvent(
      CreateAssistantEvent event, Emitter<AssistantState> emit) async {
    emit(AssistantLoading(assistants: [], message: ''));
    try {
      final useCaseResult =
          await assistantUseCaseFactory.createAssistantUseCase().execute(
        assistantName: event.assistantName,
        description: event.description,
      );

      if (useCaseResult.isSuccess) {
        final assistatns = event.assistants;
        assistatns.add(useCaseResult.result);
        emit(AssistantLoaded(assistatns));
      } else {
        emit(AssistantError(useCaseResult.message));
      }
    } catch (e) {
      emit(AssistantError(e.toString()));
    }
  }
 
  Future<void> _onUpdateAssistantEvent(
      UpdateAssistantEvent event, Emitter<AssistantState> emit) async {
    emit(AssistantLoading(assistants: [], message: ''));
    try {
      final useCaseResult =
          await assistantUseCaseFactory.updateAssistantUseCase().execute(
        assistantId: event.assistantId,
        assistantName: event.assistantName,
        description: event.description,
      );

        final assistants = event.assistants;
        final index = assistants
            .indexWhere((element) => element.id == event.assistantId);
        assistants[index] = useCaseResult.result;

        emit(AssistantLoaded(assistants));

    } catch (e) {
      emit(AssistantError(e.toString()));
    }
  }

  Future<void> _onDeleteAssistantEvent(
      DeleteAssistantEvent event, Emitter<AssistantState> emit) async {
    emit(AssistantLoading(assistants: [], message: ''));
    try {
      final useCaseResult = await assistantUseCaseFactory
          .deleteAssistantUseCase()
          .execute(assistantId: event.assistantId);

      if (useCaseResult.isSuccess) {
        final assistants = event.assistants;
        assistants.removeWhere((element) => element.id == event.assistantId);
        emit(AssistantLoaded(assistants));
      } else {
        emit(AssistantError(useCaseResult.message));
      }
    } catch (e) {
      emit(AssistantError(e.toString()));
    }
  }


  
}
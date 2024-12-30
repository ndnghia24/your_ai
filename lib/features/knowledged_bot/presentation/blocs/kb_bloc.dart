import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:your_ai/features/knowledge_base/domain/entities/knowledge_model.dart';
import 'package:your_ai/features/knowledged_bot/domain/assistant_usecase_factory.dart';
import 'package:your_ai/features/knowledged_bot/domain/entities/knowledge_model.dart';
import 'package:your_ai/features/knowledged_bot/presentation/blocs/kb_event.dart';
import 'package:your_ai/features/knowledged_bot/presentation/blocs/kb_state.dart';



class KBBloc extends Bloc<KBEvent, KBState> {
  final AssistantUseCaseFactory assistantUseCaseFactory;

  KBBloc(this.assistantUseCaseFactory) : super(KBInitial()) {
    on<GetAllKBEvent>(_onGetAllKBEvent);
    on<AttachKBEvent>(_onAttachKBEvent);
    on<DetachKBEvent>(_onDetachKBEvent);

  }

  Future<void> _onGetAllKBEvent(
      GetAllKBEvent event, Emitter<KBState> emit) async {
    emit(KBLoading(knowledgeBases: []));
    try {
      final result = await assistantUseCaseFactory.getAttachedKnowledgesUseCase().execute(
        assistantId: event.assistantId);
      if (result.isSuccess) {
        emit(KBLoaded(result.result));
        print("KBLoaded");
      } else {
        emit(KBError(result.message));
        print("KBError");
      }
    } catch (e) {
      emit(KBError(e.toString()));
    }
  }

  Future<void> _onAttachKBEvent(
      AttachKBEvent event, Emitter<KBState> emit) async {
    emit(KBLoading(knowledgeBases: event.knowledgeBases));
    try {
       assistantUseCaseFactory.attachKnowledgeUseCase().execute(
        assistantId: event.assistantId,
        knowledgeId: event.knowledgeId,
      );


        final index = event.knowledgeBases
            .indexWhere((element) => element.id == event.knowledgeId);
        event.knowledgeBases[index] = Knowledge(
          id: event.knowledgeId,
          knowledgeName: event.knowledgeBases[index].knowledgeName,
          description: event.knowledgeBases[index].description,
          isImported: true,
        );
        emit(KBLoaded(event.knowledgeBases));
 
    } catch (e) {
      emit(KBError(e.toString()));
    }
  }

  Future<void> _onDetachKBEvent(
      DetachKBEvent event, Emitter<KBState> emit) async {
    emit(KBLoading(knowledgeBases: event.knowledgeBases));
    try {
       assistantUseCaseFactory.detachKnowledgeUseCase().execute(
        assistantId: event.assistantId,
        knowledgeId: event.knowledgeId,
      );


        final index = event.knowledgeBases
            .indexWhere((element) => element.id == event.knowledgeId);
        event.knowledgeBases[index] = Knowledge(
          id: event.knowledgeId,
          knowledgeName: event.knowledgeBases[index].knowledgeName,
          description: event.knowledgeBases[index].description,
          isImported: false,
        );
        emit(KBLoaded(event.knowledgeBases));

    } catch (e) {
      emit(KBError(e.toString()));
    }
  }

 

}

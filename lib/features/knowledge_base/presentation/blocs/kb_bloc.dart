import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:your_ai/features/knowledge_base/domain/entities/knowledge_model.dart';
import 'package:your_ai/features/knowledge_base/domain/knowledge_usecase_factory.dart';
import 'package:your_ai/features/knowledge_base/presentation/blocs/kb_event.dart';
import 'package:your_ai/features/knowledge_base/presentation/blocs/kb_state.dart';

class KBBloc extends Bloc<KBEvent, KBState> {
  final KnowledgeUseCaseFactory KBUseCaseFactory;

  KBBloc(this.KBUseCaseFactory) : super(KBInitial()) {
    on<GetAllKBEvent>(_onGetAllKBEvent);
    on<CreateKBEvent>(_onCreateKBEvent);
    on<UpdateKBEvent>(_onUpdateKBEvent);
    on<DeleteKBEvent>(_onDeleteKBEvent);
  }

  Future<void> _onGetAllKBEvent(
      GetAllKBEvent event, Emitter<KBState> emit) async {
    emit(KBLoading(knowledgeBases: []));
    try {
      final result = await KBUseCaseFactory.getKnowledgeListUseCase.execute();
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

  Future<void> _onCreateKBEvent(
      CreateKBEvent event, Emitter<KBState> emit) async {
    emit(KBLoading(knowledgeBases: event.knowledgeBases));
    try {
      final result = await KBUseCaseFactory.createKnowledgeUseCase.execute({
        'knowledgeName': event.knowledgeName,
        'description': event.description,
      });

      if (result.isSuccess) {
        KnowledgeBase knowledgeBase = new KnowledgeBase(
          id: result.result.id,
          knowledgeName: event.knowledgeName,
          description: event.description,
        );

        event.knowledgeBases.add(knowledgeBase);
        emit(KBLoaded(event.knowledgeBases));
      } else {
        emit(KBError(result.message));
      }
    } catch (e) {
      emit(KBError(e.toString()));
    }
  }

  Future<void> _onUpdateKBEvent(
      UpdateKBEvent event, Emitter<KBState> emit) async {
    emit(KBLoading(knowledgeBases: event.knowledgeBases));
    try {
      final result =
          await KBUseCaseFactory.updateKnowledgeUseCase.execute(event.id, {
        'knowledgeName': event.knowledgeName,
        'description': event.description,
      });
      if (result.isSuccess) {
        final index = event.knowledgeBases
            .indexWhere((element) => element.id == event.id);
        event.knowledgeBases[index] = KnowledgeBase(
          id: event.id,
          knowledgeName: event.knowledgeName,
          description: event.description,
        );
        emit(KBLoaded(event.knowledgeBases));
      } else {
        emit(KBError(result.message));
      }
    } catch (e) {
      emit(KBError(e.toString()));
    }
  }

  Future<void> _onDeleteKBEvent(
      DeleteKBEvent event, Emitter<KBState> emit) async {
    emit(KBLoading(knowledgeBases: event.knowledgeBases));
    try {
      KBUseCaseFactory.deleteKnowledgeUseCase.execute(event.id);
      event.knowledgeBases.removeWhere((element) => element.id == event.id);
      emit(KBLoaded(event.knowledgeBases));
    } catch (e) {
      emit(KBError(e.toString()));
    }
  }
}

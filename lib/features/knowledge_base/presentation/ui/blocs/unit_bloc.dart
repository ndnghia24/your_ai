import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:your_ai/features/knowledge_base/data/data_sources/services/knowledge_auth_service.dart';
import 'package:your_ai/features/knowledge_base/domain/entities/knowledge_model.dart';
import 'package:your_ai/features/knowledge_base/domain/entities/unit_model.dart';
import 'package:your_ai/features/knowledge_base/domain/knowledge_usecase_factory.dart';
import 'package:your_ai/features/knowledge_base/presentation/ui/blocs/kb_event.dart';
import 'package:your_ai/features/knowledge_base/presentation/ui/blocs/kb_state.dart';
import 'package:your_ai/features/knowledge_base/presentation/ui/blocs/unit_event.dart';
import 'package:your_ai/features/knowledge_base/presentation/ui/blocs/unit_state.dart';

class UnitBloc extends Bloc<UnitEvent, UnitState> {
  final KnowledgeUseCaseFactory KBUseCaseFactory;
  final KnowledgeAuthService _authService = KnowledgeAuthService();

  UnitBloc(this.KBUseCaseFactory) : super(UnitInitial()) {
    on<GetAllUnitEvent>(_onGetAllUnitEvent);
    on<UploadUnitEvent>(_onUploadUnitEvent);
    on<DeleteUnitEvent>(_onDeleteUnitEvent);

  }

  Future<void> _signIn() async {
    try {
      final response = await _authService.signInWithEmailAndPassword(
        "anony24@gmail.com",
        "Anony24",
      );
      if (response.statusCode == 200) {
        print('Sign in successful');
      } else {
        print('Sign in failed');
      }
    } catch (e) {
      print('Error during sign in: $e');
    }
  }

  Future<void> _onGetAllUnitEvent(
      GetAllUnitEvent event, Emitter<UnitState> emit) async {
    emit(UnitLoading(units: []));
    try {
      await _signIn();

      final result = await KBUseCaseFactory.getKnowledgeUnitsUseCase
          .execute(event.id, _authService.accessToken!);
      if (result.isSuccess) {
        emit(UnitLoaded(result.result));

      } else {
        emit(UnitError(result.message));
      }
    } catch (e) {
      emit(UnitError(e.toString()));
    }
  }

  Future<void> _onUploadUnitEvent(
      UploadUnitEvent event, Emitter<UnitState> emit) async {
    emit(UnitInitial());
    
    
  }

  Future<void> _onDeleteUnitEvent(
      DeleteUnitEvent event, Emitter<UnitState> emit) async {
    emit(UnitLoading(units: []));
    try {

        KBUseCaseFactory.deleteKnowledgeUnitUseCase
          .execute(event.knowledgeId, event.id, _authService.accessToken!);
      //print("units length: ${event.units.length}");
        print("event id: ${event.id}");

        for (var i = 0; i < event.units.length; i++) {
          print("unit id: ${event.units[i].id}");
        }

        event.units.removeWhere((element) => element.id == event.id);
        emit(UnitLoaded(event.units));

 
      
    } catch (e) {
      emit(UnitError(e.toString()));
    }
  }



  
}

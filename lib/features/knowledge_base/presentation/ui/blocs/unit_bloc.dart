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
      print("_authService.accessToken: ${_authService.accessToken}");
      final result = await KBUseCaseFactory.getKnowledgeUnitsUseCase
          .execute(event.id, _authService.accessToken!);
      if (result.isSuccess) {
        emit(UnitLoaded(result.result));
        print("KBLoaded");
      } else {
        emit(UnitError(result.message));
        print("KBError");
      }
    } catch (e) {
      emit(UnitError(e.toString()));
    }
  }

  Future<void> _onUploadUnitEvent(
      UploadUnitEvent event, Emitter<UnitState> emit) async {
    emit(UnitInitial());
    
    
  }

  
}

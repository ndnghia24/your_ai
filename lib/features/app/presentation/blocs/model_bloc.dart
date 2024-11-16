import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_ai/features/app/domain/entities/model_model.dart';
import 'model_event.dart';
import 'model_state.dart';

class ModelBloc extends Bloc<ModelEvent, ModelState> {
  ModelBloc() : super(const ModelInitial(GenerativeAiModel.gpt4oMini)) {
    on<UpdateModel>(_onUpdateModel);
  }

  Future<void> _onUpdateModel(UpdateModel event, Emitter<ModelState> emit) async {
    emit(ModelInitial(event.newModel));
  }
}
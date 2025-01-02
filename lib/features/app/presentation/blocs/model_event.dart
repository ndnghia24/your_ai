import 'package:equatable/equatable.dart';
import 'package:your_ai/features/app/domain/entities/model_model.dart';
import 'package:your_ai/features/knowledged_bot/domain/entities/assistant_model.dart';

abstract class ModelEvent extends Equatable {
  const ModelEvent();

  @override
  List<Object> get props => [];
}

class UpdateModel extends ModelEvent {
  final GenerativeAiModel newModel;
  final Assistant? selectedAssistant;

  const UpdateModel(this.newModel, {this.selectedAssistant});

  @override
  List<Object> get props => [newModel];
}
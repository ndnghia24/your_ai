import 'package:equatable/equatable.dart';
import 'package:your_ai/features/app/domain/entities/model_model.dart';
import 'package:your_ai/features/knowledged_bot/domain/entities/assistant_model.dart';

abstract class ModelState extends Equatable {
  const ModelState();

  @override
  List<Object?> get props => [];
}

class ModelInitial extends ModelState {
  final GenerativeAiModel selectedModel;
  final Assistant? selectedAssistant;

  const ModelInitial(this.selectedModel, {this.selectedAssistant});

  @override
  List<Object?> get props => [selectedModel, selectedAssistant];
}


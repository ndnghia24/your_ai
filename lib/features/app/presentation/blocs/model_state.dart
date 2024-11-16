import 'package:equatable/equatable.dart';
import 'package:your_ai/features/app/domain/entities/model_model.dart';

abstract class ModelState extends Equatable {
  const ModelState();

  @override
  List<Object> get props => [];
}

class ModelInitial extends ModelState {
  final GenerativeAiModel selectedModel;

  const ModelInitial(this.selectedModel);

  @override
  List<Object> get props => [selectedModel];
}
import 'package:equatable/equatable.dart';
import 'package:your_ai/features/app/domain/entities/model_model.dart';

abstract class ModelEvent extends Equatable {
  const ModelEvent();

  @override
  List<Object> get props => [];
}

class UpdateModel extends ModelEvent {
  final GenerativeAiModel newModel;

  const UpdateModel(this.newModel);

  @override
  List<Object> get props => [newModel];
}
import 'package:equatable/equatable.dart';
import 'package:your_ai/features/knowledged_bot/domain/entities/assistant_model.dart';



abstract class AssistantState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AssistantInitial extends AssistantState {}

class AssistantLoading extends AssistantState {
  List<Assistant> assistants;
  String message;

  AssistantLoading(
      {required this.assistants,
      this.message = ''});

  @override
  List<Object?> get props => [assistants, message];
}

class AssistantLoaded extends AssistantState {
  final List<Assistant> assistants;

  AssistantLoaded(this.assistants);
  

  @override
  List<Object?> get props => [assistants];
}

class AssistantError extends AssistantState {
  final String message;
  final List<Assistant>? assistants;


  AssistantError(this.message, {this.assistants});

  @override
  List<Object?> get props => [message];
}

import 'package:equatable/equatable.dart';
import 'package:your_ai/features/chat_prompt/domain/entities/prompt.dart';

abstract class ChatPromptState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChatPromptInitial extends ChatPromptState {}

class ChatPromptLoading extends ChatPromptState {
  List<Prompt> privatePrompts;
  List<Prompt> publicPrompts;
  String message;

  ChatPromptLoading(
      {required this.privatePrompts,
      required this.publicPrompts,
      this.message = ''});

  @override
  List<Object?> get props => [privatePrompts, publicPrompts, message];
}

class ChatPromptLoaded extends ChatPromptState {
  final List<Prompt> privatePrompts;
  final List<Prompt> publicPrompts;

  ChatPromptLoaded(this.privatePrompts, this.publicPrompts);

  @override
  List<Object?> get props => [privatePrompts, publicPrompts];
}

class ChatPromptError extends ChatPromptState {
  final String message;
  final List<Prompt>? privatePrompts;
  final List<Prompt>? publicPrompts;

  ChatPromptError(this.message, {this.privatePrompts, this.publicPrompts});

  @override
  List<Object?> get props => [message];
}

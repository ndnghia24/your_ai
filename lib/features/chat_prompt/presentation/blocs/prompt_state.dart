import 'package:equatable/equatable.dart';

import '../../domain/entities/prompt.dart';

abstract class PromptState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PromptInitial extends PromptState {}

class PromptLoading extends PromptState {
  List<Prompt> privatePrompts;
  List<Prompt> publicPrompts;
  String message;

  PromptLoading(
      {required this.privatePrompts,
      required this.publicPrompts,
      this.message = ''});

  @override
  List<Object?> get props => [privatePrompts, publicPrompts, message];
}

class PromptLoaded extends PromptState {
  final List<Prompt> privatePrompts;
  final List<Prompt> publicPrompts;

  PromptLoaded(this.privatePrompts, this.publicPrompts);

  @override
  List<Object?> get props => [privatePrompts, publicPrompts];
}

class PromptError extends PromptState {
  final String message;
  final List<Prompt>? privatePrompts;
  final List<Prompt>? publicPrompts;

  PromptError(this.message, {this.privatePrompts, this.publicPrompts});

  @override
  List<Object?> get props => [message];
}

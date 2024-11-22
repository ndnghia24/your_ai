import 'package:equatable/equatable.dart';
import 'package:your_ai/features/chat_prompt/domain/entities/prompt.dart';

abstract class ChatPromptEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetAllPromptEvent extends ChatPromptEvent {

  GetAllPromptEvent();
}

class GetPrivatePromptEvent extends ChatPromptEvent {
  final List<Prompt> publicPrompts;

  GetPrivatePromptEvent(this.publicPrompts);
}

class GetPublicPromptEvent extends ChatPromptEvent {
  final List<Prompt> privatePrompts;

  GetPublicPromptEvent(this.privatePrompts);
}



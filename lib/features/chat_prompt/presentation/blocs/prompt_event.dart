import 'package:equatable/equatable.dart';
import 'package:your_ai/features/chat_prompt/domain/entities/prompt.dart';

abstract class PromptEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetAllPromptEvent extends PromptEvent {

  GetAllPromptEvent();
}

class GetPrivatePromptEvent extends PromptEvent {
  final List<Prompt> publicPrompts;

  GetPrivatePromptEvent(this.publicPrompts);
}

class GetPublicPromptEvent extends PromptEvent {
  final List<Prompt> privatePrompts;

  GetPublicPromptEvent(this.privatePrompts);
}

class AddNewPublicPromptEvent extends PromptEvent {
  final String title;
  final String description;
  final String content;
  final String category;
  final String language;
  final List<Prompt> publicPrompts;
  final List<Prompt> privatePrompts;

  AddNewPublicPromptEvent(
    this.title,
    this.description,
    this.content,
    this.category,
    this.language,
    this.publicPrompts,
    this.privatePrompts,
  );
}

class AddNewPrivatePromptEvent extends PromptEvent {
  final String title;
  final String description;
  final String content;
  final List<Prompt> publicPrompts;
  final List<Prompt> privatePrompts;

  AddNewPrivatePromptEvent(
    this.title,
    this.description,
    this.content,
    this.publicPrompts,
    this.privatePrompts,
  );
}

class UpdatePrivatePromptEvent extends PromptEvent {
  final String promptId;
  final String? title;
  final String description;
  final String? content;
  final String category;
  final String language;
  final bool isPublic;
  final List<Prompt> publicPrompts;
  final List<Prompt> privatePrompts;

  UpdatePrivatePromptEvent(
    this.promptId,
    this.title,
    this.description,
    this.content,
    this.category,
    this.language,
    this.isPublic,
    this.publicPrompts,
    this.privatePrompts,
  );
}

class DeletePrivatePromptEvent extends PromptEvent {
  final String promptId;
  final List<Prompt> publicPrompts;
  final List<Prompt> privatePrompts;

  DeletePrivatePromptEvent(
      this.promptId, this.publicPrompts, this.privatePrompts);
}

class AddFavoritePromptEvent extends PromptEvent {
  final String promptId;
  final List<Prompt> publicPrompts;
  final List<Prompt> privatePrompts;

  AddFavoritePromptEvent(
      this.promptId, this.publicPrompts, this.privatePrompts);
}

class RemoveFavoritePromptEvent extends PromptEvent {
  final String promptId;
  final List<Prompt> publicPrompts;
  final List<Prompt> privatePrompts;

  RemoveFavoritePromptEvent(
      this.promptId, this.publicPrompts, this.privatePrompts);
}

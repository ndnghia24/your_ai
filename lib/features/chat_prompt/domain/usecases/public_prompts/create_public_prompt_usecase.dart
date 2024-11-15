import 'package:your_ai/core/templates/usecase_result_template.dart';
import 'package:your_ai/features/chat_prompt/data/repositories/chat_prompt_repository.dart';
import 'package:your_ai/features/chat_prompt/domain/entities/prompt.dart';

class CreatePublicPromptUsecase {
  final ChatPromptRepository chatPromptRepository;

  CreatePublicPromptUsecase(this.chatPromptRepository);

  Future<UsecaseResultTemplate<Prompt>> execute({
    required String title,
    required String description,
    required String content,
    required String category,
    required String language,
  }) async {
    try {
      final newPrompt = await chatPromptRepository.createNewPrompt(
        promptData: {
          'title': title,
          'description': description,
          'content': content,
          'category': category,
          'language': language,
          'isPublic': true,
        },
      );

      return UsecaseResultTemplate<Prompt>(
        isSuccess: true,
        result: newPrompt,
        message: 'Prompt created successfully',
      );
    } catch (e) {
      return UsecaseResultTemplate<Prompt>(
        isSuccess: false,
        result: Prompt.initial(),
        message: 'Error creating prompt: $e',
      );
    }
  }
}

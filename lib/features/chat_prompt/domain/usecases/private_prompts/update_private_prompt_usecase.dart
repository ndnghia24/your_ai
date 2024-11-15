import 'package:your_ai/core/templates/usecase_result_template.dart';
import 'package:your_ai/features/chat_prompt/data/repositories/chat_prompt_repository.dart';
import 'package:your_ai/features/chat_prompt/domain/entities/prompt.dart';

class UpdatePrivatePromptUsecase {
  final ChatPromptRepository chatPromptRepository;

  UpdatePrivatePromptUsecase(this.chatPromptRepository);

  Future<UsecaseResultTemplate<Prompt>> execute({
    required String promptId,
    String? title,
    required String description,
    String? content,
    required String category,
    required String language,
    required bool isPublic,
  }) async {
    try {
      final updatedPrompt = await chatPromptRepository.updatePrompt(
        promptId: promptId,
        promptData: {
          'title': title,
          'description': description,
          'content': content,
          'category': category,
          'language': language,
          'isPublic': isPublic,
        },
      );

      return UsecaseResultTemplate<Prompt>(
        isSuccess: true,
        result: updatedPrompt,
        message: 'Prompt updated successfully.',
      );
    } catch (e) {
      return UsecaseResultTemplate<Prompt>(
        isSuccess: false,
        result: Prompt.initial(),
        message: 'Error updating prompt: ${e.toString()}',
      );
    }
  }
}

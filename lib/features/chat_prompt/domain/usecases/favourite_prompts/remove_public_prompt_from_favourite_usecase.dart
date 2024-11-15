import 'package:your_ai/core/templates/usecase_result_template.dart';
import 'package:your_ai/features/chat_prompt/data/repositories/chat_prompt_repository.dart';

class RemoveFavouritePromptUsecase {
  final ChatPromptRepository chatPromptRepository;

  RemoveFavouritePromptUsecase(this.chatPromptRepository);

  Future<UsecaseResultTemplate<String>> execute({
    required String promptId,
  }) async {
    try {
      await chatPromptRepository.removePromptFromFavorite(
        promptId: promptId,
      );

      return UsecaseResultTemplate<String>(
        isSuccess: true,
        result: 'Prompt removed from favourite successfully.',
        message: 'Prompt removed from favourite successfully.',
      );
    } catch (e) {
      return UsecaseResultTemplate<String>(
        isSuccess: false,
        result: 'Error removing prompt from favourite: ${e.toString()}',
        message: 'Error removing prompt from favourite: ${e.toString()}',
      );
    }
  }
}

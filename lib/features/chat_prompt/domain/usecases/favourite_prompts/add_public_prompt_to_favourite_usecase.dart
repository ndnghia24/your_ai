import 'package:your_ai/core/templates/usecase_result_template.dart';
import 'package:your_ai/features/chat_prompt/data/repositories/chat_prompt_repository.dart';

class AddFavouritePromptUsecase {
  final ChatPromptRepository chatPromptRepository;

  AddFavouritePromptUsecase(this.chatPromptRepository);

  Future<UsecaseResultTemplate<String>> execute({
    required String promptId,
  }) async {
    try {
      await chatPromptRepository.addPromptToFavorite(
        promptId: promptId,
      );

      return UsecaseResultTemplate<String>(
        isSuccess: true,
        result: 'Prompt added to favourite successfully.',
        message: 'Prompt added to favourite successfully.',
      );
    } catch (e) {
      return UsecaseResultTemplate<String>(
        isSuccess: false,
        result: 'Error adding prompt to favourite: ${e.toString()}',
        message: 'Error adding prompt to favourite: ${e.toString()}',
      );
    }
  }
}

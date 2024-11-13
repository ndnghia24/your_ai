import 'package:your_ai/features/chat_prompt/data/repositories/chat_prompt_repository.dart';

class AddFavouritePromptUsecase {
  final ChatPromptRepository chatPromptRepository;

  AddFavouritePromptUsecase(this.chatPromptRepository);

  Future<Map<String, dynamic>> execute({
    required String promptId,
  }) async {
    try {
      final res = await chatPromptRepository.addPromptToFavorite(
        promptId: promptId,
      );

      return {
        'isSuccess': true,
        'result': 'Prompt added to favourite',
      };
    } catch (e) {
      return {
        'isSuccess': false,
        'result': 'Error adding prompt to favourite: $e',
      };
    }
  }
}

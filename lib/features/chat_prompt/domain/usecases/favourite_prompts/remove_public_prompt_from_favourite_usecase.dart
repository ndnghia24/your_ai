import 'package:your_ai/features/chat_prompt/data/repositories/chat_prompt_repository.dart';

class RemoveFavouritePromptUsecase {
  final ChatPromptRepository chatPromptRepository;

  RemoveFavouritePromptUsecase(this.chatPromptRepository);

  Future<Map<String, dynamic>> execute({
    required String promptId,
  }) async {
    try {
      final res = await chatPromptRepository.removePromptFromFavorite(
        promptId: promptId,
      );

      return {
        'isSuccess': true,
        'result': 'Prompt removed from favourite',
      };
    } catch (e) {
      return {
        'isSuccess': false,
        'result': 'Error removing prompt from favourite: $e',
      };
    }
  }
}

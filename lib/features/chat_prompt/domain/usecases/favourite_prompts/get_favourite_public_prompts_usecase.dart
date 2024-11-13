import 'package:your_ai/features/chat_prompt/data/repositories/chat_prompt_repository.dart';

class GetFavouritePromptUsecase {
  final ChatPromptRepository chatPromptRepository;

  GetFavouritePromptUsecase(this.chatPromptRepository);

  Future<Map<String, dynamic>> execute() async {
    try {
      final res = await chatPromptRepository.getFavouritePrompts();

      return {
        'isSuccess': true,
        'result': res,
      };
    } catch (e) {
      return {
        'isSuccess': false,
        'result': 'Error getting favourite prompts: $e',
      };
    }
  }
}

import 'package:your_ai/features/chat_prompt/data/repositories/chat_prompt_repository.dart';

class DeletePrivatePromptUsecase {
  final ChatPromptRepository chatPromptRepository;

  DeletePrivatePromptUsecase(this.chatPromptRepository);

  Future<Map<String, dynamic>> execute({
    required String promptId,
  }) async {
    try {
      final res = await chatPromptRepository.deletePrompt(
        promptId: promptId,
      );

      return {
        'isSuccess': true,
        'result': 'Prompt deleted successfully',
      };
    } catch (e) {
      return {
        'isSuccess': false,
        'result': 'Error deleting prompt: $e',
      };
    }
  }
}

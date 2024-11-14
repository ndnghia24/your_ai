import 'package:your_ai/core/templates/usecase_result_template.dart';
import 'package:your_ai/features/chat_prompt/data/repositories/chat_prompt_repository.dart';

class DeletePrivatePromptUsecase {
  final ChatPromptRepository chatPromptRepository;

  DeletePrivatePromptUsecase(this.chatPromptRepository);

  Future<UsecaseResultTemplate<String>> execute({
    required String promptId,
  }) async {
    try {
      await chatPromptRepository.deletePrompt(
        promptId: promptId,
      );

      return UsecaseResultTemplate<String>(
        isSuccess: true,
        result: 'Prompt deleted successfully',
        message: 'The private prompt has been deleted.',
      );
    } catch (e) {
      return UsecaseResultTemplate<String>(
        isSuccess: false,
        result: 'Error deleting prompt: $e',
        message: 'Error occurred while trying to delete the private prompt.',
      );
    }
  }
}

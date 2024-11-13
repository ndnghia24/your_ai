import 'package:your_ai/features/chat_prompt/data/repositories/chat_prompt_repository.dart';

class UpdatePrivatePromptUsecase {
  final ChatPromptRepository chatPromptRepository;

  UpdatePrivatePromptUsecase(this.chatPromptRepository);

  Future<Map<String, dynamic>> execute({
    required String promptId,
    required String title,
    required String description,
    required String content,
    required String category,
    required String language,
    required bool isPublic,
  }) async {
    try {
      final res = await chatPromptRepository.updatePrompt(
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

      return {
        'isSuccess': true,
        'result': 'Prompt updated successfully',
      };
    } catch (e) {
      return {
        'isSuccess': false,
        'result': 'Error updating prompt: $e',
      };
    }
  }
}

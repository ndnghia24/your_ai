import 'package:your_ai/features/chat_prompt/data/repositories/chat_prompt_repository.dart';

class CreatePrivatePromptUsecase {
  final ChatPromptRepository chatPromptRepository;

  CreatePrivatePromptUsecase(this.chatPromptRepository);

  Future<Map<String, dynamic>> execute({
    required String title,
    required String description,
    required String content,
  }) async {
    try {
      final newPrompt = await chatPromptRepository.createNewPrompt(
        promptData: {
          'title': title,
          'description': description,
          'content': content,
          'isPublic': false,
        },
      );

      return {
        'isSuccess': true,
        'result': newPrompt,
      };
    } catch (e) {
      return {
        'isSuccess': false,
        'result': 'Error creating prompt: $e',
      };
    }
  }
}

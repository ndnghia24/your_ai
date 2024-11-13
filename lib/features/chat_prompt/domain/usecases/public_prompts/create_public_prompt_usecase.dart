import 'package:your_ai/features/chat_prompt/data/repositories/chat_prompt_repository.dart';

class CreatePublicPromptUsecase {
  final ChatPromptRepository chatPromptRepository;

  CreatePublicPromptUsecase(this.chatPromptRepository);

  Future<Map<String, dynamic>> execute({
    required String title,
    required String description,
    required String content,
    required String category,
    required String language,
  }) async {
    try {
      final newPrompt = await chatPromptRepository.createNewPrompt(
        promptData: {
          'title': title,
          'description': description,
          'content': content,
          'category': category,
          'language': language,
          'isPublic': true,
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

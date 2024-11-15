import 'package:your_ai/core/templates/usecase_result_template.dart';
import 'package:your_ai/features/chat_prompt/data/repositories/chat_prompt_repository.dart';
import 'package:your_ai/features/chat_prompt/domain/entities/prompt.dart';

class CreatePrivatePromptUsecase {
  final ChatPromptRepository chatPromptRepository;

  CreatePrivatePromptUsecase(this.chatPromptRepository);

  Future<UsecaseResultTemplate<Prompt>> execute({
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

      return UsecaseResultTemplate<Prompt>(
        isSuccess: true,
        result: newPrompt,
        message: 'Private prompt created successfully',
      );
    } catch (e) {
      return UsecaseResultTemplate<Prompt>(
        isSuccess: false,
        result: Prompt.initial(),
        message: 'Error creating private prompt: $e',
      );
    }
  }
}

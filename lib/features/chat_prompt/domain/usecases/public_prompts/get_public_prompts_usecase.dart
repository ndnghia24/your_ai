import 'package:your_ai/core/templates/usecase_result_template.dart';
import 'package:your_ai/features/chat_prompt/data/repositories/chat_prompt_repository.dart';
import 'package:your_ai/features/chat_prompt/domain/entities/prompt.dart';

class GetPublicPromptsUsecase {
  final ChatPromptRepository chatPromptRepository;

  GetPublicPromptsUsecase(this.chatPromptRepository);

  Future<UsecaseResultTemplate<List<Prompt>>> execute() async {
    try {
      final promptList = await chatPromptRepository.getAllPrompts(
        params: {
          'isPublic': true,
        },
      );

      return UsecaseResultTemplate<List<Prompt>>(
        isSuccess: true,
        result: promptList,
        message: 'Public prompts fetched successfully',
      );
    } catch (e) {
      return UsecaseResultTemplate<List<Prompt>>(
        isSuccess: false,
        result: [],
        message: 'Error fetching public prompts: $e',
      );
    }
  }
}

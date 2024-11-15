import 'package:your_ai/core/templates/usecase_result_template.dart';
import 'package:your_ai/features/chat_prompt/data/repositories/chat_prompt_repository.dart';
import 'package:your_ai/features/chat_prompt/domain/entities/prompt.dart';

class GetPrivatePromptsUsecase {
  final ChatPromptRepository chatPromptRepository;

  GetPrivatePromptsUsecase(this.chatPromptRepository);

  Future<UsecaseResultTemplate<List<Prompt>>> execute() async {
    try {
      final promptList = await chatPromptRepository.getAllPrompts(
        params: {
          'isPublic': false,
        },
      );

      return UsecaseResultTemplate<List<Prompt>>(
        isSuccess: true,
        result: promptList,
        message: 'Successfully fetched private prompts.',
      );
    } catch (e) {
      return UsecaseResultTemplate<List<Prompt>>(
        isSuccess: false,
        result: [],
        message:
            'Error occurred while fetching private prompts: ${e.toString()}',
      );
    }
  }
}

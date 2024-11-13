import 'package:your_ai/features/chat_prompt/data/repositories/chat_prompt_repository.dart';

class GetPublicPromptsUsecase {
  final ChatPromptRepository chatPromptRepository;

  GetPublicPromptsUsecase(this.chatPromptRepository);

  Future<Map<String, dynamic>> execute() async {
    try {
      final res = await chatPromptRepository.getAllPrompts(
        params: {
          'isPublic': true,
        },
      );

      return {
        'data': res,
        'isSuccess': true,
      };
    } catch (e) {
      return {
        'data': null,
        'isSuccess': false,
        'message': e.toString(),
      };
    }
  }
}

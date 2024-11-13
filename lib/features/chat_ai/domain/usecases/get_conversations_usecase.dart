import 'package:your_ai/features/chat_ai/data/repositories/chat_ai_repository.dart';

class GetConversationsUseCase {
  final ChatAIRepository chatAIRepository;

  GetConversationsUseCase(this.chatAIRepository);

  Future<Map<String, dynamic>> execute({
    required String assistantId,
    required String assistantModel,
  }) async {
    try {
      final conversationsList = await chatAIRepository.getConversations(
        assistantId: assistantId,
        assistantModel: assistantModel,
      );

      return {
        'isSuccess': true,
        'result': conversationsList,
      };
    } catch (e) {
      return {
        'isSuccess': false,
        'result': e.toString(),
      };
    }
  }
}

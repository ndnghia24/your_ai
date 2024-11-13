import 'package:your_ai/features/chat_ai/data/repositories/chat_ai_repository.dart';
import 'package:your_ai/features/chat_ai/domain/entities/conversation.dart';

class CreateNewConversationUseCase {
  final ChatAIRepository chatAIRepository;

  CreateNewConversationUseCase(this.chatAIRepository);

  Future<Map<String, dynamic>> execute({
    required String content,
    required String assistantId,
    required String assistantModel,
  }) async {
    try {
      final newConversation =
          await chatAIRepository.createNewConversationWithFirstMessage(
        content: content,
        assistant: {
          'id': assistantId,
          'model': assistantModel,
        },
      );

      return {
        'isSuccess': true,
        'result': newConversation,
      };
    } catch (e) {
      return {
        'isSuccess': false,
        'result': Conversation(id: '-1', messages: []),
      };
    }
  }
}

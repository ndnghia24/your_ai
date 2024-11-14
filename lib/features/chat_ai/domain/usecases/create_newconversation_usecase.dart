import 'package:your_ai/core/templates/usecase_result_template.dart';
import 'package:your_ai/features/chat_ai/data/repositories/chat_ai_repository.dart';
import 'package:your_ai/features/chat_ai/domain/entities/conversation.dart';

class CreateNewConversationUseCase {
  final ChatAIRepository chatAIRepository;

  CreateNewConversationUseCase(this.chatAIRepository);

  Future<UsecaseResultTemplate<Conversation>> execute({
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

      return UsecaseResultTemplate<Conversation>(
        isSuccess: true,
        result: newConversation,
        message: 'New conversation created successfully',
      );
    } catch (e) {
      return UsecaseResultTemplate<Conversation>(
        isSuccess: false,
        result: Conversation(id: '-1', messages: []),
        message:
            'Error occurred while creating new conversation: ${e.toString()}',
      );
    }
  }
}

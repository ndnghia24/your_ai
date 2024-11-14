import 'package:your_ai/core/templates/usecase_result_template.dart';
import 'package:your_ai/features/chat_ai/data/repositories/chat_ai_repository.dart';
import 'package:your_ai/features/chat_ai/domain/entities/conversation.dart';
import 'package:your_ai/features/chat_ai/domain/entities/conversation_list.dart';

class GetConversationsUseCase {
  final ChatAIRepository chatAIRepository;

  GetConversationsUseCase(this.chatAIRepository);

  Future<UsecaseResultTemplate<ConversationList>> execute({
    required String assistantId,
    required String assistantModel,
  }) async {
    try {
      final conversationsList = await chatAIRepository.getConversations(
        assistantId: assistantId,
        assistantModel: assistantModel,
      );

      return UsecaseResultTemplate<ConversationList>(
        isSuccess: true,
        result: conversationsList,
        message: 'Conversations fetched successfully',
      );
    } catch (e) {
      return UsecaseResultTemplate<ConversationList>(
        isSuccess: false,
        result:
            ConversationList(conversationsList: [], currentConversationId: ''),
        message: 'Error occurred while fetching conversations: ${e.toString()}',
      );
    }
  }
}

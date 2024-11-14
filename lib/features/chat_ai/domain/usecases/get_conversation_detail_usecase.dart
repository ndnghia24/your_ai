import 'package:your_ai/core/templates/usecase_result_template.dart';
import 'package:your_ai/features/chat_ai/data/repositories/chat_ai_repository.dart';
import 'package:your_ai/features/chat_ai/domain/entities/conversation.dart';

class GetConversationDetailUseCase {
  final ChatAIRepository chatAIRepository;

  GetConversationDetailUseCase(this.chatAIRepository);

  Future<UsecaseResultTemplate<Conversation>> execute({
    required String conversationId,
    required Map<String, dynamic> params,
  }) async {
    try {
      final result = await chatAIRepository.getConversationMessages(
        conversationId: conversationId,
        params: params,
      );

      return UsecaseResultTemplate<Conversation>(
        isSuccess: true,
        result: result,
        message: 'Conversation details fetched successfully',
      );
    } catch (e) {
      return UsecaseResultTemplate<Conversation>(
        isSuccess: false,
        result: Conversation(id: '-1', messages: []),
        message:
            'Error occurred while fetching conversation details: ${e.toString()}',
      );
    }
  }
}

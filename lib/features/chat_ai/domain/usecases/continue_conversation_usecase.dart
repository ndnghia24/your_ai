import 'package:your_ai/core/templates/usecase_result_template.dart';
import 'package:your_ai/features/chat_ai/data/repositories/chat_ai_repository.dart';
import 'package:your_ai/features/chat_ai/domain/entities/conversation.dart';

class ContinueConversationUseCase {
  final ChatAIRepository chatAIRepository;

  ContinueConversationUseCase(this.chatAIRepository);

  Future<UsecaseResultTemplate<Conversation>> execute({
    required String content,
    required Map<String, dynamic> assistant,
    required Map<String, dynamic> conversation,
  }) async {
    try {
      print('USECASE: ContinueConversationUseCase');
      print('conversation: ${conversation.toString()}');

      final refreshConversation =
          await chatAIRepository.continueConversationWithNextMessage(
        content: content,
        assistant: assistant,
        conversation: conversation,
      );

      return UsecaseResultTemplate<Conversation>(
        isSuccess: true,
        result: refreshConversation,
        message: 'Conversation continued successfully',
      );
    } catch (e) {
      return UsecaseResultTemplate<Conversation>(
        isSuccess: false,
        result: Conversation(id: '-1', messages: []),
        message:
            'Error occurred during conversation continuation: ${e.toString()}',
      );
    }
  }
}

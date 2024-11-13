import '../../data/repositories/chat_ai_repository.dart';

class ContinueConversationUseCase {
  final ChatAIRepository chatAIRepository;

  ContinueConversationUseCase(this.chatAIRepository);

  Future<Map<String, dynamic>> execute({
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

      return {
        'isSuccess': true,
        'result': refreshConversation,
      };
    } catch (e) {
      return {
        'isSuccess': false,
        'result': e.toString(),
      };
    }
  }
}

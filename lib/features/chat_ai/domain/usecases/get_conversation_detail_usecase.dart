import 'package:your_ai/features/chat_ai/data/repositories/chat_ai_repository.dart';

class GetConversationDetailUseCase {
  final ChatAIRepository chatAIRepository;

  GetConversationDetailUseCase(this.chatAIRepository);

  Future<Map<String, dynamic>> execute({
    required String conversationId,
    required Map<String, dynamic> params,
  }) async {
    try {
      final result = await chatAIRepository.getConversationMessages(
        conversationId: conversationId,
        params: params,
      );
      return {
        'isSuccess': true,
        'result': result,
      };
    } catch (e) {
      return {
        'isSuccess': false,
        'result': e.toString(),
      };
    }
  }
}

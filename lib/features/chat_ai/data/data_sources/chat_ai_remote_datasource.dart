import 'package:your_ai/features/chat_ai/data/data_sources/services/chat_ai_service.dart';

class ChatAIRemoteDataSource {
  final ChatAIService _chatAIService;
  const ChatAIRemoteDataSource(this._chatAIService);

  Future<Map<String, dynamic>> continueConversationWithNextMessage(
      {required String content,
      required Map<String, dynamic> assistant,
      required Map<String, dynamic> conversation}) async {
    try {
      final response = await _chatAIService.sendMessage(
        {
          'content': content,
          'assistant': assistant,
          'metadata': {
            'conversation': conversation,
          },
        },
      );

      if (response.statusCode == 200) {
        return {
          'data': response.data,
          'isSuccess': true,
          'message': '[DataSource] Message sent successfully',
        };
      } else {
        return {
          'data': response.data,
          'isSuccess': false,
          'message': '[DataSource] Error occurred during sending message',
        };
      }
    } catch (e) {
      return {
        'isSuccess': false,
        'message': '${e.toString()}',
      };
    }
  }

  Future<Map<String, dynamic>> getConversations(
      {required String assistantId, required String assistantModel}) async {
    try {
      final response = await _chatAIService.getConversationList({
        'assistantId': assistantId,
        'assistantModel': assistantModel,
      });

      if (response.statusCode == 200) {
        return {
          'data': (response.data),
          'isSuccess': true,
          'message': 'User info fetched successfully',
        };
      } else {
        return {
          'data': (response.data),
          'isSuccess': false,
          'message': 'Error occurred during fetching user info',
        };
      }
    } catch (e) {
      return {
        'data': e.toString(),
        'isSuccess': false,
        'message': 'Error occurred during fetching user info: ${e.toString()}',
      };
    }
  }

  Future<Map<String, dynamic>> getConversationMessages(
      {required String conversationId,
      required Map<String, dynamic> params}) async {
    try {
      final response = await _chatAIService.getConversationMessages(
          conversationId: conversationId, params: params);

      if (response.statusCode == 200) {
        return {
          'data': response.data,
          'isSuccess': true,
          'message': 'Logout successful',
        };
      } else {
        return {
          'data': response.data,
          'isSuccess': false,
          'message': 'Error occurred during get conversation messages',
        };
      }
    } catch (e) {
      return {
        'data': e.toString(),
        'isSuccess': false,
        'message':
            'Error occurred during get conversation messages: ${e.toString()}',
      };
    }
  }
}

import 'package:your_ai/core/templates/data_sources_result_template.dart';
import 'package:your_ai/features/chat_ai/data/data_sources/services/chat_ai_service.dart';

class ChatAIRemoteDataSource {
  final ChatAIService _chatAIService;
  const ChatAIRemoteDataSource(this._chatAIService);

  Future<DataSourcesResultTemplate> continueConversationWithNextMessage({
    required String content,
    required Map<String, dynamic> assistant,
    required Map<String, dynamic> conversation,
  }) async {
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
        return DataSourcesResultTemplate(
          isSuccess: true,
          data: response.data,
          message: '[DataSource] Message sent successfully',
        );
      } else {
        return DataSourcesResultTemplate(
          isSuccess: false,
          data: response.data,
          message: '[DataSource] Error occurred during sending message',
        );
      }
    } catch (e) {
      return DataSourcesResultTemplate(
        isSuccess: false,
        data: e.toString(),
        message: 'Error occurred: ${e.toString()}',
      );
    }
  }

  Future<DataSourcesResultTemplate> getConversations({
    required String assistantId,
    required String assistantModel,
  }) async {
    try {
      final response = await _chatAIService.getConversationList({
        'assistantId': assistantId,
        'assistantModel': assistantModel,
      });

      if (response.statusCode == 200) {
        return DataSourcesResultTemplate(
          isSuccess: true,
          data: response.data,
          message: 'Conversations fetched successfully',
        );
      } else {
        return DataSourcesResultTemplate(
          isSuccess: false,
          data: response.data,
          message: 'Error occurred during fetching conversations',
        );
      }
    } catch (e) {
      return DataSourcesResultTemplate(
        isSuccess: false,
        data: e.toString(),
        message: 'Error occurred: ${e.toString()}',
      );
    }
  }

  Future<DataSourcesResultTemplate> getConversationMessages({
    required String conversationId,
    required Map<String, dynamic> params,
  }) async {
    try {
      final response = await _chatAIService.getConversationMessages(
        conversationId: conversationId,
        params: params,
      );

      if (response.statusCode == 200) {
        return DataSourcesResultTemplate(
          isSuccess: true,
          data: response.data,
          message: 'Conversation messages fetched successfully',
        );
      } else {
        return DataSourcesResultTemplate(
          isSuccess: false,
          data: response.data,
          message: 'Error occurred during fetching conversation messages',
        );
      }
    } catch (e) {
      return DataSourcesResultTemplate(
        isSuccess: false,
        data: e.toString(),
        message: 'Error occurred: ${e.toString()}',
      );
    }
  }
}

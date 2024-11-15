import 'package:your_ai/core/templates/data_sources_result_template.dart';
import 'package:your_ai/features/chat_ai/data/data_sources/chat_ai_remote_datasource.dart';
import 'package:your_ai/features/chat_ai/domain/entities/conversation.dart';
import 'package:your_ai/features/chat_ai/domain/entities/conversation_list.dart';
import 'package:your_ai/features/chat_ai/domain/entities/message.dart';

class ChatAIRepository {
  final ChatAIRemoteDataSource _chatAIRemoteDataSource;
  const ChatAIRepository(this._chatAIRemoteDataSource);

  Future<Conversation> createNewConversationWithFirstMessage({
    required String content,
    required Map<String, dynamic> assistant,
  }) async {
    final DataSourcesResultTemplate datasourceRes =
        await _chatAIRemoteDataSource.continueConversationWithNextMessage(
      content: content,
      assistant: assistant,
      conversation: {
        'messages': [],
      },
    );

    print('datasourceRes: ${datasourceRes.data}');

    final id = datasourceRes.data['conversationId'];

    final firstMessage = Message.fromMap({
      'content': content,
      'role': 'user',
      'assistant': assistant,
    });

    final resMessage = Message.fromMap({
      'content': datasourceRes.data['message'],
      'role': 'model',
      'assistant': assistant,
    });

    return Conversation.fromMap({
      'id': id,
      'messages': [firstMessage.toMap(), resMessage.toMap()],
    });
  }

  Future<Conversation> continueConversationWithNextMessage({
    required String content,
    required Map<String, dynamic> assistant,
    required Map<String, dynamic> conversation,
  }) async {
    final DataSourcesResultTemplate datasourceRes =
        await _chatAIRemoteDataSource.continueConversationWithNextMessage(
      content: content,
      assistant: assistant,
      conversation: conversation,
    );

    final messages = conversation['messages'] as List<Map<String, dynamic>>;
    final id = datasourceRes.data['conversationId'];

    final resMessage = Message.fromMap({
      'content': datasourceRes.data['message'],
      'role': 'model',
      'assistant': assistant,
    });

    return Conversation.fromMap({
      'id': id,
      'messages': [...messages, resMessage.toMap()],
    });
  }

  Future<ConversationList> getConversations({
    required String assistantId,
    required String assistantModel,
  }) async {
    final DataSourcesResultTemplate datasourceRes =
        await _chatAIRemoteDataSource.getConversations(
      assistantId: assistantId,
      assistantModel: assistantModel,
    );

    if (!datasourceRes.isSuccess) {
      return ConversationList(conversationsList: [], currentConversationId: '');
    }
    return ConversationList.fromMap(datasourceRes.data);
  }

  Future<Conversation> getConversationMessages({
    required String conversationId,
    required Map<String, dynamic> params,
  }) async {
    final DataSourcesResultTemplate datasourceRes =
        await _chatAIRemoteDataSource.getConversationMessages(
      conversationId: conversationId,
      params: params,
    );

    final messages =
        (datasourceRes.data['messages'] as List<dynamic>).expand((item) {
      if (item is Map<String, dynamic> &&
          item.containsKey('query') &&
          item.containsKey('answer')) {
        return [
          Message.fromMap({
            'content': item['query'],
            'role': 'user',
            'assistant': params,
          }),
          Message.fromMap({
            'content': item['answer'],
            'role': 'model',
            'assistant': params,
          }),
        ];
      }
      return [];
    }).toList();

    return Conversation(
        id: conversationId, messages: List<Message>.from(messages));
  }
}

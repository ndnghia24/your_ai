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
    final res =
        await _chatAIRemoteDataSource.continueConversationWithNextMessage(
      content: content,
      assistant: assistant,
      conversation: {
        'messages': [],
      },
    );

    final id = res['data']['conversationId'];

    final firstMessage = Message.fromMap({
      'content': content,
      'isFromUser': true,
      'assistant': assistant,
    });

    final resMessage = Message.fromMap({
      'content': res['data']['message'],
      'isFromUser': false,
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
    final res =
        await _chatAIRemoteDataSource.continueConversationWithNextMessage(
      content: content,
      assistant: assistant,
      conversation: conversation,
    );

    final messages = conversation['messages'] as List<Map<String, dynamic>>;
    final id = res['data']['conversationId'];

    final resMessage = Message.fromMap({
      'content': res['data']['message'],
      'isFromUser': false,
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
    final res = await _chatAIRemoteDataSource.getConversations(
      assistantId: assistantId,
      assistantModel: assistantModel,
    );

    if (res['data'] == null || res['isSuccess'] == false) {
      return ConversationList(conversationsList: [], currentConversationId: '');
    }
    return ConversationList.fromMap(res['data']);
  }

  Future<Conversation> getConversationMessages({
    required String conversationId,
    required Map<String, dynamic> params,
  }) async {
    final res = await _chatAIRemoteDataSource.getConversationMessages(
      conversationId: conversationId,
      params: params,
    );

    final messages = (res['data']['items'] as List).expand<Message>((item) {
      if (item is Map<String, dynamic> &&
          item.containsKey('query') &&
          item.containsKey('answer')) {
        return [
          Message.fromMap({
            'content': item['query'],
            'isFromUser': true,
            'assistant': params,
          }),
          Message.fromMap({
            'content': item['answer'],
            'isFromUser': false,
            'assistant': params,
          }),
        ];
      }
      return [];
    }).toList();

    return Conversation(id: conversationId, messages: messages);
  }
}

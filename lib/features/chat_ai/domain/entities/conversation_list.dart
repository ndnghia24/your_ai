import 'conversation.dart';

class ConversationList {
  /*
  {
    id: "f32a6751-9200-4357-9281-d22e5785434c",
    title: "hi",
    isCurrent: true,
  }
  */
  late List<Map<String, dynamic>> conversationsList;
  late String currentConversationId;

  ConversationList({
    required this.conversationsList,
    required this.currentConversationId,
  });

  void checkOutConversation(String conversationId) {
    // todo: check out conversation
  }

  void addConversation(String conversationId, String conversationTitle) {
    // todo: add conversation
  }

  void removeConversation(String conversationId, String conversationTitle) {
    // todo: remove conversation
  }

  factory ConversationList.fromMap(Map<String, dynamic> map) {
    /*{
      {
        "cursor": "f32a6751-9200-4357-9281-d22e5785434c",
        "has_more": false,
        "limit": 20,
        "items": [
          {
            "title": "hi",
            "id": "f32a6751-9200-4357-9281-d22e5785434c",
            "createdAt": 1730480205
          }
        ]
      }
    }*/

    final currentId = map['cursor'];
    List<Map<String, dynamic>> conversationsList = [];
    final itemList = map['items'] ?? [];

    for (var item in itemList) {
      final conversationInfo = {
        'id': item['id'],
        'title': item['title'] ?? '',
        'isCurrent': item['id'] == currentId,
      };
      conversationsList.add(conversationInfo);
    }

    return ConversationList(
      conversationsList: conversationsList,
      currentConversationId: currentId,
    );
  }

  String toMapString() {
    return conversationsList.toString();
  }

  getCurrentConversationId() {
    return currentConversationId;
  }
}

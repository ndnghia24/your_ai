class Message {
  final String content;
  final String assistantId;
  final String assistantModel;
  final bool isFromUser;

  Message({
    required this.content,
    required this.assistantId,
    required this.assistantModel,
    this.isFromUser = false,
  });

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      isFromUser: map['role'] == 'user' ? true : false,
      content: map['content'],
      assistantId: map['assistant']['id'] ?? '',
      assistantModel: map['assistant']['model'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'role': isFromUser ? 'user' : 'model',
      'content': content,
      'assistant': {
        'id': assistantId,
        'model': assistantModel,
      },
    };
  }

  String toMapString() {
    return '{ "role": "${isFromUser ? 'user' : 'model'}", "content": "$content", "assistant": { "id": "$assistantId", "model": "$assistantModel" } }';
  }
}

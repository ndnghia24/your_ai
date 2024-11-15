import 'package:your_ai/features/chat_ai/domain/entities/message.dart';

class Conversation {
  final String id;
  final List<Message> messages;

  Conversation({
    required this.id,
    required this.messages,
  });

  factory Conversation.fromMap(Map<String, dynamic> map) {
    return Conversation(
      id: map['id'],
      messages:
          List<Message>.from(map['messages']?.map((x) => Message.fromMap(x))),
    );
  }

  Map<String, dynamic> toMap() {
    if (id == '-1') {
      return {
        'messages': [],
      };
    }

    return {
      'id': id,
      'messages': messages.map((x) => x.toMap()).toList(),
    };
  }

  String toMapString() {
    return '{ "id": "$id", "messages": [${messages.map((x) => x.toMapString()).join(', ')}] }';
  }
}

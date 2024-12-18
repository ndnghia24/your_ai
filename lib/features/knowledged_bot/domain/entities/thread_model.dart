import 'message_model.dart';

class Thread {
  final String id;
  final List<Message> messages;
  final DateTime createdAt;
  final DateTime updatedAt;

  Thread({
    required this.id,
    required this.messages,
    required this.createdAt,
    required this.updatedAt,
  });

  // Convert Thread to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'messages': messages?.map((message) => message.toMap()).toList(),
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  // Create Thread from Map
  factory Thread.fromMap(Map<String, dynamic> map) {
    return Thread(
      id: map['id'],
      messages: map['messages'] != null
          ? (map['messages'] as List<dynamic>)
              .map((message) => Message.fromMap(message))
              .toList()
          : [],
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt']),
    );
  }

  static Thread initial() {
    return Thread(
      id: '',
      messages: [],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  toMapString() {
    return {
      'id': id,
    }.toString();
  }
}

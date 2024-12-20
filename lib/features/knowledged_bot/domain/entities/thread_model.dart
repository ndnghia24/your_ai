import 'message_model.dart';

class Thread {
  final String id;
  final String threadName;
  final String openAiThreadId;
  final List<Message> messages;

  Thread({
    required this.id,
    required this.threadName,
    required this.openAiThreadId,
    required this.messages,
  });

  // Convert Thread to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'threadName': threadName,
      'openAiThreadId': openAiThreadId,
      'messages': messages.map((message) => message.toMap()).toList(),
    };
  }

  // Create Thread from Map
  factory Thread.fromMap(Map<String, dynamic> map) {
    return Thread(
      id: map['id'],
      threadName: map['threadName'],
      openAiThreadId: map['openAiThreadId'],
      messages: map['messages'] != null
          ? (map['messages'] as List<dynamic>)
              .map((message) => Message.fromMap(message))
              .toList()
          : [],
    );
  }

  factory Thread.fromDetailMap(
      Thread currentThread, List<Map<String, dynamic>> map) {
    return Thread(
      id: currentThread.id,
      threadName: currentThread.threadName,
      openAiThreadId: currentThread.openAiThreadId,
      messages: map.map((message) => Message.fromMap(message)).toList(),
    );
  }

  static Thread initial() {
    return Thread(
      id: '',
      threadName: '',
      openAiThreadId: '',
      messages: [],
    );
  }

  toMapString() {
    return {
      'id': id,
    }.toString();
  }
}

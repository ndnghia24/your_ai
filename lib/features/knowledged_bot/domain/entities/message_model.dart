import 'content_model.dart';

class Message {
  final String id;
  final String role;
  final DateTime createdAt;
  final List<Content> content;

  Message({
    required this.id,
    required this.role,
    required this.createdAt,
    required this.content,
  });

  // Convert Message to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'role': role,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'content': content.map((c) => c.toMap()).toList(),
    };
  }

  // Create Message from Map
  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: map['id'],
      role: map['role'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      content: (map['content'] as List<dynamic>)
          .map((c) => Content.fromMap(c))
          .toList(),
    );
  }
}

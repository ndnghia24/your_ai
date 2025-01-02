import 'content_model.dart';

class Message {
  final String role;
  final List<Content> content;

  Message({
    required this.role,
    required this.content,
  });

  // Convert Message to Map
  Map<String, dynamic> toMap() {
    return {
      'role': role,
      'content': content.map((c) => c.toMap()).toList(),
    };
  }

  // Create Message from Map
  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      role: map['role'],
      content: (map['content'] as List<dynamic>)
          .map((c) => Content.fromMap(c))
          .toList(),
    );
  }
}

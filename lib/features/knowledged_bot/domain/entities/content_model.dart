class Content {
  final String type;
  final TextContent? text;

  Content({
    required this.type,
    this.text,
  });

  // Convert Content to Map
  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'text': text?.toMap(),
    };
  }

  // Create Content from Map
  factory Content.fromMap(Map<String, dynamic> map) {
    return Content(
      type: map['type'],
      text: map['text'] != null ? TextContent.fromMap(map['text']) : null,
    );
  }
}

class TextContent {
  final String value;

  TextContent({
    required this.value,
  });

  Map<String, dynamic> toMap() {
    return {
      'value': value,
      'annotations': [],
    };
  }

  factory TextContent.fromMap(Map<String, dynamic> map) {
    return TextContent(
      value: map['value'],
    );
  }
}

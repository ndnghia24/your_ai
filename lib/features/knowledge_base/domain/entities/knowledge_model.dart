class KnowledgeBase {
  final String id;
  final String knowledgeName;
  final String description;

  KnowledgeBase({
    required this.id,
    required this.knowledgeName,
    required this.description,
  });

  factory KnowledgeBase.fromMap(Map<String, dynamic> map) {
    return KnowledgeBase(
      id: map['id'],
      knowledgeName: map['knowledgeName'],
      description: map['description'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'knowledgeName': knowledgeName,
      'description': description,
    };
  }

  static initial() {
    return KnowledgeBase(
      id: '',
      knowledgeName: '',
      description: '',
    );
  }
}

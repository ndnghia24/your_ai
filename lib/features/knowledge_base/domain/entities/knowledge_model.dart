class Knowledge {
  final String id;
  final String knowledgeName;
  final String description;

  Knowledge({
    required this.id,
    required this.knowledgeName,
    required this.description,
  });

  factory Knowledge.fromMap(Map<String, dynamic> map) {
    return Knowledge(
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
    return Knowledge(
      id: '',
      knowledgeName: '',
      description: '',
    );
  }
}

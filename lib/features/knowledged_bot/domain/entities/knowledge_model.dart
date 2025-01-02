class Knowledge {
  final String id;
  final String knowledgeName;
  final String description;
  final int numUnits;
  final int totalSize;
  final bool isImported;

  Knowledge({
    required this.id,
    required this.knowledgeName,
    required this.description,
    this.numUnits = 0,
    this.totalSize = 0,
    this.isImported = false,

  });

  factory Knowledge.fromMap(Map<String, dynamic> map) {
    return Knowledge(
      id: map['id'],
      knowledgeName: map['knowledgeName'],
      description: map['description'],
      numUnits: map['numUnits'],
      totalSize: map['totalSize'],
      isImported: map['isImported'],

    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'knowledgeName': knowledgeName,
      'description': description,
      'numUnits': numUnits,
      'totalSize': totalSize,
      'isImported': isImported,

    };
  }

  static initial() {
    return Knowledge(
      id: '',
      knowledgeName: '',
      description: '',
      numUnits: 0,
      totalSize: 0,
      isImported: false,
    );
  }
}

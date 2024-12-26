import 'package:your_ai/features/knowledged_bot/data/repositories/assistant_repository.dart';

class Assistant {
  final String id;
  final String name;
  final String description;
  late bool isFavorite;
  late bool isPublished;
  late String instructions;

  Assistant({
    required this.id,
    required this.name,
    required this.description,
    this.isFavorite = false,
    this.isPublished = false,
    this.instructions = '',
  });

  factory Assistant.fromMap(Map<String, dynamic> map) {
    return Assistant(
      id: map['id'] ?? '',
      name: map['assistantName'] ?? '',
      description: map['description'] ?? '',
      isFavorite: map['is_favorite'] ?? false,
      isPublished: map['is_published'] ?? false,
      instructions: map['instructions'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'is_favorite': isFavorite,
      'is_published': isPublished,
      'instructions': instructions,
    };
  }

  static Assistant initial() {
    return Assistant(
      id: '',
      name: '',
      description: '',
      isFavorite: false,
      isPublished: false,
      instructions: '',
    );
  }

  toMapString() {
    return 'id: $id, name: $name, description: $description';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Assistant &&
        other.id == id &&
        other.name == name &&
        other.description == description &&
        other.isFavorite == isFavorite &&
        other.isPublished == isPublished &&
        other.instructions == instructions;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        isFavorite.hashCode ^
        isPublished.hashCode ^
        instructions.hashCode;
  }
}
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
}

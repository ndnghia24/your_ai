import 'package:your_ai/features/knowledged_bot/data/repositories/assistant_repository.dart';

class Assistant {
  final String id;
  final String name;
  final String description;
  final bool isFavorite;
  final bool isPublished;

  Assistant({
    required this.id,
    required this.name,
    required this.description,
    required this.isFavorite,
    required this.isPublished,
  });

  factory Assistant.fromMap(Map<String, dynamic> map) {
    return Assistant(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      isFavorite: map['is_favorite'] ?? false,
      isPublished: map['is_published'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'is_favorite': isFavorite,
      'is_published': isPublished,
    };
  }

  static Assistant initial() {
    return Assistant(
      id: '',
      name: '',
      description: '',
      isFavorite: false,
      isPublished: false,
    );
  }

  toMapString() {
    return 'id: $id, name: $name, description: $description';
  }
}

import 'package:your_ai/features/knowledged_bot/data/repositories/assistant_repository.dart';

class Assistant {
  final String id;
  final String name;
  final String description;
  final bool isFavorite;
  final bool isPublished;
  final AssistantRepository _repository;

  Assistant({
    required this.id,
    required this.name,
    required this.description,
    required this.isFavorite,
    required this.isPublished,
    required AssistantRepository repository,
  }) : _repository = repository;

  // Chuyển đổi từ Map (JSON) sang đối tượng Assistant
  factory Assistant.fromMap(
      Map<String, dynamic> map, AssistantRepository repository) {
    return Assistant(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      isFavorite: map['is_favorite'] ?? false,
      isPublished: map['is_published'] ?? false,
      repository: repository,
    );
  }

  // Chuyển đổi từ đối tượng Assistant sang Map (JSON)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'is_favorite': isFavorite,
      'is_published': isPublished,
    };
  }

  // Xem knowledge đã được gắn với assistant
  Future<void> getAttachedKnowledges() async {
    try {
      final result = await _repository.getAttachedKnowledges(assistantId: id);
      print('Attached knowledges: $result');
    } catch (e) {
      throw Exception('Failed to get attached knowledges: $e');
    }
  }

  // Thêm knowledge
  Future<void> addKnowledge(String knowledgeId) async {
    try {
      await _repository.attachKnowledge(
          assistantId: id, knowledgeId: knowledgeId);
      print('Knowledge $knowledgeId attached to assistant $id');
    } catch (e) {
      throw Exception('Failed to add knowledge: $e');
    }
  }

  // Gỡ knowledge
  Future<void> removeKnowledge(String knowledgeId) async {
    try {
      await _repository.detachKnowledge(
          assistantId: id, knowledgeId: knowledgeId);
      print('Knowledge $knowledgeId detached from assistant $id');
    } catch (e) {
      throw Exception('Failed to remove knowledge: $e');
    }
  }
}

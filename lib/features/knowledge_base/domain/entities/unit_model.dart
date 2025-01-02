// Vị trí: lib/features/knowledge_base/domain/entities/unit_model.dart

class UnitModel {
  final String id;
  final String name;
  final bool status;
  final String knowledgeId;

  UnitModel({
    required this.id,
    required this.name,
    required this.status,
    required this.knowledgeId,
  });

  // Factory constructor để chuyển JSON thành UnitModel
  factory UnitModel.fromMap(Map<String, dynamic> json) {
    return UnitModel(
      id: json['id'] as String,
      name: json['name'] as String,
      status: json['status'] as bool,
      knowledgeId: json['knowledgeId'] as String,
    );
  }

  // Phương thức để chuyển UnitModel thành JSON
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'knowledgeId': knowledgeId,
    };
  }
}

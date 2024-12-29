import 'package:equatable/equatable.dart';
import 'package:your_ai/features/knowledge_base/domain/entities/knowledge_model.dart';


abstract class KBEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetAllKBEvent extends KBEvent {
  GetAllKBEvent();
}

class CreateKBEvent extends KBEvent {
  final String knowledgeName;
  final String description;
  final List<KnowledgeBase> knowledgeBases;

  CreateKBEvent(this.knowledgeName, this.description, this.knowledgeBases);
}

class UpdateKBEvent extends KBEvent {
  final String id;
  final String knowledgeName;
  final String description;
  final List<KnowledgeBase> knowledgeBases;
  UpdateKBEvent(this.id, this.knowledgeName, this.description, this.knowledgeBases);
}

class DeleteKBEvent extends KBEvent {
  final String id;
  final List<KnowledgeBase> knowledgeBases;
  DeleteKBEvent(this.id, this.knowledgeBases);
}

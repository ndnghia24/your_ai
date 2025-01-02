import 'package:equatable/equatable.dart';
import 'package:your_ai/features/knowledged_bot/domain/entities/knowledge_model.dart';



abstract class KBEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetAllKBEvent extends KBEvent {
  final String assistantId;
  GetAllKBEvent(this.assistantId);
}

class AttachKBEvent extends KBEvent {
  final String assistantId;
  final String knowledgeId;
  final List<Knowledge> knowledgeBases;
  AttachKBEvent(this.assistantId, this.knowledgeId, this.knowledgeBases);
}

class DetachKBEvent extends KBEvent {
  final String assistantId;
  final String knowledgeId;
  final List<Knowledge> knowledgeBases;
  DetachKBEvent(this.assistantId, this.knowledgeId, this.knowledgeBases);
}

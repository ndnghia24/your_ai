import 'package:equatable/equatable.dart';
import 'package:your_ai/features/knowledge_base/domain/entities/knowledge_model.dart';



abstract class KBState extends Equatable {
  @override
  List<Object?> get props => [];
}

class KBInitial extends KBState {}

class KBLoading extends KBState {
  List<KnowledgeBase> knowledgeBases;
  String message;

  KBLoading(
      {required this.knowledgeBases,
      this.message = ''});

  @override
  List<Object?> get props => [knowledgeBases, message];
}

class KBLoaded extends KBState {
  final List<KnowledgeBase> knowledgeBases;


  KBLoaded(this.knowledgeBases);

  @override
  List<Object?> get props => [knowledgeBases];
}

class KBError extends KBState {
  final String message;
  final List<KnowledgeBase>? knowledgeBases;


  KBError(this.message, {this.knowledgeBases});

  @override
  List<Object?> get props => [message];
}

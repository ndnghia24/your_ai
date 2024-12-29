import 'package:equatable/equatable.dart';
import 'package:your_ai/features/knowledge_base/domain/entities/unit_model.dart';



abstract class UnitEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetAllUnitEvent extends UnitEvent {
  final String id;
  GetAllUnitEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class UploadUnitEvent extends UnitEvent {


  UploadUnitEvent();


}

class DeleteUnitEvent extends UnitEvent {
  final String knowledgeId;
  final String id;
  final List<UnitModel> units;
  DeleteUnitEvent(this.knowledgeId, this.id, this.units);

  @override
  List<Object?> get props => [id, knowledgeId, units];
}




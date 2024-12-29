import 'package:equatable/equatable.dart';
import 'package:your_ai/features/knowledge_base/domain/entities/knowledge_model.dart';
import 'package:your_ai/features/knowledge_base/domain/entities/unit_model.dart';

abstract class UnitState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UnitInitial extends UnitState {}

class UnitLoading extends UnitState {
  List<UnitModel> units;
  String message;

  UnitLoading(
      {required this.units,
      this.message = ''});

  @override
  List<Object?> get props => [units, message];
}

class UnitLoaded extends UnitState {
  final List<UnitModel> units;


  UnitLoaded(this.units);

  @override
  List<Object?> get props => [units];
}

class UnitError extends UnitState {
  final String message;
  final List<UnitModel>? units;


  UnitError(this.message, {this.units});

  @override
  List<Object?> get props => [message];
}

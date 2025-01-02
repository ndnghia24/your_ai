import 'package:equatable/equatable.dart';

abstract class TokenState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TokenInitial extends TokenState {}

class TokenLoading extends TokenState {}

class TokenLoaded extends TokenState {
  final int remainingQuery;
  final int totalQuery;

  TokenLoaded(this.remainingQuery, this.totalQuery);

  @override
  List<Object?> get props => [remainingQuery, totalQuery];
}

class TokenError extends TokenState {
  final String message;

  TokenError(this.message);

  @override
  List<Object?> get props => [message];
}

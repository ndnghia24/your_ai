import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final Map<String, dynamic> userInfo;

  AuthAuthenticated(this.userInfo);

  @override
  List<Object?> get props => [userInfo];
}

class AuthUnauthenticated extends AuthState {
  final String message;

  AuthUnauthenticated(this.message);

  @override
  List<Object?> get props => [message];
}

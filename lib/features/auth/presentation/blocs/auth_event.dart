import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  LoginEvent(this.email, this.password);
}

class GoogleLoginEvent extends AuthEvent {
  final String googleToken;

  GoogleLoginEvent(this.googleToken);
}

class LogoutEvent extends AuthEvent {}

class CheckAuthStatusEvent extends AuthEvent {}

class SignUpEvent extends AuthEvent {
  final String email;
  final String password;
  final String username;

  SignUpEvent(this.email, this.password, this.username);
}

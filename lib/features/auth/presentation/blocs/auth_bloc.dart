import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/auth_usecases_factory.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUseCaseFactory authUseCaseFactory;

  AuthBloc(this.authUseCaseFactory) : super(AuthInitial()) {
    on<LoginEvent>(_onLogin);
    on<SignUpEvent>(_onSignUp);
  }

  Future<Map<String, dynamic>> getUserInfo() async {
    return await authUseCaseFactory.getUserInfoUseCase.execute();
  }

  FutureOr<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await authUseCaseFactory.loginUseCase
          .execute(event.email, event.password);
      emit(AuthSuccess("Login successful"));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  FutureOr<void> _onSignUp(SignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await authUseCaseFactory.signUpUseCase
          .execute(event.email, event.password, event.username);
      emit(AuthSuccess("Sign up successful"));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}

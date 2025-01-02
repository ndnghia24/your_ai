import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:your_ai/core/utils/ga4_service.dart';
import '../../domain/auth_usecases_factory.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUseCaseFactory authUseCaseFactory;

  get getAuthUseCaseFactory => authUseCaseFactory;

  AuthBloc(this.authUseCaseFactory) : super(AuthLoading()) {
    on<LoginEvent>(_onLogin);
    on<GoogleLoginEvent>(_onGoogleLoginEvent);
    on<SignUpEvent>(_onSignUp);
    on<LogoutEvent>(_onLogout);
    on<CheckAuthStatusEvent>(_onCheckAuthStatus);
  }

  FutureOr<void> _onCheckAuthStatus(
      CheckAuthStatusEvent event, Emitter<AuthState> emit) async {
    try {
      final result = await authUseCaseFactory.getUserInfoUseCase.execute();

      if (result['isSuccess']) {
        GetIt.I.get<GA4Service>().userId = result['data']['email'];
        emit(AuthAuthenticated(result['data']));
      } else {
        emit(AuthUnauthenticated('User not logged in'));
      }
    } catch (e) {
      emit(AuthUnauthenticated("Failed to check auth status: ${e.toString()}"));
    }
  }

  FutureOr<void> _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    try {
      final result = await authUseCaseFactory.logoutUseCase.execute();
      if (result['isSuccess']) {
        emit(AuthUnauthenticated("User logged out"));
      }
    } catch (e) {
      // Handle error as needed
      emit(AuthUnauthenticated("Logout failed: ${e.toString()}"));
    }
  }

  FutureOr<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final result = await authUseCaseFactory.loginUseCase
          .execute(event.email, event.password);

      if (result['isSuccess']) {
        final userInfo = await authUseCaseFactory.getUserInfoUseCase.execute();
        emit(AuthAuthenticated(userInfo['data']));
      } else {
        emit(AuthUnauthenticated("Wrong email or password"));
      }
    } catch (e) {
      emit(AuthUnauthenticated("Login failed: ${e.toString()}"));
    }
  }

  FutureOr<void> _onGoogleLoginEvent(
      GoogleLoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final result = await authUseCaseFactory.googleLoginUseCase
          .execute(event.googleToken);
      if (result['isSuccess']) {
        final userInfo = await authUseCaseFactory.getUserInfoUseCase.execute();
        GetIt.I.get<GA4Service>().userId = userInfo['data']['email'];
        emit(AuthAuthenticated(userInfo['data']));
      } else {
        emit(AuthUnauthenticated("Google login failed"));
      }
    } catch (e) {
      emit(AuthUnauthenticated("Google login failed: ${e.toString()}"));
    }
  }

  FutureOr<void> _onSignUp(SignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final result = await authUseCaseFactory.signUpUseCase
          .execute(event.email, event.password, event.username);

      if (result['isSuccess']) {
        emit(AuthUnauthenticated("Sign up success"));
      } else {
        emit(AuthUnauthenticated(result['data']));
      }
    } catch (e) {
      emit(AuthUnauthenticated("Sign up failed: ${e.toString()}"));
    }
  }

  checkAuthentication() {
    add(CheckAuthStatusEvent());
  }
}

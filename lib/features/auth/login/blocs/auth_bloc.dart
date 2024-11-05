import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is LoginEvent) {
      yield AuthLoading();
      // Simulate a login process
      await Future.delayed(Duration(seconds: 2));
      if (event.email == 'test@example.com' && event.password == 'password') {
        yield AuthSuccess();
      } else {
        yield AuthFailure('Invalid email or password');
      }
    } else if (event is SignUpEvent) {
      yield AuthLoading();
      // Simulate a signup process
      await Future.delayed(Duration(seconds: 2));
      yield AuthSuccess(); // Or handle signup failure
    }
  }
}

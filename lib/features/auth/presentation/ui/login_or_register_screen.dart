import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'package:your_ai/features/auth/domain/auth_usecases_factory.dart';
import '../blocs/auth_bloc.dart';

import 'login_screen_stateless.dart';
import 'register_screen_stateless.dart';

final getIt = GetIt.instance;

class LoginOrRegisterScreen extends StatefulWidget {
  const LoginOrRegisterScreen({super.key});

  @override
  State<LoginOrRegisterScreen> createState() => _LoginOrRegisterScreenState();
}

class _LoginOrRegisterScreenState extends State<LoginOrRegisterScreen> {
  bool showLoginScreen = true;

  void toogleScreens() {
    setState(() {
      showLoginScreen = !showLoginScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => getIt<AuthBloc>(),
        ),
      ],
      child: showLoginScreen
          ? LoginScreen(onTap: toogleScreens)
          : RegisterScreen(onTap: toogleScreens),
    ));
  }
}

import 'package:flutter/material.dart';
import 'package:your_ai/features/auth/login/presentation/login_screen_stateless.dart';
import 'package:your_ai/features/auth/login/presentation/register_screen_stateless.dart';

class LoginOrRegisterScreen extends StatefulWidget {
  const LoginOrRegisterScreen({super.key});

  @override
  State<LoginOrRegisterScreen> createState() => _LoginOrRegisterScreenState();
}

class _LoginOrRegisterScreenState extends State<LoginOrRegisterScreen> {
  // initially show login screen
  bool showLoginScreen = true;

  void toogleScreens() {
    setState(() {
      showLoginScreen = !showLoginScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginScreen) {
      return LoginScreen(onTap: toogleScreens);
    } else {
      return RegisterScreen(onTap: toogleScreens);
    }
  }
}

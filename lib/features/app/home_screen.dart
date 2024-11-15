import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../chat_ai/presentation/ui/new_chat_session_screen.dart';

class HomeScreen extends StatelessWidget {
  late ColorScheme screenColorScheme;

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    screenColorScheme = Theme.of(context).colorScheme;

    return ChatSessionScreen();
  }
}

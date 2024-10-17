import 'package:flutter/material.dart';
import 'package:jarvis_ai/screens/chatbot_preview_screen.dart';
import 'package:jarvis_ai/screens/chatbot_screen.dart';
import 'package:jarvis_ai/screens/knowledgebase_detail_screen.dart';
import 'package:jarvis_ai/screens/knowledgebase_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: const TextTheme(
          headlineSmall: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          headlineMedium: TextStyle(color: Colors.grey),
        ),
        useMaterial3: true,
      ),
      home: KnowledgeDetailScreen(),
    );
     
  }
}


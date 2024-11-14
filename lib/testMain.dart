import 'package:flutter/material.dart';

import 'features/auth/test.dart';
import 'features/chat_ai/test.dart';
import 'features/chat_prompt/test.dart';

class AllTestScreen extends StatelessWidget {
  const AllTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // button to navigate to TestAuthScreen, TestChatAIScreen, ...

    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TestAuthScreen()),
              );
            },
            child: Text('Test Auth Screen'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TestChatAIScreen()),
              );
            },
            child: Text('Test Chat AI Screen'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TestChatPromptScreen()),
              );
            },
            child: Text('Test Prompt Screen'),
          ),
        ],
      )),
    );
  }
}

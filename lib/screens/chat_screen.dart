import 'package:flutter/material.dart';
import 'package:jarvis_ai/widgets/popup_menu_widget.dart';
import 'package:jarvis_ai/screens/home_screen.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      drawer: FractionallySizedBox(
        widthFactor: 0.75, // Chiều rộng của Drawer là 3/4 chiều rộng màn hình
        child: PopupMenuWidget(),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildUserMessage('Hi, what’s your name?'),
                const SizedBox(height: 16),
                _buildBotMessage(
                  'I\'m an AI language model created by OpenAI, and I don\'t have a personal name. You can just call me "Assistant." How can I assist you today?',
                ),
              ],
            ),
          ),
          _buildInputField(),
        ],
      ),
    );
  }
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Builder(
        builder: (context) => Row(
          children: [
            IconButton(
              icon: Icon(Icons.menu, color: Colors.black),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
            SizedBox(width: 8),
            CircleAvatar(
              backgroundColor: Colors.green,
              radius: 12,
              child: Icon(Icons.bolt, color: Colors.white, size: 16),
            ),
            SizedBox(width: 8),
            Text(
              'GPT-3.5 Turbo',
              style: TextStyle(color: Colors.black),
            ),
            Icon(Icons.arrow_drop_down, color: Colors.black),
            Spacer(),
            Icon(Icons.water_drop, color: Colors.blue),
            Text(
              '30',
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(width: 8),
            IconButton(
              icon: Icon(Icons.add, color: Colors.black),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }

  Widget _buildUserMessage(String message) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildBotMessage(String message) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(message),
      ),
    );
  }

  Widget _buildInputField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Ask me anything...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          CircleAvatar(
            backgroundColor: Colors.blue,
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white),
              onPressed: () {
                // Handle send action
              },
            ),
          ),
        ],
      ),
    );
  }
}

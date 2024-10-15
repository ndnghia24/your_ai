import 'package:flutter/material.dart';



class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.menu, color: Colors.black),
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
            Icon(Icons.add, color: Colors.black),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
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

  Widget _buildUserMessage(String message) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blueAccent.withOpacity(0.2),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(12),
        child: Text(message),
      ),
    );
  }

  Widget _buildBotMessage(String message) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CircleAvatar(
          backgroundColor: Colors.green,
          radius: 12,
          child: Icon(Icons.bolt, color: Colors.white, size: 16),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'GPT-3.5 Turbo',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(message),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.copy, size: 16),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.refresh, size: 16),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInputField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Ask me anything...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
          ),
          const SizedBox(width: 8),
          CircleAvatar(
            radius: 24,
            backgroundColor: Colors.blue,
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
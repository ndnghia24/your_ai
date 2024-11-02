import 'package:flutter/material.dart';
import 'package:your_ai/features/chat_bot/widgets/chatbot_preview_screen.dart';
import 'package:your_ai/features/chat_bot/widgets/popup_new_chatbot.dart';
import 'package:your_ai/features/chat_ai/widgets/widget_app_drawer.dart';

class ChatBotScreen extends StatelessWidget {
  const ChatBotScreen({super.key});

  void showNewChatBotDialog(BuildContext context) {
    // Hiển thị popup khi nhấn nút "New"
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CreateAssistantDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text('T'),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bots',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Icon(Icons.chat),
                ),
                title: Text('Test chat bot'),
                subtitle: Text('This is a chat bot.'),
                trailing: Wrap(
                  spacing: 12,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.star_border),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.delete_outline),
                      onPressed: () {},
                    ),
                  ],
                ),
                onTap: () {
                  // Navigate to ChatBotPreviewScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChatBotPreviewScreen()),
                  );
                },
              ),
            ),
            Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                onPressed: () {
                  // Action to create new bot
                  showNewChatBotDialog(context);
                },
                backgroundColor: Colors.blue,
                child: Icon(Icons.add),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

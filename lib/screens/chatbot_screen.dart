import 'package:flutter/material.dart';
import 'package:jarvis_ai/screens/chatbot_preview_screen.dart';
import 'package:jarvis_ai/widgets/chatbot/new_chatbot_popup.dart';
import 'package:jarvis_ai/widgets/app_drawer_widget.dart';

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
        title: Text('Bots'),
      ),
      drawer: AppDrawerWidget(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search, color: Theme.of(context).primaryColor),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Theme.of(context).primaryColor),
                ),
              ),
            ),
            SizedBox(height: 10),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor,
                  child: Icon(Icons.chat, color: Colors.white),
                ),
                title: Text('Test chat bot'),
                subtitle: Text('This is a chat bot.'),
                trailing: Wrap(
                  spacing: 12,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.star_border, color: Theme.of(context).primaryColor),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.delete_outline, color: Theme.of(context).primaryColor),
                      onPressed: () {},
                    ),
                  ],
                ),
                onTap: () {
                  // Navigate to ChatBotPreviewScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChatBotPreviewScreen()),
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
                backgroundColor: Theme.of(context).primaryColor,
                child: Icon(Icons.add),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

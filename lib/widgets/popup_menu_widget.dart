import 'package:flutter/material.dart';
import 'package:jarvis_ai/screens/chatbot_screen.dart';
import 'package:jarvis_ai/screens/history_screen.dart';
import 'package:jarvis_ai/screens/knowledgebase_screen.dart';

class PopupMenuWidget extends StatelessWidget {
  const PopupMenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/google_logo.png'), // Add your logo asset
                  radius: 24,
                ),
                SizedBox(width: 8),
                Text(
                  'Jarvis',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ],
            ),
          ),
          _buildChatItem(
            label: 'Assistance Inquiry',
            time: '09:00',
            isCurrent: true,
          ),
          _buildChatItem(
            label: 'Redimensionnez vo...',
            time: '08:20',
          ),
          _buildChatItem(
            label: 'Assistance Inquiry',
            time: '17 Sep',
          ),
          _buildChatItem(
            label: 'Assistance Inquiry',
            time: '23 Aug',
          ),
          const Divider(),
          _buildMenuOption(Icons.chat_bubble, 'All chats', () {
            //Navigate to History screen
            Navigator.push(context, MaterialPageRoute(builder: (context) => HistoryScreen()));
          }),
          _buildMenuOption(Icons.smart_toy, 'Chat bots', () {
            //Navigate to Chat bots screen
            Navigator.push(context, MaterialPageRoute(builder: (context) => ChatBotScreen()));
          }),
          _buildMenuOption(Icons.book, 'Knowledge base', () {
            //Navigate to Knowledge base screen
            Navigator.push(context, MaterialPageRoute(builder: (context) => KnowledgeBaseScreen()));
          }),
        ],
      ),
    );
  }

  Widget _buildChatItem({required String label, required String time, bool isCurrent = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if (isCurrent)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'Current',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    if (isCurrent) const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        label,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const Text(
                  'Hei! Kuinka voin auttaa sinua tänään?',
                  style: TextStyle(color: Colors.grey),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Text(time, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildMenuOption(IconData icon, String label, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      trailing: const Icon(Icons.arrow_forward),
      onTap: onTap,
    );
  }
} 
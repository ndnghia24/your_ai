import 'package:flutter/material.dart';
import 'package:jarvis_ai/helper/CustomTextStyles.dart';
import 'package:jarvis_ai/screens/chatbot_screen.dart';
import 'package:jarvis_ai/screens/history_screen.dart';
import 'package:jarvis_ai/screens/home_screen.dart';
import 'package:jarvis_ai/screens/knowledgebase_screen.dart';
import 'package:jarvis_ai/widgets/authentication_widget.dart';

import '../helper/CustomColors.dart';

class AppDrawerWidget extends StatelessWidget {
  const AppDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.blue,
            padding: EdgeInsets.only(top: 40, bottom: 24, left: 16, right: 16),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(
                      'assets/yourai_logo.png'), // Add your logo asset
                  radius: 24,
                ),
                SizedBox(width: 8),
                Text(
                  'YourAI',
                  style: TextStyle(
                      fontSize: CustomTextStyles.displayMedium.fontSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            ),
          ),
          _buildMenuOption(Icons.add_comment, 'New Chat', () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
          }),
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
          _buildMenuOption(Icons.chat_bubble, 'All chats', () {
            //Navigate to History screen
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => HistoryScreen()));
          }),
          _buildMenuOption(Icons.smart_toy, 'Chat bots', () {
            //Navigate to Chat bots screen
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => ChatBotScreen()));
          }),
          _buildMenuOption(Icons.book, 'Knowledge base', () {
            //Navigate to Knowledge base screen
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => KnowledgeBaseScreen()));
          }),
          Spacer(), // Đẩy footer xuống cuối cùng
          Divider(),
          AuthenticationWidget(),
        ],
      ),
    );
  }

  Widget _buildChatItem(
      {required String label, required String time, bool isCurrent = false}) {
    return Column(
      children: [
        Padding(
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
                            padding: const EdgeInsets.symmetric(
                                horizontal: 4, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              'Current',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                        if (isCurrent) const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            label,
                            style: TextStyle(
                                fontSize:
                                    CustomTextStyles.captionMedium.fontSize,
                                fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Hei! Kuinka voin auttaa sinua tänään?',
                      style: TextStyle(
                          fontSize: CustomTextStyles.captionSmall.fontSize,
                          color: Colors.grey),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Text(time, style: const TextStyle(color: Colors.grey)),
            ],
          ),
        ),
        const Divider(indent: 12, endIndent: 12),
      ],
    );
  }

  Widget _buildMenuOption(IconData icon, String label, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label,
          style: TextStyle(
              fontSize: CustomTextStyles.captionLarge.fontSize,
              fontWeight: FontWeight.bold,
              color: CustomColors.textDarkGrey)),
      trailing: const Icon(Icons.arrow_forward),
      onTap: onTap,
    );
  }
}

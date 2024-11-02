import 'package:flutter/material.dart';
import 'package:your_ai/utils/CustomTextStyles.dart';
import 'package:your_ai/features/chat_bot/chatbot_screen.dart';
import 'package:your_ai/features/chat_ai/widgets/chat_history_screen.dart';
import 'package:your_ai/features/app/home_screen.dart';
import 'package:your_ai/features/knowledge_base/knowledgebase_screen.dart';
import 'package:your_ai/features/chat_ai/widgets/widget_authentication.dart';

class AppDrawerWidget extends StatelessWidget {
  const AppDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var screenColorScheme = Theme.of(context).colorScheme;

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
                  backgroundImage: AssetImage('assets/yourai_logo.png'),
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
          _buildMenuOption(screenColorScheme, Icons.add_comment, 'New Chat',
              () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
          }),
          _buildChatItem(
            screenColorScheme: screenColorScheme,
            label: 'Assistance Inquiry',
            time: '09:00',
            isCurrent: true,
          ),
          _buildChatItem(
            screenColorScheme: screenColorScheme,
            label: 'Redimensionnez vo...',
            time: '08:20',
          ),
          _buildChatItem(
            screenColorScheme: screenColorScheme,
            label: 'Assistance Inquiry',
            time: '17 Sep',
          ),
          _buildChatItem(
            screenColorScheme: screenColorScheme,
            label: 'Assistance Inquiry',
            time: '23 Aug',
          ),
          _buildMenuOption(screenColorScheme, Icons.chat_bubble, 'All chats',
              () {
            //Navigate to History screen
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => HistoryScreen()));
          }),
          _buildMenuOption(screenColorScheme, Icons.smart_toy, 'Chat bots', () {
            //Navigate to Chat bots screen
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ChatBotScreen()));
          }),
          _buildMenuOption(screenColorScheme, Icons.book, 'Knowledge base', () {
            //Navigate to Knowledge base screen
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => KnowledgeBaseScreen()));
          }),
          Spacer(),
          Divider(),
          AuthenticationWidget(),
        ],
      ),
    );
  }

  Widget _buildChatItem(
      {required ColorScheme screenColorScheme,
      required String label,
      required String time,
      bool isCurrent = false}) {
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
                                color: screenColorScheme.onSecondary,
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

  Widget _buildMenuOption(ColorScheme screenColorScheme, IconData icon,
      String label, VoidCallback onTap) {
    return ListTile(
      leading: Icon(
        icon,
        color: screenColorScheme.secondary,
      ),
      title: Text(label,
          style: TextStyle(
              fontSize: CustomTextStyles.captionLarge.fontSize,
              fontWeight: FontWeight.bold,
              color: screenColorScheme.onSecondary)),
      trailing: const Icon(Icons.arrow_forward, color: Colors.grey),
      onTap: onTap,
    );
  }
}

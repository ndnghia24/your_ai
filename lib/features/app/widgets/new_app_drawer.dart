import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../chat_ai/presentation/ui/widgets/widget_authentication.dart';
import '../../chat_bot/presentation/chatbot_screen.dart';
import '../../knowledge_base/knowledgebase_screen.dart';
import '../home_screen.dart';

class AppDrawerWidget extends StatefulWidget {
  const AppDrawerWidget({super.key});

  @override
  _AppDrawerWidgetState createState() => _AppDrawerWidgetState();
}

class _AppDrawerWidgetState extends State<AppDrawerWidget> {
  bool showAllChats = false;

  @override
  Widget build(BuildContext context) {
    final double horizontalPadding = 20;
    final double verticalPadding = 10;

    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.primary,
      child: Column(
        children: [
          DrawerHeader(
            child: Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/yourai_logo.png', height: 40),
                  SizedBox(width: 8),
                  Text(
                    'Your AI',
                    style: GoogleFonts.bebasNeue(fontSize: 35),
                  ),
                ],
              ),
            ),
          ),
          // Content
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: showAllChats
                      ? _buildAllChatsList()
                      : _buildDefaultContent(),
                ),
                showAllChats ? Container() : AuthenticationWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDefaultContent() {
    return ListView(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: ListTile(
              leading: Image.asset('assets/images/op_newchat.png', height: 20),
              title: Text(
                'NEW CHAT',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              }),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: ListTile(
            leading: Image.asset('assets/images/op_allchat.png', height: 25),
            title: Row(
              children: [
                Expanded(
                  child: Text(
                    'ALL CHAT',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ),
                Image.asset('assets/images/ic_next.png', height: 18)
              ],
            ),
            onTap: () {
              setState(() {
                showAllChats = true;
              });
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: ListTile(
            leading: Image.asset('assets/images/op_chatbot.png', height: 20),
            title: Text(
              'CHAT BOTS',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChatBotScreen()),
              );
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: ListTile(
            leading:
                Image.asset('assets/images/op_knowledgebase.png', height: 20),
            title: Text(
              'KNOWLEDGE BASE',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => KnowledgeBaseScreen()),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAllChatsList() {
    return Column(
      children: [
        ListTile(
          leading: Image.asset('assets/images/ic_back.png', height: 20),
          title: Text(
            'BACK',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          onTap: () {
            setState(() {
              showAllChats = false;
            });
          },
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Icon(Icons.chat_bubble),
                title: Text('Chat ${index + 1}'),
                onTap: () {
                  // Handle chat selection
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

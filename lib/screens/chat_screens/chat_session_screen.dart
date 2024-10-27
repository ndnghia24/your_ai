import 'package:flutter/material.dart';
import 'package:jarvis_ai/widgets/widget_app_drawer.dart';
import 'package:jarvis_ai/screens/home_screen.dart';
import 'package:jarvis_ai/widgets/shared/chat_input_widget.dart';
import 'package:jarvis_ai/widgets/shared/model_selector_widget.dart';

import '../../helper/CustomTextStyles.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String selectedModel = 'GPT-3.5 Turbo';

  // List of messages
  final List<Map<String, bool>> messages = [];

  // Callback function to update the selected model
  void updateSelectedModel(String newModel) {
    setState(() {
      selectedModel = newModel;
    });
  }

  @override
  Widget build(BuildContext context) {
    messages.clear();

    messages.add({'Hi, what’s your name?': false});
    messages.add({
      'I\'m an AI language model created by OpenAI, and I don\'t have a personal name. You can just call me "Assistant." How can I assist you today?':
          true
    });

    return Scaffold(
      appBar: _buildAppBar(context),
      drawer: FractionallySizedBox(
        widthFactor: 0.75,
        child: AppDrawerWidget(),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                for (final message in messages)
                  _buildMessage(message.keys.first, message.values.first),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 24),
            child: ChatInputWidget(),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      leading: Builder(
        builder: (context) => IconButton(
          icon: Icon(
            Icons.menu_sharp,
            color: Theme.of(context).colorScheme.onSecondary,
            size: CustomTextStyles.headlineLarge.fontSize,
          ),
          onPressed: () {
            FocusScope.of(context).unfocus();
            Scaffold.of(context).openDrawer(); // Opens the drawer
          },
        ),
      ),
      title: ModelSelector(
        selectedModel: selectedModel,
        onModelChanged: updateSelectedModel,
      ),
      actions: [
        Row(
          children: [
            TextButton.icon(
              onPressed: () {},
              style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.surface,
                overlayColor: Colors.transparent,
              ),
              icon: Icon(Icons.water_drop_outlined,
                  color: Theme.of(context).colorScheme.secondary),
              label: Text(
                '30',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: CustomTextStyles.captionLarge.fontSize,
                ),
              ),
            ),
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
            SizedBox(width: 8),
          ],
        ),
      ],
    );
  }

  Widget _buildMessage(String message, bool isFromAI) {
    return Align(
      alignment: isFromAI ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.fromLTRB(
            (!isFromAI ? 16 : 0), 0, (isFromAI ? 16 : 0), 10),
        padding: const EdgeInsets.all(12),
        decoration: isFromAI
            ? BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(90),
              )
            : BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(90),
              ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isFromAI
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          radius: 10,
                          backgroundColor:
                              Theme.of(context).colorScheme.surface,
                          child: Icon(
                            Icons.person,
                            color: Theme.of(context).colorScheme.onSecondary,
                            size: CustomTextStyles.captionLarge.fontSize,
                          ),
                        ),
                        SizedBox(width: 16),
                        Text(
                          'GPT-3.5 Turbo',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSecondary,
                            fontWeight: FontWeight.bold,
                            fontSize: CustomTextStyles.captionLarge.fontSize,
                          ),
                        ),
                      ],
                    ),
                  )
                : SizedBox(),
            Text(
              message,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSecondary,
                fontSize: CustomTextStyles.captionLarge.fontSize,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

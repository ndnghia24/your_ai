import 'package:flutter/material.dart';
import 'package:jarvis_ai/screens/chat_screen.dart';

import '../prompt_library_popup_widget.dart';

class ChatInputWidget extends StatefulWidget {
  const ChatInputWidget({super.key});

  @override
  _ChatInputWidgetState createState() => _ChatInputWidgetState();
}

class _ChatInputWidgetState extends State<ChatInputWidget> {
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          PopupMenuButton<int>(
            icon: Icon(Icons.add_circle_outline, color: Colors.blue, size: 40),
            onSelected: (value) {
              // Handle selected value
              switch (value) {
                case 0:
                  break;
                case 1:
                  break;
                case 2:
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(16)),
                    ),
                    builder: (context) => FractionallySizedBox(
                      heightFactor: 0.8, // Chiều cao bằng nửa màn hình
                      child: Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                        ),
                        child: const PromptLibraryPopupWidget(),
                      ),
                    ),
                  );
                  break;
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 0,
                child: Row(
                  children: [
                    Icon(Icons.camera_alt, color: Colors.black),
                    SizedBox(width: 8),
                    Text("Camera"),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 1,
                child: Row(
                  children: [
                    Icon(Icons.photo, color: Colors.black),
                    SizedBox(width: 8),
                    Text("Gallery"),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 2,
                child: Row(
                  children: [
                    Icon(Icons.auto_awesome, color: Colors.black),
                    SizedBox(width: 8),
                    Text("Prompt Library"),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(width: 4), // Reduced width to make input text longer
          Expanded(
            child: TextField(
              focusNode: _focusNode,
              maxLines: null, // Allow the text field to expand vertically
              decoration: InputDecoration(
                hintText: 'Ask me anything...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
          const SizedBox(width: 4), // Reduced width to make input text longer
          CircleAvatar(
            backgroundColor: Colors.blue,
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white),
              onPressed: () {
                _focusNode.unfocus();
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ChatScreen()));
              },
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:jarvis_ai/screens/chat_screen.dart';

class CustomChatInput extends StatefulWidget {
  const CustomChatInput({super.key});

  @override
  _CustomChatInputState createState() => _CustomChatInputState();
}

class _CustomChatInputState extends State<CustomChatInput> {
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
          IconButton(
            icon: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Theme.of(context).primaryColor),
              ),
              child: Icon(Icons.add, color: Theme.of(context).primaryColor),
            ),
            onPressed: () {
              // Add your logic to create a new chat here
            },
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
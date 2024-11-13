import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:your_ai/features/chat_prompt/presentation/ui/widgets/popup_prompt_library.dart';
import '../../chat_ai/presentation/ui/chat_session_screen.dart';

class ChatInputWidget extends StatelessWidget {
  const ChatInputWidget({super.key});

  void _onSendPressed(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => ChatScreen()));
  }

  void _onPopupMenuSelected(BuildContext context, int value) {
    switch (value) {
      case 0:
        // Handle camera selection
        break;
      case 1:
        // Handle gallery selection
        break;
      case 2:
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          builder: (context) => FractionallySizedBox(
            heightFactor: 0.8,
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
  }

  @override
  Widget build(BuildContext context) {
    var screenColorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: screenColorScheme.surfaceContainer,
      ),
      child: Row(
        children: [
          PopupMenuButton<int>(
            icon: Image.asset('assets/images/ic_more.png', height: 25),
            onSelected: (value) => _onPopupMenuSelected(context, value),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 0,
                child: Row(
                  children: const [
                    Icon(Icons.camera_alt, color: Colors.black),
                    SizedBox(width: 8),
                    Text("Camera"),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 1,
                child: Row(
                  children: const [
                    Icon(Icons.photo, color: Colors.black),
                    SizedBox(width: 8),
                    Text("Gallery"),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 2,
                child: Row(
                  children: const [
                    Icon(Icons.auto_awesome, color: Colors.black),
                    SizedBox(width: 8),
                    Text("Prompt Library"),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: TextField(
              maxLines: null,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade900,
              ),
              decoration: InputDecoration(
                hintText: 'Ask me anything...',
                hintStyle: TextStyle(color: Colors.grey.shade600),
                contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 4),

          /// Send Action
          GestureDetector(
            onTap: () => _onSendPressed(context),
            child: Image.asset('assets/images/ic_send.png', height: 20),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}

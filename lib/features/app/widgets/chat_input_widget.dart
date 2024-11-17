import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../chat_prompt/presentation/ui/prompt_library_popup.dart';


class ChatInputWidget extends StatelessWidget {
  final Function(String) onSubmitted;

  const ChatInputWidget({super.key, required this.onSubmitted});

  void _onSendPressed(BuildContext context, TextEditingController controller) {
    final text = controller.text;
    if (text.isNotEmpty) {
      onSubmitted(text);
      controller.clear();
    }
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
    final TextEditingController controller = TextEditingController();

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
              controller: controller,
              maxLines: 4,
              minLines: 1,
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
              onSubmitted: (text) {
                if (text.isNotEmpty) {
                  onSubmitted(text);
                  controller.clear();
                }
              },
            ),
          ),
          const SizedBox(width: 4),

          /// Send Action
          GestureDetector(
            onTap: () => _onSendPressed(context, controller),
            child: Image.asset('assets/images/ic_send.png', height: 20),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}
